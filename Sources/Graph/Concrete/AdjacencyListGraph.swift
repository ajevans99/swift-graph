public struct AdjacencyListGraph<Node: Hashable>: MutableGraph {
  private(set) var adjacency: [Node: Set<Node>] = [:]

  public var nodes: Set<Node> { Set(adjacency.keys) }

  public var edges: [Edge] {
    adjacency.flatMap { (node, adjacentNodes) in
      adjacentNodes.map { (from: node, to: $0) }
    }
  }

  public func neighbors(of node: Node) -> [Node] {
    adjacency[node].map { Array($0) } ?? []
  }

  // MARK: - Mutable

  public mutating func add(node: Node) {
    guard !adjacency.keys.contains(node) else { return }
    adjacency[node] = []
  }

  public mutating func add(edge: Edge) {
    add(node: edge.from)
    add(node: edge.to)
    adjacency[edge.from, default: []].insert(edge.to)
  }

  public mutating func remove(node: Node) {
    adjacency.removeValue(forKey: node)
    for key in adjacency.keys {
      adjacency[key]?.remove(node)
    }
  }

  public mutating func remove(edge: Edge) {
    adjacency[edge.from, default: []].remove(edge.to)
  }
}
