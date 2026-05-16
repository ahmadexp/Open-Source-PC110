// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PC110Sim",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "PC110Sim", targets: ["PC110SimApp"])
    ],
    targets: [
        .target(
            name: "PC110Core",
            publicHeadersPath: "include",
            cSettings: [
                .unsafeFlags(["-std=c99"])
            ]
        ),
        .executableTarget(
            name: "PC110SimApp",
            dependencies: ["PC110Core"]
        )
    ]
)
