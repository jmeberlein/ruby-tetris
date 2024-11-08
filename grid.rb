require_relative './randomizer'
require_relative './tetronimo'

class Grid
    def initialize
        @grid = (0...10).map do |i|
            (-2...20).map do |j|
                {
                    square: Square.new(
                        x: GRID_SIZE + i*(SQUARE_SIZE + GRID_SIZE),
                        y: GRID_SIZE + j*(SQUARE_SIZE + GRID_SIZE),
                        size: SQUARE_SIZE,
                        color: 'black'
                    ),
                    status: :free
                }
            end
        end

        @randomizer = Randomizer.new

        @x_pos = 1
        @y_pos = 1
        @tetronimo = Tetronimo.new(@randomizer.next)
        set_status(@x_pos, @y_pos, :live)
    end

    def set_status(x, y, status)
        @tetronimo.draw_pos.map do |x,y|
            @grid[x+@x_pos][y+@y_pos+2][:status] = status
            case status
            when :free
                @grid[x+@x_pos][y+@y_pos+2][:square].color = 'black'
            when :live
                @grid[x+@x_pos][y+@y_pos+2][:square].color = '#0000dd'
            when :dead
                @grid[x+@x_pos][y+@y_pos+2][:square].color = 'red'
            end
        end
    end

    def get_status(x, y)
        @grid[x][y+2][:status] || :dead
    end

    def free?(x, y)
        @tetronimo.draw_pos.all? do |x_offset, y_offset|
            x_valid = x + x_offset >= 0 && x + x_offset < 10
            y_valid = y + y_offset >= 0 && y + y_offset < 20
            dead = get_status(x + x_offset, y + y_offset) == :dead
            x_valid && y_valid && !dead
        end
    end

    def up
        if free?(@x_pos, @y_pos-1)
            set_status(@x_pos, @y_pos, :free)
            @y_pos -= 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def down
        if free?(@x_pos, @y_pos+1)
            set_status(@x_pos, @y_pos, :free)
            @y_pos += 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def left
        if free?(@x_pos-1, @y_pos)
            set_status(@x_pos, @y_pos, :free)
            @x_pos -= 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def right
        if free?(@x_pos+1, @y_pos)
            set_status(@x_pos, @y_pos, :free)
            @x_pos += 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def reset
        set_status(@x_pos, @y_pos, :dead)
        @x_pos = 1
        @y_pos = 1
        @tetronimo = Tetronimo.new(@randomizer.next)
        set_status(@x_pos, @y_pos, :live)
    end
end