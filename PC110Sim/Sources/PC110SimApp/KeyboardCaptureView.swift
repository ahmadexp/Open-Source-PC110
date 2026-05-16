import SwiftUI
import AppKit

struct KeyboardCaptureView: NSViewRepresentable {
    let onKeyDown: (UInt16) -> Void
    let onKeyUp: (UInt16) -> Void

    func makeNSView(context: Context) -> KeyView {
        let view = KeyView()
        view.onKeyDown = onKeyDown
        view.onKeyUp = onKeyUp
        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: KeyView, context: Context) {
        nsView.onKeyDown = onKeyDown
        nsView.onKeyUp = onKeyUp
        DispatchQueue.main.async {
            nsView.window?.makeFirstResponder(nsView)
        }
    }

    final class KeyView: NSView {
        var onKeyDown: ((UInt16) -> Void)?
        var onKeyUp: ((UInt16) -> Void)?

        override var acceptsFirstResponder: Bool { true }

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            window?.makeFirstResponder(self)
        }

        override func keyDown(with event: NSEvent) {
            onKeyDown?(event.keyCode)
        }

        override func keyUp(with event: NSEvent) {
            onKeyUp?(event.keyCode)
        }
    }
}
