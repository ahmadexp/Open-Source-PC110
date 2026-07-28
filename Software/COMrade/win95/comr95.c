/*
   COMR95 - the Win32 user-mode companion for COMRADE.

   This is deliberately a separate executable from the DOS TSR.  Windows 95
   can run a normal Win32 program, so serial I/O and desktop/file operations
   belong here instead of in a DOS interrupt hook.  The wire format is the
   CRC-16 frame used by the current bridge:

     [0xAB][type][req:2][len:2][payload][crc:2]

   COMR95 sends uncompressed replies.  The Python bridge accepts that form and
   continues to use the same FILE_*, DIR_*, KEY_* and SCREEN_* payloads as the
   DOS resident agent.
*/

#include <windows.h>

#define PROTO_VER       1
#define SYNC_CRC        0xAB
#define COMP_FLAG       0x40
#define MAX_PAYLOAD     8192u
#define RX_CAP          16384u
#define CHUNK_MAX       1024u

#define OP_PING         0x01
#define OP_SCREEN_GET   0x02
#define OP_KEYS_SEND    0x03
#define OP_FILE_READ    0x04
#define OP_FILE_WRITE   0x05
#define OP_DIR_LIST     0x06
#define OP_FILE_ATTR    0x07
#define OP_CONSOLE_GET  0x0A
#define OP_KEYS_RAW     0x0D
#define OP_REBOOT       0x0E
#define OP_FILE_HASH    0x10
#define OP_WIN_SCREENSHOT 0x30

#define OP_HELLO        0x80
#define OP_SCREEN_DATA  0x82
#define OP_KEYS_ACK     0x83
#define OP_FILE_DATA    0x84
#define OP_FILE_WROK    0x85
#define OP_DIR_DATA     0x86
#define OP_FILE_ATTR_OK 0x87
#define OP_CONSOLE_DATA 0x8A
#define OP_KEYS_RAW_OK  0x8D
#define OP_ERROR        0x8F
#define OP_FILE_HASH_OK 0x90
#define OP_WIN_SCREENSHOT_DATA 0xB0

#define ST_OK            0
#define ST_NOT_FOUND     1
#define ST_ACCESS        2
#define ST_EOF           3
#define ST_BAD_ARGS      4
#define ST_OTHER         0xFF

#define WF_TRUNC         0x01
#define WF_APPEND        0x02

#define KEYEVENTF_EXTENDEDKEY 0x0001
#define KEYEVENTF_KEYUP       0x0002
#define KEYEVENTF_SCANCODE    0x0008

static HANDLE g_serial = INVALID_HANDLE_VALUE;
static BYTE g_rx[RX_CAP];
static unsigned g_rx_len = 0;
static BYTE g_tx[1 + 5 + MAX_PAYLOAD + 2];
static BYTE g_screen[6 + 80 * 25 * 2];
static BYTE g_dir[MAX_PAYLOAD];
static BYTE g_file[11 + CHUNK_MAX];
static BYTE g_shot[8 + 96 * 72];

/* Keep the Win95 executable free of modern api-ms-win-crt-* imports. */
static void c_copy(void *dst, const void *src, unsigned n)
{
    BYTE *d = (BYTE *)dst;
    const BYTE *s = (const BYTE *)src;
    while (n--)
        *d++ = *s++;
}

static void c_move(void *dst, const void *src, unsigned n)
{
    BYTE *d = (BYTE *)dst;
    const BYTE *s = (const BYTE *)src;
    if (d < s) {
        while (n--)
            *d++ = *s++;
    } else {
        d += n;
        s += n;
        while (n--)
            *--d = *--s;
    }
}

static void c_zero(void *dst, unsigned n)
{
    BYTE *d = (BYTE *)dst;
    while (n--)
        *d++ = 0;
}

static unsigned c_len(const char *s)
{
    unsigned n = 0;
    while (s[n])
        ++n;
    return n;
}

