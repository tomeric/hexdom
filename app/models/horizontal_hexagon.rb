class HorizontalHexagon < Hexagon
  alias_method :width,  :vertex_to_vertex
  alias_method :height, :side_to_side

  def y = (row * height) + (column.even? ? height / 2 : 0) - (height / 2)
  def x = (column * (side_length + (width - side_length) / 2)) - ((width - side_length) / 2)

  def points
    (0...6).map do |point|
      angle_deg = 60 * point
      angle_rad = Math::PI / 180 * angle_deg

      [
        (x + side_length * Math.cos(angle_rad)).ceil,
        (y + side_length * Math.sin(angle_rad)).ceil
      ]
    end
  end
end
