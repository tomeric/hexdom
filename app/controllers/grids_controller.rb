class GridsController < ApplicationController
  def show
    @grid = Grid.new(columns, rows, hex_size: hex_size, hex_class: hex_class)

    @canvas = ChunkyPNG::Image.new(
      @grid.width,
      @grid.height,
      ChunkyPNG::Color.from_hex('#aaaaaa')
    )

    @grid.render_to(@canvas)

    response.headers['Cache-Control'] = "public"
    response.headers['Content-Type'] = "image/png"
    response.headers['Content-Disposition'] = "inline"

    render body: @canvas.to_datastream
  end

  private

  def columns
    params.fetch(:columns, 5).to_i
  end

  def rows
    params.fetch(:rows, 5).to_i
  end

  def hex_size
    params.fetch(:size, 60).to_i
  end

  def hex_class
    params[:type] == 'horizontal' ? HorizontalHexagon : VerticalHexagon
  end
end
