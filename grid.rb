require_relative './randomizer'
require_relative './tetronimo'

class Grid
    def initialize
        @status = (-2...20).map { (0...10).map { :free } }
        @randomizer = Randomizer.new
        @grid = (-2...20).map do |i|
            (0...10).map do |j|
                Square.new(
                    x: GRID_SIZE + j*(SQUARE_SIZE + GRID_SIZE),
                    y: GRID_SIZE + i*(SQUARE_SIZE + GRID_SIZE),
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
        (0...22).map do |i|
            (0...10).map do |j|
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
            @status[@y_pos+y+y_offset][@x_pos+x+x_offset] = status
        end
    end

    def free?(x_offset: 0, y_offset: 0)
        @tetronimo.draw_pos.all? do |x,y|
            test_x = @x_pos + x + x_offset
            test_y = @y_pos + y + y_offset
            test_x >= 0 && test_x < 10 && test_y >= 0 && test_y < 22 && @status[test_y][test_x] != :dead
        end
    end

    def up
        move(x_offset: 0, y_offset: -1)
    end

    def down
        reset unless move(x_offset: 0, y_offset: 1)
    end

    def drop
        nil while move(x_offset: 0, y_offset: 1)
        reset
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
        is_free = free?(x_offset: x_offset, y_offset: y_offset)
        if is_free
            @x_pos += x_offset
            @y_pos += y_offset
        end
        set_status(:live)
        draw
        is_free
    end

    def pocket
        tetronimo = @pocket
        @tetronimo.reset
        @pocket = @tetronimo
        reset(tetronimo: tetronimo, freeze: false)
    end

    def reset(tetronimo: nil, freeze: true)
        set_status(freeze ? :dead : :free)

        # Creating arrays is efficient enough in Ruby, so instead of manually shifting things,
        # just delete the cleared rows and add new ones back at the top
        cleared_rows = @status.count { |row| row.all?(:dead) }
        if cleared_rows > 0
            @status.delete_if { |row| row.all?(:dead) }
            @status = (0...cleared_rows).map { (0...10).map { :free } } + @status
        end

        @x_pos = 1
        @y_pos = 3
        @tetronimo = tetronimo || Tetronimo.new(@randomizer.next)
        set_status(:live)
        draw
    end
end