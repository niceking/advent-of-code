require "pry"

class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(position)
    @x == position.x && @y == position.y
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

class VisitedHouseList
  def initialize(directions)
    @directions = directions
  end

  def generate
    visited_positions = [Position.new(0, 0)]

    current_pos = Position.new(0, 0)

    @directions.each do |d|
      current_pos.move(d)
      already_present = false
      visited_positions.each do |vp|
        if vp == current_pos
          already_present = true
        end
      end

      unless already_present
        visited_positions.push(Position.new(current_pos.x, current_pos.y))
      end
    end

    visited_positions
  end
end

directions = File.read("input.txt")
directions = directions.split("")

visited_positions = VisitedHouseList.new(directions).generate

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

santa_positions = VisitedHouseList.new(santa_directions).generate
robot_positions = VisitedHouseList.new(robot_directions).generate
