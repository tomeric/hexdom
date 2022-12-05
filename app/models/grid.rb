class Grid

  attr_reader :columns, :rows, :hex_size, :hexagons, :hex_class

  def initialize(columns, rows, hex_size: 60, hex_class: VerticalHexagon)
    @columns   = columns
    @rows      = rows
    @hex_size  = hex_size
    @hex_class = hex_class

    generate_hexagons
  end

  def width  = 1 + (hexagons[1] || hexagons[0])&.last.try { |h| (h.x + h.width  / 2).ceil } || 0
  def height = 1 + hexagons.last&.last.try { |h| (h.y + h.height / 2).ceil } || 0

  def render_to(canvas)
    hexagons.flatten.each do |hexagon|
      hexagon.render_to(canvas)
    end
  end

  private

  def generate_hexagons
    @hexagons ||= \
      1.upto(rows).map do |row|
        1.upto(columns).map do |column|
          hex_class.new(column, row, size: hex_size)
        end
      end
  end
end
