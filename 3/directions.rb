require "pry"

class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def move(direction)
    case direction
    when '^'
      @y += 1
    when 'v'
      @y -= 1
    when '<'
      @x -= 1
    when '>'
      @x += 1
    end
  end
end

class PositionsList
  attr_accessor :all

  def initialize
    @all = []
  end

  def generate_from_directions(directions)
    current_pos = Position.new(0, 0)
    @all.push(Position.new(0, 0))
    directions.each do |d|
      current_pos.move(d)
      add_if_unique(current_pos)
    end
    @all
  end

  def add_positions(positions)
    positions.each { |p| add_if_unique(p) }
  end

  private

  def position_visited?(position)
    already_visited = false
    @all.each do |vp|
      already_visited = true if vp == position
    end
    already_visited
  end

  def add_if_unique(p)
    @all.push(Position.new(p.x, p.y)) unless position_visited?(p)
  end

end

directions = File.read("input.txt")
directions = directions.split("")

visited_positions = PositionsList.new.generate_from_directions(directions)

puts "Num visited positions: #{visited_positions.count}"

santa_directions = []
robot_directions = []

directions.each_with_index do |d, i|
  if i.even?
    santa_directions.push(d)
  else
    robot_directions.push(d)
  end
end

all_positions = PositionsList.new
all_positions.generate_from_directions(santa_directions)
robot_positions = PositionsList.new.generate_from_directions(robot_directions)
all_positions.add_positions(robot_positions)

puts "Santa and Robot positions: #{all_positions.all.count}"
