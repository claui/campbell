require 'set'

module Campbell
  class Glyph
    attr_reader :cursor, :edges

    def self.from(*node_names)
      edges = []

      cursor = node_names.reduce do |u, v|
        edges << Edge.new(Node.by_name(u), Node.by_name(v))
        v
      end

      Glyph.new(edges, cursor)
    end

    def to(target_node_name)
      new_edge = Edge.new(Node.by_name(cursor), Node.by_name(target_node_name))
      Glyph.new(edges + [new_edge], target_node_name)
    end

    def +(other)
      Glyph.new(edges + other.edges, other.cursor)
    end

    def transform(transformation_sym)
      transformation = Node.method(transformation_sym)
      new_edges = edges.map do |edge|
        Edge.new(*edge.nodes.map(&transformation))
      end
      new_cursor = transformation[Node.by_name(cursor)].name
      Glyph.new(new_edges, new_cursor)
    end

    def horizontal_mirror
      transform(:horizontal_mirror)
    end

    def to_s
      "Edges: [#{ edges.map(&:to_s).join(', ') }]; cursor at #{ cursor }"
    end

    private

    def initialize(edges, cursor)
      @edges = Set.new(edges)
      @cursor = cursor
    end
  end
end
