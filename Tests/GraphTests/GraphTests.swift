import Testing

@testable import Graph

struct GraphTests {
  @Test("greet returns greeting for provided name")
  func greet() async throws {
    let sut = Graph()
    #expect(sut.greet(name: "World") == "Hello, World!")
  }
}
