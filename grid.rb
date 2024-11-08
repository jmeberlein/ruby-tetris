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

        @x_pos = 0
        @y_pos = 0
        @grid[@x_pos][@y_pos+2][:square].color = '#00ffff'
    end

    def set_status(x, y, status)
        @grid[@x_pos][@y_pos+2][:status] = status
        case status
        when :free
            @grid[@x_pos][@y_pos+2][:square].color = 'black'
        when :live
            @grid[@x_pos][@y_pos+2][:square].color = '#00ffff'
        when :dead
            @grid[@x_pos][@y_pos+2][:square].color = 'red'
        end
    end

    def get_status(x, y)
        @grid[x][y+2][:status] || :dead
    end

    def free?(x, y)
        get_status(x, y) == :free
    end

    def live?(x, y)
        get_status(x, y) == :live
    end

    def dead?(x, y)
        get_status(x, y) == :dead
    end

    def up
        if @y_pos > 0 && free?(@x_pos, @y_pos-1)
            set_status(@x_pos, @y_pos, :free)
            @y_pos -= 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def down
        if @y_pos < 19 && free?(@x_pos, @y_pos+1)
            set_status(@x_pos, @y_pos, :free)
            @y_pos += 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def left
        if @x_pos > 0 && free?(@x_pos-1, @y_pos)
            set_status(@x_pos, @y_pos, :free)
            @x_pos -= 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def right
        if @x_pos < 9 && free?(@x_pos+1, @y_pos)
            set_status(@x_pos, @y_pos, :free)
            @x_pos += 1
            set_status(@x_pos, @y_pos, :live)
        end
    end

    def reset
        set_status(@x_pos, @y_pos, :dead)
        @x_pos = 0
        @y_pos = 0
        set_status(@x_pos, @y_pos, :live)
    end
end