require 'bigdecimal'
require 'bigdecimal/math'
require 'set'

require 'drawille'

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

class Node
  NUM_DECIMALS = 3
  PRECISION = 10

  PI = BigMath.PI(PRECISION)
  ZERO = BigDecimal.new('0')
  ONE_HALF = BigDecimal.new('0.5')
  ONE = BigDecimal.new('1')

  def self.all
    @all ||= [
      new(:center  ,  ZERO,    0),
      new(:inner_ne, ONE/2,   30),
      new(:inner_se, ONE/2,  -30),
      new(:inner_sw, ONE/2, -150),
      new(:inner_nw, ONE/2,  150),
      new(:outer_n ,   ONE,   90),
      new(:outer_ne,   ONE,   30),
      new(:outer_se,   ONE,  -30),
      new(:outer_s ,   ONE,  -90),
      new(:outer_sw,   ONE, -150),
      new(:outer_nw,   ONE,  150)
    ]
  end

  def self.by_name(name)
    all.find { |candidate| candidate.name == name }
  end

  def self.horizontal_mirror(node)
    all.find do |candidate|
      (candidate.x == node.x) && (candidate.y == -node.y)
    end
  end

  def self.vertical_mirror(node)
    all.find do |candidate|
      (candidate.x == -node.x) && (candidate.y == node.y)
    end
  end

  def self.rotate_180(node)
    return node if node.radius == 0

    all.find do |candidate|
      ((candidate.angle - node.angle) % 360) == 180 && (candidate.radius == node.radius)
    end
  end

  attr_reader :name, :radius, :angle

  def x
    @x ||= (BigMath.cos(PI/180 * angle, PRECISION) * radius).round(NUM_DECIMALS)
  end

  def y
    @y ||= (BigMath.sin(PI/180 * angle, PRECISION) * radius).round(NUM_DECIMALS)
  end

  def point
    [x, y]
  end

  def to_s
    name
  end

  private

  def initialize(name, radius, angle)
    @name = name
    @radius = radius
    @angle = angle
  end
end

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

ALL = Glyph.from(:outer_n)
  .to(:outer_ne)
  .to(:outer_se)
  .to(:outer_s)
  .to(:outer_sw)
  .to(:outer_nw)
  .to(:outer_n)

  # ⠀⠀⢀⠤⠒⠑⠢⢄⡀⠀⠀
  # ⡔⠊⠁⠀⠀⠀⠀⠀⠈⠒⡄
  # ⡇⠀⠐⠀⠀⠀⠀⠐⠀⠀⡇
  # ⡇⠀⢀⠀⠀⠁⠀⢀⠀⠀⡇
  # ⢇⡀⠀⠀⠀⠀⠀⠀⠀⣀⠇
  # ⠀⠈⠒⠤⣀⢀⡠⠔⠉⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


ATTACK = Glyph.from(:outer_sw)
  .to(:inner_nw)
  .to(:outer_n)
  .to(:inner_ne)
  .to(:outer_se)

  # ⠀⠀⠀⠀⡰⠱⡀⠀⠀⠀⠀
  # ⠄⠀⠀⡰⠁⠀⠱⡀⠀⠀⠄
  # ⠀⠀⡔⠁⠀⠀⠀⠘⡄⠀⠀
  # ⠀⡜⢀⠀⠀⠁⠀⢀⠘⢄⠀
  # ⠜⠀⠀⠀⠀⠀⠀⠀⠀⠈⠆
  # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


LESS_THAN = Glyph.from(:outer_s)
  .to(:outer_sw)
  .to(:inner_sw)
  .to(:center)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠤⠒⠁⠀⢀⠀⠀⠀
  # ⢔⡊⠁⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠈⠒⠤⣀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


BREATHE = Glyph.from(:outer_nw, :center, :outer_ne)

# ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
# ⢄⡀⠀⠀⠀⠀⠀⠀⠀⣀⠄
# ⠀⠈⠑⠤⣀⢀⡠⠔⠊⠀⠀
# ⠀⠀⢀⠀⠀⠁⠀⢀⠀⠀⠀
# ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


LESS_THAN = Glyph.from(:outer_s)
  .to(:outer_sw)
  .to(:inner_sw)
  .to(:center)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠤⠒⠁⠀⢀⠀⠀⠀
  # ⢔⡊⠁⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠈⠒⠤⣀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


CLEAR = Glyph.from(:outer_n)
  .to(:center)
  .to(:outer_s)

  # ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⡇⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠀⠀⡇⠀⢀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
  # ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


OPEN = Glyph.from(:outer_s)
  .to(:inner_sw)
  .to(:inner_se)
  .to(:outer_s)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⣀⣀⣁⣀⣀⠀⠀⠀
  # ⠄⠀⠈⢢⠀⠀⢠⠃⠀⠀⠄
  # ⠀⠀⠀⠀⢣⢠⠃⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


USE = Glyph.from(:center)
  .to(:inner_se)
  .to(:outer_ne)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⢀⠜⠀
  # ⠀⠀⢀⠀⠀⠑⠢⢄⠎⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


GLYPHS = {
  :all => ALL,
  :attack => ATTACK,
  :breathe => BREATHE,
  :capture => LESS_THAN + USE,
  :clear => CLEAR,
  :clear_all => CLEAR + ALL,
  :die => BREATHE.horizontal_mirror,
  :open => OPEN,
  :open_all => OPEN + ALL,
  :use => USE,
}

puts <<-EOF

## Glyphs

EOF

GLYPHS.each do |name, glyph|
  puts "### #{ name.to_s.upcase.tr('_', ' ') }"
  puts
  puts GlyphRenderer.render(glyph)
  puts
end
