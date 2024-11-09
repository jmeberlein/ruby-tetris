require_relative './randomizer'
require_relative './tetronimo'

class Grid
    def initialize
        @status = (0...10).map { (-2...20).map { :free } }
        @randomizer = Randomizer.new
        @grid = (0...10).map do |i|
            (-2...20).map do |j|
                Square.new(
                    x: GRID_SIZE + i*(SQUARE_SIZE + GRID_SIZE),
                    y: GRID_SIZE + j*(SQUARE_SIZE + GRID_SIZE),
                    size: SQUARE_SIZE,
                    color: 'black'
                )
            end
        end

        @x_pos = 1
        @y_pos = 3
        @tetronimo = Tetronimo.new(@randomizer.next)
        set_status(:live)
        draw
    end

    def draw
        (0...10).map do |i|
            (0...22).map do |j|
                @grid[i][j].color = case @status[i][j]
                    when :free then 'black'
                    when :live then '#0000dd'
                    when :dead then 'red'
                end
            end
        end
    end

    def set_status(status, x_offset: 0, y_offset: 0)
        @tetronimo.draw_pos.map do |x,y|
            @status[@x_pos+x+x_offset][@y_pos+y+y_offset] = status
        end
    end

    def free?(x_offset: 0, y_offset: 0)
        @tetronimo.draw_pos.all? do |x,y|
            test_x = @x_pos + x + x_offset
            test_y = @y_pos + y + y_offset
            test_x >= 0 && test_x < 10 && test_y >= 0 && test_y < 22 && @status[test_x][test_y] != :dead
        end
    end

    def up
        move(x_offset: 0, y_offset: -1)
    end

    def down
        move(x_offset: 0, y_offset: 1)
    end

    def left
        move(x_offset: -1, y_offset: 0)
    end

    def right
        move(x_offset: 1, y_offset: 0)
    end

    def rotate_left
        set_status(:free)
        wallkicks = @tetronimo.rotate_left
        offset = wallkicks.find do |x_offset, y_offset|
            free?(x_offset: x_offset, y_offset: y_offset)
        end
        if offset
            @x_pos += offset[0]
            @y_pos += offset[1]
        else
            @tetronimo.rotate_right
        end
        set_status(:live)
        draw
    end

    def rotate_right
        set_status(:free)
        wallkicks = @tetronimo.rotate_right
        offset = wallkicks.find do |x_offset, y_offset|
            free?(x_offset: x_offset, y_offset: y_offset)
        end
        if offset
            @x_pos += offset[0]
            @y_pos += offset[1]
        else
            @tetronimo.rotate_left
        end
        set_status(:live)
        draw
    end

    def move(x_offset: 0, y_offset: 0)
        set_status(:free)
        if free?(x_offset: x_offset, y_offset: y_offset)
            @x_pos += x_offset
            @y_pos += y_offset
        end
        set_status(:live)
        draw
    end

    def reset
        set_status(:dead)
        @x_pos = 1
        @y_pos = 3
        @tetronimo = Tetronimo.new(@randomizer.next)
        set_status(:live)
        draw
    end
end