import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var host: EmulatorHost
    @State private var selectedDiagnostic: DiagnosticTab = .cpu

    private let screenWidth: CGFloat = 720
    private let screenHeight: CGFloat = 540

    var body: some View {
        HSplitView {
            leftPane
                .frame(minWidth: 760, idealWidth: 820)

            rightPane
                .frame(minWidth: 520, idealWidth: 600)
        }
        .padding(16)
        .frame(minWidth: 1280, minHeight: 820)
    }

    private var leftPane: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            screenPanel
            statusPanel
            controlsPanel
            keyboardCapture
        }
        .padding(.trailing, 8)
    }

    private var rightPane: some View {
        VStack(alignment: .leading, spacing: 12) {
            diagnosticsHeader
            diagnosticsPicker
            diagnosticsBody
        }
        .padding(.leading, 8)
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text("IBM PC110 Simulator")
                    .font(.system(.title2, design: .rounded).weight(.semibold))
                Text("BIOS bring-up harness")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("16.2")
                .font(.system(.caption, design: .monospaced).weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.quaternary, in: Capsule())
        }
    }

    private var screenPanel: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label("Display", systemImage: "display")
                    .font(.headline)
                Spacer()
                Text("640 × 480")
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
            }

            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.black)
                if let image = host.image {
                    Image(nsImage: image)
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(4.0 / 3.0, contentMode: .fit)
                        .padding(10)
                } else {
                    Text("No framebuffer")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: screenWidth, height: screenHeight)
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(.separator, lineWidth: 1)
            )
        }
    }

    private var statusPanel: some View {
        HStack(spacing: 8) {
            Image(systemName: "waveform.path.ecg")
                .foregroundStyle(.secondary)
            Text(host.status)
                .font(.caption)
                .lineLimit(2)
                .textSelection(.enabled)
            Spacer()
        }
        .padding(10)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private var controlsPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            ControlSection(title: "Primary") {
                ControlButton("Start+Copy", systemImage: "play.fill", prominent: true) {
                    host.startAndCopyStatusBundleToClipboard()
                }
                ControlButton("Next25+Copy", systemImage: "forward.end.fill", prominent: true) {
                    host.next25AndCopyStatusBundleToClipboard()
                }
                ControlButton("EasySetup+Copy", systemImage: "gearshape.fill", prominent: true) {
                    host.easySetupAndCopyStatusBundleToClipboard()
                }
                ControlButton("Induce F1+Copy", systemImage: "keyboard", prominent: true) {
                    host.induceF1AndCopyStatusBundleToClipboard()
                }
                ControlButton("Reset", systemImage: "arrow.counterclockwise") { host.reset() }
                ControlButton("Clear Trace", systemImage: "trash") { host.clearTrace() }
            }

            ControlSection(title: "Runs") {
                ControlButton("Run 10K", systemImage: "figure.run") { host.runTraced() }
                ControlButton("Fast Boot", systemImage: "hare") { host.bootFast() }
                ControlButton("Turbo+Copy", systemImage: "bolt.fill") { host.turboBootAndCopyStatusBundleToClipboard() }
                ControlButton("Ultra+Copy", systemImage: "bolt.circle.fill") { host.ultraBootAndCopyStatusBundleToClipboard() }
                ControlButton("Cont100+Copy", systemImage: "gauge.with.dots.needle.67percent") { host.continue100MAndCopyStatusBundleToClipboard() }
                ControlButton("Cont300+Copy", systemImage: "gauge.with.dots.needle.100percent") { host.continue300MAndCopyStatusBundleToClipboard() }
            }
        }
        .padding(12)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var diagnosticsHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Diagnostics")
                    .font(.headline)
                Text("Copy-ready CPU, trace, memory, and text-screen state")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button("Copy Bundle") { host.copyStatusBundleToClipboard() }
        }
    }

    private var diagnosticsPicker: some View {
        Picker("Diagnostics", selection: $selectedDiagnostic) {
            ForEach(DiagnosticTab.allCases) { tab in
                Label(tab.title, systemImage: tab.systemImage).tag(tab)
            }
        }
        .pickerStyle(.segmented)
    }

    @ViewBuilder
    private var diagnosticsBody: some View {
        switch selectedDiagnostic {
        case .cpu:
            DiagnosticPanel(title: "CPU", systemImage: "cpu", copyTitle: "Copy CPU") {
                host.copyCPUStateToClipboard()
            } content: {
                MonospaceScrollText(host.cpuState)
            }
        case .trace:
            DiagnosticPanel(title: "Trace Tail", systemImage: "list.bullet.rectangle", copyTitle: "Copy Trace") {
                host.copyTraceTailToClipboard()
            } content: {
                ScrollViewReader { proxy in
                    ScrollView {
                        Text(host.traceText)
                            .font(.system(.caption, design: .monospaced))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textSelection(.enabled)
                            .id("traceEnd")
                    }
                    .onChange(of: host.traceText) { _ in
                        proxy.scrollTo("traceEnd", anchor: .bottom)
                    }
                }
            }
        case .memory:
            DiagnosticPanel(title: "Memory", systemImage: "memorychip", copyTitle: "Copy Memory") {
                host.copyMemoryDumpToClipboard()
            } content: {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        TextField("Address", text: $host.memoryAddress)
                            .font(.system(.body, design: .monospaced))
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 140)
                        Button("Read") { host.refreshMemoryDump() }
                        Spacer()
                    }
                    MonospaceScrollText(host.memoryDump)
                }
            }
        case .text:
            DiagnosticPanel(title: "Text Screen", systemImage: "text.rectangle", copyTitle: "Copy Text") {
                host.copyTextScreenToClipboard()
            } content: {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Button("Refresh") { host.refreshTextScreen() }
                        Spacer()
                    }
                    MonospaceScrollText(host.textScreen)
                }
            }
        }
    }

    private var keyboardCapture: some View {
        KeyboardCaptureView(
            onKeyDown: { host.keyDown($0) },
            onKeyUp: { host.keyUp($0) }
        )
        .frame(width: 1, height: 1)
        .accessibilityHidden(true)
    }
}

