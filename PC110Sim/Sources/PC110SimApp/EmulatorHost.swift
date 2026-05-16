import Foundation
import AppKit
import PC110Core

final class EmulatorHost: ObservableObject {
    private var machine: OpaquePointer?
    private var timer: Timer?

    @Published var image: NSImage?
    @Published var traceText: String = ""
    @Published var memoryAddress: String = "000FFFF0"
    @Published var memoryDump: String = ""
    @Published var cpuState: String = ""
    @Published var textScreen: String = ""
    @Published var status: String = "Not started"

    private let width = Int(pc110_framebuffer_width())
    private let height = Int(pc110_framebuffer_height())

    deinit {
        stop()
        if let machine {
            pc110_destroy(machine)
        }
    }

    func start() {
        guard machine == nil else { return }

        guard let created = pc110_create() else {
            status = "Failed to create PC110 machine"
            return
        }
        machine = created

        let cwd = FileManager.default.currentDirectoryPath
        let biosPath = "\(cwd)/Roms/pc110_bios.bin"
        let loaded = pc110_load_bios(created, biosPath)
        _ = pc110_attach_boot_zip(created, "\(cwd)/Disks/img.ZIP")
        _ = pc110_attach_boot_image(created, "\(cwd)/Disks/Disk1.img")

        if loaded != 0 {
            status = "BIOS loaded: \(pc110_bios_size(created)) bytes"
        } else {
            status = "No BIOS loaded. Put Roms/pc110_bios.bin in the package directory."
        }

        refreshAll()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        guard let machine else { return }
        pc110_reset(machine)
        let cwd = FileManager.default.currentDirectoryPath
        _ = pc110_load_bios(machine, "\(cwd)/Roms/pc110_bios.bin")
        _ = pc110_attach_boot_zip(machine, "\(cwd)/Disks/img.ZIP")
        _ = pc110_attach_boot_image(machine, "\(cwd)/Disks/Disk1.img")
        refreshAll()
    }

    func clearTrace() {
        guard let machine else { return }
        pc110_trace_clear(machine)
        refreshTrace()
    }

    func testIO() {
        guard let machine else { return }
        pc110_io_write8(machine, 0x21, 0xF8)
        _ = pc110_io_read8(machine, 0x21)
        pc110_io_write8(machine, 0x70, 0x14)
        _ = pc110_io_read8(machine, 0x71)
        pc110_io_write8(machine, 0x226, 0x01)
        _ = pc110_io_read8(machine, 0x22E)
        _ = pc110_io_read8(machine, 0x1234)
        refreshAll()
    }

    func testMemory() {
        guard let machine else { return }
        pc110_mem_write8(machine, 0x00001000, 0x50)
        pc110_mem_write8(machine, 0x00001001, 0x43)
        pc110_mem_write8(machine, 0x00001002, 0x31)
        pc110_mem_write8(machine, 0x00001003, 0x31)
        memoryAddress = "00001000"
        refreshAll()
    }

    func stepCPU() {
        guard let machine else { return }
        pc110_cpu_step(machine, 1)
        refreshAll()
    }

    func runCPU100() {
        guard let machine else { return }
        pc110_cpu_step(machine, 100)
        refreshAll()
    }

    func runCPU1000() {
        guard let machine else { return }
        pc110_cpu_step(machine, 1000)
        refreshAll()
    }

    func runCPU100000() {
        guard let machine else { return }
        pc110_cpu_step(machine, 100000)
        refreshAll()
    }

    func postSprint() {
        guard let machine else { return }
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 500000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
    }

    func postSprintMillion() {
        guard let machine else { return }
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 1000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
    }

