import Testing

@testable import Graph

struct MutableGraphTests {
  private static var adjacencyFactory: Factory {
    Factory(name: "AdjacencyListGraph") { AdjacencyListGraph<String>() }
  }

  @Test("adding nodes increases nodes set and is idempotent", arguments: [Self.adjacencyFactory])
  func addNode(_ factory: Factory) async throws {
    var graph = factory()
    graph.add(node: "A")
    #expect(graph.nodes.contains("A"))
    graph.add(node: "A")
    #expect(graph.nodes.filter { $0 == "A" }.count == 1)
  }

  @Test("adding edge inserts nodes and edge", arguments: [Self.adjacencyFactory])
  func addEdge(_ factory: Factory) async throws {
    var graph = factory()
    graph.add(edge: (from: "A", to: "B"))
    #expect(graph.nodes.contains("A") && graph.nodes.contains("B"))
    #expect(graph.neighbors(of: "A").contains("B"))
    #expect(graph.edges.contains { $0.from == "A" && $0.to == "B" })
  }

  @Test("removing edge removes only that edge", arguments: [Self.adjacencyFactory])
  func removeEdge(_ factory: Factory) async throws {
    var graph = factory()
    graph.add(edge: (from: "A", to: "B"))
    graph.add(edge: (from: "A", to: "C"))
    graph.remove(edge: (from: "A", to: "B"))
    #expect(!graph.neighbors(of: "A").contains("B"))
    #expect(graph.neighbors(of: "A").contains("C"))
  }

  @Test("removing node removes node and its incident edges", arguments: [Self.adjacencyFactory])
  func removeNode(_ factory: Factory) async throws {
    var graph = factory()
    graph.add(edge: (from: "A", to: "B"))
    graph.add(edge: (from: "C", to: "A"))
    graph.remove(node: "A")
    #expect(!graph.nodes.contains("A"))
    #expect(!graph.neighbors(of: "C").contains("A"))
    #expect(!graph.edges.contains { $0.from == "A" || $0.to == "A" })
  }

  @Test("neighbors returns empty for unknown node", arguments: [Self.adjacencyFactory])
  func neighborsEmpty(_ factory: Factory) async throws {
    let graph = factory()
    #expect(graph.neighbors(of: "X").isEmpty)
  }

  @Test("edges and nodes reflect directed nature", arguments: [Self.adjacencyFactory])
  func directedEdges(_ factory: Factory) async throws {
    var graph = factory()
    graph.add(edge: (from: "A", to: "B"))
    #expect(graph.neighbors(of: "B").isEmpty)
    #expect(graph.edges.contains { $0.from == "A" && $0.to == "B" })
    #expect(!graph.edges.contains { $0.from == "B" && $0.to == "A" })
  }
}

// MARK: - Factory

struct Factory: Sendable {
  let name: String
  let make: @Sendable () -> any MutableGraph<String>

  func callAsFunction() -> any MutableGraph<String> {
    make()
  }
}

extension Factory: CustomTestStringConvertible {
  var testDescription: String { "\(name)<String>" }
}
