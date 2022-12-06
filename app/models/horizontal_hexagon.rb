class HorizontalHexagon < Hexagon
  alias_method :height, :vertex_to_vertex
  alias_method :width,  :side_to_side

  def x = (column * width) + (row.even? ? width / 2 : 0) - (width / 2)
  def y = (row * (side_length + (height - side_length) / 2)) - ((height - side_length) / 2)

  def points
    (0...6).map do |point|
      angle_deg = 60 * point + 30
      angle_rad = Math::PI / 180 * angle_deg

      [
        (x + side_length * Math.cos(angle_rad)).ceil,
        (y + side_length * Math.sin(angle_rad)).ceil
      ]
    end
  end
end