static void c_copy_string(char *dst, const char *src)
{
    while ((*dst++ = *src++) != 0)
        ;
}

static DWORD parse_decimal(const char *s)
{
    DWORD n = 0;
    while (*s >= '0' && *s <= '9')
        n = n * 10 + (DWORD)(*s++ - '0');
    return n;
}

static WORD rd16(const BYTE *p)
{
    return (WORD)((WORD)p[0] | ((WORD)p[1] << 8));
}

static DWORD rd32(const BYTE *p)
{
    return (DWORD)p[0] | ((DWORD)p[1] << 8) |
           ((DWORD)p[2] << 16) | ((DWORD)p[3] << 24);
}

static void wr16(BYTE *p, WORD v)
{
    p[0] = (BYTE)v;
    p[1] = (BYTE)(v >> 8);
}

static void wr32(BYTE *p, DWORD v)
{
    p[0] = (BYTE)v;
    p[1] = (BYTE)(v >> 8);
    p[2] = (BYTE)(v >> 16);
    p[3] = (BYTE)(v >> 24);
}

static WORD crc16(const BYTE *p, unsigned n)
{
    WORD crc = 0xFFFF;
    unsigned i, b;
    for (i = 0; i < n; ++i) {
        crc ^= (WORD)((WORD)p[i] << 8);
        for (b = 0; b < 8; ++b) {
            crc = (crc & 0x8000)
                ? (WORD)((crc << 1) ^ 0x1021)
                : (WORD)(crc << 1);
        }
    }
    return crc;
}

static int serial_write_all(const BYTE *data, unsigned len)
{
    unsigned off = 0;
    while (off < len) {
        DWORD wrote = 0;
        if (!WriteFile(g_serial, data + off, (DWORD)(len - off), &wrote, NULL))
            return 0;
        if (wrote == 0)
            return 0;
        off += (unsigned)wrote;
    }
    return 1;
}

static int send_frame(BYTE op, WORD req, const BYTE *payload, unsigned plen)
{
    WORD sum;
    if (plen > MAX_PAYLOAD)
        return 0;
    g_tx[0] = SYNC_CRC;
    g_tx[1] = op;
    wr16(g_tx + 2, req);
    wr16(g_tx + 4, (WORD)plen);
    if (plen)
        c_copy(g_tx + 6, payload, plen);
    sum = crc16(g_tx + 1, 5 + plen);
    g_tx[6 + plen] = (BYTE)sum;
    g_tx[7 + plen] = (BYTE)(sum >> 8);
    return serial_write_all(g_tx, 8 + plen);
}

static void send_error(WORD req, BYTE code)
{
    BYTE p[3];
    p[0] = code;
    p[1] = 0;
    p[2] = 0;
    send_frame(OP_ERROR, req, p, sizeof(p));
}

static BYTE map_error(DWORD err)
{
    if (err == ERROR_FILE_NOT_FOUND || err == ERROR_PATH_NOT_FOUND ||
        err == ERROR_INVALID_DRIVE)
        return ST_NOT_FOUND;
    if (err == ERROR_ACCESS_DENIED || err == ERROR_WRITE_PROTECT ||
        err == ERROR_SHARING_VIOLATION)
        return ST_ACCESS;
    return ST_OTHER;
}

static int read_string(const BYTE *p, unsigned plen, unsigned *off,
                       char *out, unsigned cap)
{
    WORD n;
    if (*off + 2 > plen)
        return 0;
    n = rd16(p + *off);
    *off += 2;
    if (*off + n > plen || cap == 0)
        return 0;
    if (n >= cap)
        n = (WORD)(cap - 1);
    c_copy(out, p + *off, n);
    out[n] = 0;
    *off += rd16(p + *off - 2);
    return 1;
}

