require 'set'

module Campbell
  class Edge
    attr_reader :nodes

    def hash
      nodes.hash
    end

    def ==(other)
      return false if other.nil?
      return false unless other.respond_to?(nodes)
      nodes == other.nodes
    end

    def to_s
      "(#{ nodes.to_a.map(&:to_s).join(', ') })"
    end

    private

    def initialize(*nodes)
      @nodes = Set.new(nodes)
    end
  end
end
