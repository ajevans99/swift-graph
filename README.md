# swift-graph

[![CI](https://github.com/ajevans99/swift-graph/actions/workflows/ci.yml/badge.svg)](https://github.com/ajevans99/swift-graph/actions/workflows/ci.yml)

A minimal Swift Package targeting Swift 6.0+ with modern Swift Testing, CI for Linux/macOS/iOS, SPI config, and swift-format.

## Usage

Add this package as a dependency, then:

```swift
import Graph

let greeter = Graph()
print(greeter.greet(name: "World"))
```

## Development

- Format code with `make format`
- Lint with `make lint`
- Run tests: `swift test`

## License

MIT. See `LICENSE`.
