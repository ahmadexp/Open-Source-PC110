#ifndef PC110CORE_H
#define PC110CORE_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct PC110Machine PC110Machine;

typedef struct PC110CPUHostBus {
    uint8_t (*mem_read8)(void *opaque, uint32_t addr);
    void (*mem_write8)(void *opaque, uint32_t addr, uint8_t value);
    uint8_t (*io_read8)(void *opaque, uint16_t port);
    void (*io_write8)(void *opaque, uint16_t port, uint8_t value);
    void *opaque;
} PC110CPUHostBus;

PC110Machine *pc110_create(void);
void pc110_destroy(PC110Machine *m);
void pc110_reset(PC110Machine *m);
void pc110_run_frame(PC110Machine *m);
void pc110_enter_easy_setup(PC110Machine *m);
int pc110_attach_boot_zip(PC110Machine *m, const char *path);
int pc110_attach_boot_image(PC110Machine *m, const char *path);

int pc110_load_bios(PC110Machine *m, const char *path);
int pc110_bios_loaded(PC110Machine *m);
uint32_t pc110_bios_size(PC110Machine *m);

uint8_t pc110_mem_read8(PC110Machine *m, uint32_t addr);
void pc110_mem_write8(PC110Machine *m, uint32_t addr, uint8_t value);

uint8_t pc110_io_read8(PC110Machine *m, uint16_t port);
void pc110_io_write8(PC110Machine *m, uint16_t port, uint8_t value);

const uint32_t *pc110_get_framebuffer(PC110Machine *m);
int pc110_framebuffer_width(void);
int pc110_framebuffer_height(void);

void pc110_key_down(PC110Machine *m, uint16_t mac_key_code);
void pc110_key_up(PC110Machine *m, uint16_t mac_key_code);
void pc110_induce_f1(PC110Machine *m);

size_t pc110_trace_copy(PC110Machine *m, char *out, size_t out_size);
void pc110_trace_clear(PC110Machine *m);

size_t pc110_debug_format_memory(PC110Machine *m, uint32_t start, uint32_t length, char *out, size_t out_size);
size_t pc110_debug_format_text_screen(PC110Machine *m, char *out, size_t out_size);

void pc110_cpu_reset(PC110Machine *m);
void pc110_cpu_step(PC110Machine *m, int instruction_count);
void pc110_cpu_set_trace_mode(PC110Machine *m, int enabled);
int pc110_cpu_get_trace_mode(PC110Machine *m);
size_t pc110_cpu_format_state(PC110Machine *m, char *out, size_t out_size);
uint32_t pc110_cpu_linear_pc(PC110Machine *m);

#ifdef __cplusplus
}
#endif

#endif
