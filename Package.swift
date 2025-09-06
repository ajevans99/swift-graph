// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "swift-graph",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v17),
    .macOS(.v13),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(
      name: "Graph",
      targets: ["Graph"]
    ),
    .executable(
      name: "Playground",
      targets: ["Playground"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Graph"
    ),
    .executableTarget(
      name: "Playground",
      dependencies: ["Graph"]
    ),
    .testTarget(
      name: "GraphTests",
      dependencies: ["Graph"]
    ),
  ]
)