    func bootFast() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 10000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        status = "Fast boot run complete from reset: 10,000,000 instructions"
    }

    func bootTurbo() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 30000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        status = "Turbo boot run complete from reset: 30,000,000 instructions"
    }

    func bootUltra() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 300000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        status = "Ultra boot run complete from reset: 300,000,000 instructions"
    }

    func continueRun100M() {
        guard let machine else { return }
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 100000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        status = "Continued current state: 100,000,000 instructions"
    }

    func continueRun300M() {
        guard let machine else { return }
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 300000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        status = "Continued current state: 300,000,000 instructions"
    }

    func runTraced() {
        guard let machine else { return }
        pc110_cpu_step(machine, 10000)
        refreshAll()
    }

    func runCPU10000() {
        guard let machine else { return }
        pc110_cpu_step(machine, 10000)
        refreshAll()
    }


    func enterEasySetup() {
        guard let machine else { return }
        pc110_enter_easy_setup(machine)
        refreshAll()
        status = "Entered synthetic Easy Setup screen"
    }

    func easySetupAndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_enter_easy_setup(machine)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "EASY SETUP+COPY: entered setup screen and copied status bundle"
    }

    func induceF1AndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_trace_clear(machine)
        pc110_induce_f1(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 1000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "INDUCE F1+COPY: armed F1 scancode, ran 1,000,000 instructions, copied status bundle"
    }

    func resetCPUOnly() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        refreshAll()
    }


    func copyTraceToClipboard() {
        refreshTrace()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(traceText, forType: .string)
        status = "Copied full trace: \(traceText.count) characters"
    }

    func copyTraceTailToClipboard() {
        refreshTrace()
        let tail = String(traceText.suffix(12000))
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(tail, forType: .string)
        status = "Copied trace tail: \(tail.count) characters"
    }

    func exportTraceToDesktop() {
        refreshTrace()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HHmmss"
        let name = "PC110Sim-trace-\(formatter.string(from: Date())).txt"
        let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
        guard let url = desktop?.appendingPathComponent(name) else {
            status = "Could not find Desktop for trace export."
            return
        }
        do {
            try traceText.write(to: url, atomically: true, encoding: .utf8)
            status = "Trace exported to Desktop: \(name)"
        } catch {
            status = "Trace export failed: \(error.localizedDescription)"
        }
    }

    func copyStatusBundleToClipboard() {
        refreshCPUState()
        refreshTrace()
        refreshTextScreen()
        let tail = String(traceText.suffix(12000))
        let bundle = "=== CPU ===\n\(cpuState)\n\n=== TRACE TAIL ===\n\(tail)\n\n=== TEXT SCREEN ===\n\(textScreen)"
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(bundle, forType: .string)
        status = "Copied CPU + trace tail + text screen"
    }

    func startAndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 5000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "START+COPY: reset, ran 5,000,000 instructions, copied status bundle"
    }

    func nextAndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 5000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "NEXT+COPY: continued current state for 5,000,000 instructions, copied status bundle"
    }

    func next25AndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 25000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "NEXT25+COPY: continued current state for 25,000,000 instructions, copied status bundle"
    }

    func postBootAndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_cpu_reset(machine)
        pc110_trace_clear(machine)
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 5000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "POST booted from reset for 5,000,000 instructions and copied status bundle"
    }

    func continue5MAndCopyStatusBundleToClipboard() {
        guard let machine else { return }
        pc110_cpu_set_trace_mode(machine, 0)
        pc110_cpu_step(machine, 5000000)
        pc110_cpu_set_trace_mode(machine, 1)
        refreshAll()
        copyStatusBundleToClipboard()
        status = "Continued 5,000,000 instructions and copied status bundle"
    }

    func bootAndCopyStatusBundleToClipboard() {
        bootFast()
        copyStatusBundleToClipboard()
        status = "Fast booted from reset and copied CPU + trace tail + text screen"
    }

    func turboBootAndCopyStatusBundleToClipboard() {
        bootTurbo()
        copyStatusBundleToClipboard()
        status = "Turbo booted from reset and copied CPU + trace tail + text screen"
    }

    func ultraBootAndCopyStatusBundleToClipboard() {
        bootUltra()
        copyStatusBundleToClipboard()
        status = "Ultra booted from reset and copied CPU + trace tail + text screen"
    }

    func continue100MAndCopyStatusBundleToClipboard() {
        continueRun100M()
        copyStatusBundleToClipboard()
        status = "Continued 100M instructions and copied CPU + trace tail + text screen"
    }

    func continue300MAndCopyStatusBundleToClipboard() {
        continueRun300M()
        copyStatusBundleToClipboard()
        status = "Continued 300M instructions and copied CPU + trace tail + text screen"
    }

    func copyCPUStateToClipboard() {
        refreshCPUState()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(cpuState, forType: .string)
    }

    func copyMemoryDumpToClipboard() {
        refreshMemoryDump()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(memoryDump, forType: .string)
    }

    func copyTextScreenToClipboard() {
        refreshTextScreen()
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(textScreen, forType: .string)
        status = "Copied text screen dump: \(textScreen.count) characters"
    }

    func refreshAll() {
        refreshFramebuffer()
        refreshTrace()
        refreshMemoryDump()
        refreshCPUState()
        refreshTextScreen()
    }

    private func tick() {
        guard let machine else { return }
        pc110_run_frame(machine)
        refreshFramebuffer()
    }

    private func refreshFramebuffer() {
        guard let machine else { return }
        guard let fb = pc110_get_framebuffer(machine) else { return }

        let pixelCount = width * height
        let data = Data(bytes: fb, count: pixelCount * MemoryLayout<UInt32>.size)

        guard let provider = CGDataProvider(data: data as CFData) else { return }
        guard let cg = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: width * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue),
            provider: provider,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
        ) else { return }

        image = NSImage(cgImage: cg, size: NSSize(width: width, height: height))
    }

    func refreshTrace() {
        guard let machine else { return }
        var buffer = [CChar](repeating: 0, count: 1024 * 1024)
        let bufferCount = buffer.count
        buffer.withUnsafeMutableBufferPointer { ptr in
            _ = pc110_trace_copy(machine, ptr.baseAddress, bufferCount)
        }
        traceText = String(cString: buffer)
    }

    func refreshMemoryDump() {
        guard let machine else { return }
        let trimmed = memoryAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let start = UInt32(trimmed, radix: 16) ?? 0x000FFFF0

        var buffer = [CChar](repeating: 0, count: 8192)
        let bufferCount = buffer.count
        buffer.withUnsafeMutableBufferPointer { ptr in
            _ = pc110_debug_format_memory(machine, start, 256, ptr.baseAddress, bufferCount)
        }
        memoryDump = String(cString: buffer)
    }

    func refreshTextScreen() {
        guard let machine else { return }
        var buffer = [CChar](repeating: 0, count: 8192)
        let bufferCount = buffer.count
        buffer.withUnsafeMutableBufferPointer { ptr in
            _ = pc110_debug_format_text_screen(machine, ptr.baseAddress, bufferCount)
        }
        textScreen = String(cString: buffer)
    }

    func refreshCPUState() {
        guard let machine else { return }
        var buffer = [CChar](repeating: 0, count: 4096)
        let bufferCount = buffer.count
        buffer.withUnsafeMutableBufferPointer { ptr in
            _ = pc110_cpu_format_state(machine, ptr.baseAddress, bufferCount)
        }
        cpuState = String(cString: buffer)
    }

    func keyDown(_ macKeyCode: UInt16) {
        guard let machine else { return }
        pc110_key_down(machine, macKeyCode)
        refreshTrace()
    }

    func keyUp(_ macKeyCode: UInt16) {
        guard let machine else { return }
        pc110_key_up(machine, macKeyCode)
        refreshTrace()
    }
}
