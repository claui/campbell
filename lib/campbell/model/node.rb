require 'bigdecimal'
require 'bigdecimal/math'

module Campbell
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
end