static void send_hello(WORD req)
{
    static const char machine[] = "COMR95/0.1";
    BYTE p[64];
    unsigned n = c_len(machine);
    p[0] = PROTO_VER;
    p[1] = 80;
    p[2] = 25;
    wr16(p + 3, CHUNK_MAX);
    wr16(p + 5, (WORD)n);
    c_copy(p + 7, machine, n);
    send_frame(OP_HELLO, req, p, 7 + n);
}

static void send_empty_console(WORD req)
{
    BYTE p[11];
    wr32(p + 0, 0);
    wr32(p + 4, 0);
    p[8] = 0;
    wr16(p + 9, 0);
    send_frame(OP_CONSOLE_DATA, req, p, sizeof(p));
}

static void handle_screen(WORD req)
{
    BYTE *p = g_screen;
    unsigned i;
    static const char *lines[] = {
        "COMR95 Windows 95 agent",
        "Serial control channel: active",
        "File, directory, keyboard and desktop probes enabled"
    };
    p[0] = 3;
    p[1] = 80;
    p[2] = 25;
    p[3] = 0;
    p[4] = 0;
    p[5] = 0;
    for (i = 0; i < 80 * 25; ++i) {
        p[6 + i * 2] = ' ';
        p[7 + i * 2] = 0x07;
    }
    for (i = 0; i < sizeof(lines) / sizeof(lines[0]); ++i) {
        unsigned n = c_len(lines[i]);
        unsigned j;
        if (n > 80)
            n = 80;
        for (j = 0; j < n; ++j)
            p[6 + (i * 2 + 1) * 80 * 2 + j * 2] = (BYTE)lines[i][j];
    }
    send_frame(OP_SCREEN_DATA, req, p, sizeof(g_screen));
}

static void handle_file_read(WORD req, const BYTE *p, unsigned plen)
{
    char path[MAX_PATH];
    unsigned off = 0;
    DWORD pos, total, high;
    WORD want;
    BYTE *out = g_file;
    HANDLE h;
    DWORD got = 0;
    BYTE status = ST_OK;

    if (!read_string(p, plen, &off, path, sizeof(path)) || off + 6 > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    pos = rd32(p + off);
    want = rd16(p + off + 4);
    if (want > CHUNK_MAX)
        want = CHUNK_MAX;
    h = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE,
                    NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        out[0] = map_error(GetLastError());
        wr32(out + 1, 0);
        wr32(out + 5, pos);
        wr16(out + 9, 0);
        send_frame(OP_FILE_DATA, req, out, 11);
        return;
    }
    high = 0;
    total = GetFileSize(h, &high);
    if (high != 0)
        total = 0xFFFFFFFFUL;
    if (pos >= total) {
        status = ST_EOF;
    } else {
        SetFilePointer(h, pos, NULL, FILE_BEGIN);
        if (!ReadFile(h, out + 11, want, &got, NULL)) {
            status = map_error(GetLastError());
            got = 0;
        } else if (pos + got >= total) {
            status = ST_EOF;
        }
    }
    CloseHandle(h);
    out[0] = status;
    wr32(out + 1, total);
    wr32(out + 5, pos);
    wr16(out + 9, (WORD)got);
    send_frame(OP_FILE_DATA, req, out, 11 + (unsigned)got);
}

