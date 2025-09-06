public protocol Graph<Node> {
  associatedtype Node: Hashable

  /// All nodes in the graph.
  var nodes: Set<Node> { get }

  typealias Edge = (from: Node, to: Node)

  /// Add edges as (from, to) pairs.
  var edges: [Edge] { get }

  /// Outgoing neighbors of a node. If the node has no outgoing edges, returns an empty array.
  func neighbors(of node: Node) -> [Node]
}

public protocol WeightedGraph<Node>: Graph {
  associatedtype Weight: Comparable & Numeric

  /// Weight of the edge from one node to another, if it exists.
  /// Returns `nil` if there is no edge from `from` to `to`.
  func weight(from: Node, to: Node) -> Weight?
}

public protocol MutableGraph<Node>: Graph {
  /// Adds a node to the graph. If the node already exists, this is a no-op.
  mutating func add(node: Node)

  /// Adds an edge to the graph. If the edge already exists, this is a no-op.
  mutating func add(edge: Edge)

  /// Removes a node from the graph. If the node does not exist, this is a no-op.
  mutating func remove(node: Node)

  /// Removes an edge from the graph. If the edge does not exist, this is a no-op.
  mutating func remove(edge: Edge)
}