private enum DiagnosticTab: String, CaseIterable, Identifiable {
    case cpu
    case trace
    case memory
    case text

    var id: String { rawValue }

    var title: String {
        switch self {
        case .cpu: return "CPU"
        case .trace: return "Trace"
        case .memory: return "Memory"
        case .text: return "Text"
        }
    }

    var systemImage: String {
        switch self {
        case .cpu: return "cpu"
        case .trace: return "list.bullet.rectangle"
        case .memory: return "memorychip"
        case .text: return "text.rectangle"
        }
    }
}

private struct ControlSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    private let columns = [
        GridItem(.adaptive(minimum: 128), spacing: 8, alignment: .leading)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                content
            }
        }
    }
}

private struct ControlButton: View {
    let title: String
    let systemImage: String
    let prominent: Bool
    let action: () -> Void

    init(_ title: String, systemImage: String, prominent: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.prominent = prominent
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.bordered)
        .controlSize(.regular)
        .tint(prominent ? .accentColor : nil)
    }
}

private struct DiagnosticPanel<Content: View>: View {
    let title: String
    let systemImage: String
    let copyTitle: String
    let copyAction: () -> Void
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(title, systemImage: systemImage)
                    .font(.headline)
                Spacer()
                Button(copyTitle, action: copyAction)
            }
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(12)
        .background(Color(nsColor: .textBackgroundColor), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(.separator, lineWidth: 1)
        )
    }
}

private struct MonospaceScrollText: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        ScrollView {
            Text(text)
                .font(.system(.caption, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .textSelection(.enabled)
                .padding(8)
        }
        .background(Color(nsColor: .controlBackgroundColor), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
