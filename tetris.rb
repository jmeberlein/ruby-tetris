require 'ruby2d'
require_relative './grid'

SQUARE_SIZE = 30
GRID_SIZE = 1
WIDTH = (SQUARE_SIZE+GRID_SIZE)*10 + GRID_SIZE
HEIGHT = (SQUARE_SIZE+GRID_SIZE)*20 + GRID_SIZE

set ({
    title: 'Tetris',
    width: WIDTH,
    height: HEIGHT,
    background: 'black'
})

grid = Grid.new

tick = 0

on :controller_button_down do |event|
    case event.button
    when :left
        grid.left
    when :right
        grid.right
    when :down
        grid.down
    when :a
        grid.rotate_left
    when :b
        grid.rotate_right
    when :x
        grid.drop
    when :y
        grid.pocket
    when :back
        close
    end
end

update do
  if tick % 60 == 0
    grid.down
  end
  tick += 1
end

show