static void handle_file_write(WORD req, const BYTE *p, unsigned plen)
{
    char path[MAX_PATH];
    unsigned off = 0;
    BYTE flags;
    DWORD pos;
    WORD dlen;
    const BYTE *data;
    HANDLE h;
    DWORD wrote = 0;
    BYTE out[5];
    DWORD disposition;

    if (!read_string(p, plen, &off, path, sizeof(path)) || off + 7 > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    flags = p[off];
    pos = rd32(p + off + 1);
    dlen = rd16(p + off + 5);
    if (off + 7 + dlen > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    data = p + off + 7;
    disposition = (flags & WF_TRUNC) ? CREATE_ALWAYS : OPEN_ALWAYS;
    h = CreateFileA(path, GENERIC_WRITE, FILE_SHARE_READ,
                    NULL, disposition, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        out[0] = map_error(GetLastError());
        wr32(out + 1, 0);
        send_frame(OP_FILE_WROK, req, out, sizeof(out));
        return;
    }
    if (flags & WF_APPEND)
        SetFilePointer(h, 0, NULL, FILE_END);
    else
        SetFilePointer(h, pos, NULL, FILE_BEGIN);
    if (dlen && !WriteFile(h, data, dlen, &wrote, NULL)) {
        out[0] = map_error(GetLastError());
        wrote = 0;
    } else {
        out[0] = ST_OK;
    }
    CloseHandle(h);
    wr32(out + 1, wrote);
    send_frame(OP_FILE_WROK, req, out, sizeof(out));
}

static BYTE dos_attr(DWORD attr)
{
    return (BYTE)(attr & 0x27);
}

static void handle_file_attr(WORD req, const BYTE *p, unsigned plen)
{
    char path[MAX_PATH];
    unsigned off = 0;
    BYTE do_set, requested, result;
    DWORD current, full;
    BYTE out[2];

    if (!read_string(p, plen, &off, path, sizeof(path)) || off + 2 > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    do_set = p[off];
    requested = p[off + 1];
    current = GetFileAttributesA(path);
    if (current == INVALID_FILE_ATTRIBUTES) {
        out[0] = map_error(GetLastError());
        out[1] = 0;
        send_frame(OP_FILE_ATTR_OK, req, out, sizeof(out));
        return;
    }
    result = dos_attr(current);
    if (do_set) {
        full = current & ~(DWORD)0x27;
        full |= requested & 0x27;
        if ((full & (FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM |
                     FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_ARCHIVE)) == 0)
            full |= FILE_ATTRIBUTE_NORMAL;
        if (!SetFileAttributesA(path, full)) {
            out[0] = map_error(GetLastError());
            out[1] = result;
            send_frame(OP_FILE_ATTR_OK, req, out, sizeof(out));
            return;
        }
        current = GetFileAttributesA(path);
        result = dos_attr(current);
    }
    out[0] = ST_OK;
    out[1] = result;
    send_frame(OP_FILE_ATTR_OK, req, out, sizeof(out));
}

static void handle_dir_list(WORD req, const BYTE *p, unsigned plen)
{
    char pattern[MAX_PATH];
    unsigned off = 0;
    WORD start;
    WIN32_FIND_DATAA fd;
    HANDLE h;
    BYTE *out = g_dir;
    unsigned count = 0;
    unsigned used = 3;
    BYTE more = 0;
    int page_full = 0;
    unsigned i;

    if (!read_string(p, plen, &off, pattern, sizeof(pattern)) || off + 2 > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    start = rd16(p + off);
    h = FindFirstFileA(pattern, &fd);
    if (h == INVALID_HANDLE_VALUE) {
        out[0] = 0;
        out[1] = 0;
        out[2] = 0;
        send_frame(OP_DIR_DATA, req, out, 3);
        return;
    }
    for (i = 0; i < start; ++i) {
        if (!FindNextFileA(h, &fd)) {
            FindClose(h);
            out[0] = 0;
            out[1] = 0;
            out[2] = 0;
            send_frame(OP_DIR_DATA, req, out, 3);
            return;
        }
    }
    do {
        unsigned n = c_len(fd.cFileName);
        unsigned need;
        WORD dos_time = 0, dos_date = 0;
        DWORD size = fd.nFileSizeLow;
        BYTE attr = dos_attr(fd.dwFileAttributes);
        if (n > 255)
            n = 255;
        need = 10 + n;
        if (used + need > MAX_PAYLOAD) {
            more = 1;
            page_full = 1;
            break;
        }
        FileTimeToDosDateTime(&fd.ftLastWriteTime, &dos_date, &dos_time);
        out[used] = attr;
        wr16(out + used + 1, dos_time);
        wr16(out + used + 3, dos_date);
        wr32(out + used + 5, size);
        out[used + 9] = (BYTE)n;
        c_copy(out + used + 10, fd.cFileName, n);
        used += need;
        ++count;
    } while (FindNextFileA(h, &fd));
    if (!page_full)
        more = 0;              /* FindNextFile reached ERROR_NO_MORE_FILES. */
    FindClose(h);
    wr16(out + 0, (WORD)count);
    out[2] = more;
    send_frame(OP_DIR_DATA, req, out, used);
}

static DWORD crc32_update(DWORD crc, const BYTE *p, unsigned n)
{
    unsigned i, b;
    for (i = 0; i < n; ++i) {
        crc ^= p[i];
        for (b = 0; b < 8; ++b)
            crc = (crc >> 1) ^ ((crc & 1) ? 0xEDB88320UL : 0);
    }
    return crc;
}

static void handle_file_hash(WORD req, const BYTE *p, unsigned plen)
{
    char path[MAX_PATH];
    unsigned off = 0;
    HANDLE h;
    BYTE buf[1024];
    DWORD got, total = 0, crc = 0xFFFFFFFFUL;
    BOOL read_ok;
    BYTE out[9];

    if (!read_string(p, plen, &off, path, sizeof(path))) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    h = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE,
                    NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        out[0] = map_error(GetLastError());
        wr32(out + 1, 0);
        wr32(out + 5, 0);
        send_frame(OP_FILE_HASH_OK, req, out, sizeof(out));
        return;
    }
    read_ok = TRUE;
    for (;;) {
        if (!ReadFile(h, buf, sizeof(buf), &got, NULL)) {
            read_ok = FALSE;
            break;
        }
        if (got == 0)
            break;
        crc = crc32_update(crc, buf, (unsigned)got);
        total += got;
    }
    if (!read_ok) {
        out[0] = map_error(GetLastError());
        total = 0;
        crc = 0;
    } else {
        out[0] = ST_OK;
        crc ^= 0xFFFFFFFFUL;
    }
    CloseHandle(h);
    wr32(out + 1, total);
    wr32(out + 5, crc);
    send_frame(OP_FILE_HASH_OK, req, out, sizeof(out));
}

static void inject_ascii(BYTE ascii)
{
    SHORT code;
    BYTE vk, scan, mods;
    if (ascii == 13)
        code = (SHORT)((VK_RETURN) & 0xFF);
    else if (ascii == 8)
        code = (SHORT)((VK_BACK) & 0xFF);
    else if (ascii == 9)
        code = (SHORT)((VK_TAB) & 0xFF);
    else if (ascii == 27)
        code = (SHORT)((VK_ESCAPE) & 0xFF);
    else
        code = VkKeyScanA((CHAR)ascii);
    if (code == -1)
        return;
    vk = (BYTE)(code & 0xFF);
    mods = (BYTE)((code >> 8) & 0xFF);
    if (mods & 1) keybd_event(VK_SHIFT, 0, 0, 0);
    if (mods & 2) keybd_event(VK_CONTROL, 0, 0, 0);
    if (mods & 4) keybd_event(VK_MENU, 0, 0, 0);
    scan = (BYTE)MapVirtualKeyA(vk, 0);
    keybd_event(vk, scan, 0, 0);
    keybd_event(vk, scan, KEYEVENTF_KEYUP, 0);
    if (mods & 4) keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
    if (mods & 2) keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
    if (mods & 1) keybd_event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
}

static void inject_scancode(BYTE code, int extended)
{
    DWORD flags = KEYEVENTF_SCANCODE;
    BYTE scan = code;
    if (extended)
        flags |= KEYEVENTF_EXTENDEDKEY;
    if (code & 0x80) {
        scan = (BYTE)(code & 0x7F);
        flags |= KEYEVENTF_KEYUP;
    }
    keybd_event(0, scan, flags, 0);
}

static void handle_keys(WORD req, const BYTE *p, unsigned plen)
{
    WORD n, i;
    BYTE out[2];
    if (plen < 2) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    n = rd16(p);
    if (2 + (unsigned)n * 2 > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    for (i = 0; i < n; ++i) {
        BYTE scan = p[2 + i * 2];
        BYTE ascii = p[3 + i * 2];
        if (ascii)
            inject_ascii(ascii);
        else
            inject_scancode(scan, 0);
    }
    wr16(out, n);
    send_frame(OP_KEYS_ACK, req, out, sizeof(out));
}

static void handle_keys_raw(WORD req, const BYTE *p, unsigned plen)
{
    WORD n, i;
    int extended = 0;
    BYTE out[2];
    if (plen < 2) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    n = rd16(p);
    if (2u + (unsigned)n > plen) {
        send_error(req, ST_BAD_ARGS);
        return;
    }
    for (i = 0; i < n; ++i) {
        BYTE code = p[2 + i];
        if (code == 0xE0) {
            extended = 1;
            continue;
        }
        inject_scancode(code, extended);
        extended = 0;
    }
    wr16(out, n);
    send_frame(OP_KEYS_RAW_OK, req, out, sizeof(out));
}

static void handle_screenshot(WORD req, const BYTE *p, unsigned plen)
{
    WORD want_w = 80, want_h = 60;
    WORD w, h;
    HDC screen_dc, mem_dc;
    HBITMAP dib, old;
    BITMAPINFO bmi;
    void *bits = NULL;
    BYTE *out = g_shot;
    unsigned x, y;

    if (plen >= 4) {
        want_w = rd16(p);
        want_h = rd16(p + 2);
    }
    if (want_w == 0) want_w = 80;
    if (want_h == 0) want_h = 60;
    w = want_w > 96 ? 96 : want_w;
    h = want_h > 72 ? 72 : want_h;
    screen_dc = GetDC(NULL);
    if (!screen_dc) {
        send_error(req, ST_OTHER);
        return;
    }
    mem_dc = CreateCompatibleDC(screen_dc);
    if (!mem_dc) {
        ReleaseDC(NULL, screen_dc);
        send_error(req, ST_OTHER);
        return;
    }
    c_zero(&bmi, sizeof(bmi));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = w;
    bmi.bmiHeader.biHeight = h;
    bmi.bmiHeader.biPlanes = 1;
    bmi.bmiHeader.biBitCount = 32;
    bmi.bmiHeader.biCompression = BI_RGB;
    dib = CreateDIBSection(screen_dc, &bmi, DIB_RGB_COLORS, &bits, NULL, 0);
    if (!dib || !bits) {
        DeleteDC(mem_dc);
        ReleaseDC(NULL, screen_dc);
        send_error(req, ST_OTHER);
        return;
    }
    old = (HBITMAP)SelectObject(mem_dc, dib);
    StretchBlt(mem_dc, 0, 0, w, h, screen_dc, 0, 0,
               GetDeviceCaps(screen_dc, HORZRES),
               GetDeviceCaps(screen_dc, VERTRES), SRCCOPY);
    out[0] = ST_OK;
    wr16(out + 1, w);
    wr16(out + 3, h);
    out[5] = 1;                 /* gray8 */
    wr16(out + 6, (WORD)(w * h));
    for (y = 0; y < h; ++y) {
        BYTE *row = (BYTE *)bits + (unsigned)(h - 1 - y) * w * 4;
        for (x = 0; x < w; ++x) {
            BYTE b = row[x * 4 + 0];
            BYTE g = row[x * 4 + 1];
            BYTE r = row[x * 4 + 2];
            out[8 + y * w + x] = (BYTE)((30 * r + 59 * g + 11 * b) / 100);
        }
    }
    SelectObject(mem_dc, old);
    DeleteObject(dib);
    DeleteDC(mem_dc);
    ReleaseDC(NULL, screen_dc);
    send_frame(OP_WIN_SCREENSHOT_DATA, req, out, 8 + (unsigned)w * h);
}

static void dispatch_frame(BYTE op, WORD req, const BYTE *p, unsigned plen)
{
    op &= (BYTE)~COMP_FLAG;
    switch (op) {
    case OP_PING:
        send_hello(req);
        break;
    case OP_SCREEN_GET:
        handle_screen(req);
        break;
    case OP_KEYS_SEND:
        handle_keys(req, p, plen);
        break;
    case OP_KEYS_RAW:
        handle_keys_raw(req, p, plen);
        break;
    case OP_FILE_READ:
        handle_file_read(req, p, plen);
        break;
    case OP_FILE_WRITE:
        handle_file_write(req, p, plen);
        break;
    case OP_DIR_LIST:
        handle_dir_list(req, p, plen);
        break;
    case OP_FILE_ATTR:
        handle_file_attr(req, p, plen);
        break;
    case OP_FILE_HASH:
        handle_file_hash(req, p, plen);
        break;
    case OP_CONSOLE_GET:
        send_empty_console(req);
        break;
    case OP_WIN_SCREENSHOT:
        handle_screenshot(req, p, plen);
        break;
    case OP_REBOOT:
        ExitWindowsEx(EWX_REBOOT, 0);
        break;
    default:
        send_error(req, ST_BAD_ARGS);
        break;
    }
}

static void consume_rx(void)
{
    for (;;) {
        unsigned i, total;
        WORD plen, expected, actual;
        BYTE op;
        if (g_rx_len < 8)
            return;
        for (i = 0; i < g_rx_len && g_rx[i] != SYNC_CRC; ++i)
            ;
        if (i) {
            if (i >= g_rx_len) {
                g_rx_len = 0;
                return;
            }
            c_move(g_rx, g_rx + i, g_rx_len - i);
            g_rx_len -= i;
            if (g_rx_len < 8)
                return;
        }
        op = g_rx[1];
        plen = rd16(g_rx + 4);
        if (plen > MAX_PAYLOAD) {
            c_move(g_rx, g_rx + 1, g_rx_len - 1);
            --g_rx_len;
            continue;
        }
        total = 8 + plen;
        if (g_rx_len < total)
            return;
        expected = rd16(g_rx + 6 + plen);
        actual = crc16(g_rx + 1, 5 + plen);
        if (expected != actual) {
            c_move(g_rx, g_rx + 1, g_rx_len - 1);
            --g_rx_len;
            continue;
        }
        dispatch_frame(op, rd16(g_rx + 2), g_rx + 6, plen);
        if (g_rx_len > total)
            c_move(g_rx, g_rx + total, g_rx_len - total);
        g_rx_len -= total;
    }
}

static int same_prefix(const char *s, const char *prefix)
{
    while (*prefix) {
        char a = *s++;
        char b = *prefix++;
        if (a >= 'a' && a <= 'z') a = (char)(a - 'a' + 'A');
        if (b >= 'a' && b <= 'z') b = (char)(b - 'a' + 'A');
        if (a != b)
            return 0;
    }
    return 1;
}

static void write_text(const char *s)
{
    HANDLE out = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD n = 0;
    WriteFile(out, s, c_len(s), &n, NULL);
}

static int open_serial(const char *port, DWORD baud)
{
    DCB dcb;
    COMMTIMEOUTS tm;
    char device[32];
    g_serial = CreateFileA(port, GENERIC_READ | GENERIC_WRITE, 0, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (g_serial == INVALID_HANDLE_VALUE && same_prefix(port, "COM")) {
        device[0] = '\\'; device[1] = '\\'; device[2] = '.'; device[3] = '\\';
        c_copy_string(device + 4, port);
        g_serial = CreateFileA(device, GENERIC_READ | GENERIC_WRITE, 0, NULL,
                                OPEN_EXISTING, 0, NULL);
    }
    if (g_serial == INVALID_HANDLE_VALUE)
        return 0;
    c_zero(&dcb, sizeof(dcb));
    dcb.DCBlength = sizeof(dcb);
    if (!GetCommState(g_serial, &dcb)) {
        CloseHandle(g_serial);
        g_serial = INVALID_HANDLE_VALUE;
        return 0;
    }
    dcb.BaudRate = baud;
    dcb.ByteSize = 8;
    dcb.Parity = NOPARITY;
    dcb.StopBits = ONESTOPBIT;
    dcb.fBinary = TRUE;
    dcb.fDtrControl = DTR_CONTROL_ENABLE;
    dcb.fRtsControl = RTS_CONTROL_ENABLE;
    if (!SetCommState(g_serial, &dcb)) {
        CloseHandle(g_serial);
        g_serial = INVALID_HANDLE_VALUE;
        return 0;
    }
    SetupComm(g_serial, RX_CAP, RX_CAP);
    c_zero(&tm, sizeof(tm));
    tm.ReadIntervalTimeout = 20;
    tm.ReadTotalTimeoutConstant = 50;
    tm.WriteTotalTimeoutConstant = 1000;
    SetCommTimeouts(g_serial, &tm);
    PurgeComm(g_serial, PURGE_RXCLEAR | PURGE_TXCLEAR);
    return 1;
}

static const char *find_token(const char *cmd, const char *token)
{
    const char *p = cmd;
    while (*p) {
        if ((p == cmd || p[-1] == ' ' || p[-1] == '\t') &&
            same_prefix(p, token))
            return p;
        ++p;
    }
    return NULL;
}

static void copy_token(char *dst, unsigned cap, const char *p)
{
    unsigned n = 0;
    while (p[n] && p[n] != ' ' && p[n] != '\t' && n + 1 < cap)
        ++n;
    c_copy(dst, p, n);
    dst[n] = 0;
}

static int app_main(const char *cmdline)
{
    char port[32] = "COM1";
    DWORD baud = 115200;
    const char *arg;
    BYTE buf[512];

    if (find_token(cmdline, "/?") || find_token(cmdline, "-?")) {
        write_text("COMR95 Win32 serial agent 0.1\r\nusage: COMR95 /com1 /baud 115200\r\n");
        return 0;
    }
    arg = find_token(cmdline, "/com");
    if (!arg)
        arg = find_token(cmdline, "-com");
    if (arg) {
        ++arg;
        if (*arg == '-')
            ++arg;
        copy_token(port, sizeof(port), arg);
    }
    arg = find_token(cmdline, "/baud");
    if (!arg)
        arg = find_token(cmdline, "-baud");
    if (arg) {
        arg += 5;
        while (*arg == ' ' || *arg == '\t' || *arg == '=')
            ++arg;
        baud = parse_decimal(arg);
    }
    if (!open_serial(port, baud)) {
        write_text("COMR95: cannot open the requested serial port\r\n");
        return 1;
    }
    write_text("COMR95 resident serial agent active\r\n");
    send_hello(0);
    for (;;) {
        DWORD got = 0;
        if (ReadFile(g_serial, buf, sizeof(buf), &got, NULL) && got) {
            if (g_rx_len + (unsigned)got > RX_CAP) {
                g_rx_len = 0;
                PurgeComm(g_serial, PURGE_RXCLEAR);
            } else {
                c_copy(g_rx + g_rx_len, buf, got);
                g_rx_len += (unsigned)got;
                consume_rx();
            }
        }
        Sleep(1);
    }
    return 0;
}

/* Kept for the Open Watcom build; the MinGW Win95 build defines
   COMR95_NO_CRT_MAIN and enters through the CRT-free _start below. */
#ifndef COMR95_NO_CRT_MAIN
int main(void)
{
    return app_main(GetCommandLineA());
}
#endif

void __cdecl _start(void)
{
    ExitProcess((UINT)app_main(GetCommandLineA()));
}
