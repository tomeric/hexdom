class Hexagon
  attr_reader :column, :row, :size

  attr_accessor :color

  def self.width_for(hex_size)  = new(0,0, size: hex_size).width
  def self.height_for(hex_size) = new(0,0, size: hex_size).height

  def initialize(column, row, size: 60)
    @column = column
    @row    = row
    @size   = size
    @color  = ChunkyPNG::Color::BLACK
  end

  def apothem = (size.to_f / 2).ceil
  def center_to_vertex = apothem * 2 / Math.sqrt(3)
  def vertex_to_vertex = side_length * 2

  alias_method :side_to_side, :size
  alias_method :side_length, :center_to_vertex

  def x = (column * width)
  def y = (row    * height)

  def points = []

  def lines
    return [] unless points.size == 6
    # return [] unless row == 3 && column == 3

    points.map.with_index do |destination, index|
      origin = points[index - 1]

      [
        origin.first,      origin.second,
        destination.first, destination.second
      ]
    end + [[
      points.last.first,  points.last.second,
      points.first.first, points.first.second
    ]]
  end

  def render_to(canvas)
    if lines.present?
      canvas.circle(x.ceil, y.ceil, 3, color, color)
      lines.each do |line|
        x1, y1, x2, y2 = *line
        canvas.line(x1, y1, x2, y2, color)
      end
    else
      canvas.circle(x.ceil, y.ceil, 3, color, color)
    end
  end
end
