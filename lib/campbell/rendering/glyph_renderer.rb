require 'drawille'

module Campbell
  class GlyphRenderer
    SCALE = 12
    NODE_RADIUS = SCALE / 24
    NODE_PRECISION = 1

    attr_reader :glyph, :scale, :canvas

    def self.render(glyph)
      new(glyph, SCALE)
        .render_nodes!
        .render_edges!
        .to_s
    end

    def render_nodes!
      Node.all.each do |node|
        node_point = [node.x * scale, -node.y * scale]
        canvas.paint do
          NODE_PRECISION.times do
            up
            move *node_point
            right 360/NODE_PRECISION
            back NODE_RADIUS
            down
            forward NODE_RADIUS * 2
          end
        end
      end
      self
    end

    def render_edges!
      glyph.edges.each do |edge|
        u, v = *edge.nodes
        from = [u.x * scale, -u.y * scale]
        to = [v.x * scale, -v.y * scale]
        canvas.paint { line :from => from, :to => to }
      end
      self
    end

    def to_s
      canvas.frame
    end

    private

    def initialize(glyph, scale = 1)
      @glyph = glyph
      @scale = scale
      @canvas = Drawille::Canvas.new
    end
  end
end
