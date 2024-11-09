class Tetronimo
    @@positions = {
        i: [[0, 0], [-1, 0], [1, 0], [2, 0]],
        j: [[0, 0], [0, -1], [0, 1], [-1, 1]],
        l: [[0, 0], [0, -1], [0, 1], [1, 1]],
        o: [[0, 0], [0, -1], [1, -1], [1, 0]],
        s: [[0, 0], [-1, 0], [0, -1], [1, -1]],
        t: [[0, 0], [-1, 0], [0, -1], [1, 0]],
        z: [[0, 0], [-1, -1], [0, -1], [1, 0]]
    }

    @@wallkicks = {
        0 => {
            1 => [[0, 0], [-1, 0], [-1, -1], [0, 2], [-1, 2]],
            3 => [[0, 0], [1, 0], [1, -1], [0, 2], [1, 2]]
        },
        1 => {
            0 => [[0, 0], [1, 0], [1, 1], [0, -2], [1, -2]],
            2 => [[0, 0], [1, 0], [1, 1], [0, -2], [1, -2]]
        },
        2 => {
            1 => [[0, 0], [-1, 0], [-1, -1], [0, 2], [-1, 2]],
            3 => [[0, 0], [1, 0], [1, -1], [0, 2], [1, 2]]
        },
        3 => {
            2 => [[0, 0], [-1, 0], [-1, 1], [0, -2], [-1, -2]],
            0 => [[0, 0], [-1, 0], [-1, 1], [0, -2], [-1, -2]],
        }
    }

    @@alt_wallkicks = {
        0 => {
            1 => [[-1, 0], [-3, 0], [0, 0], [0, -2], [-3, 1]],
            3 => [[0, -1], [2, -1], [-1, -1], [-1, 3], [2, 0]]
        },
        1 => {
            0 => [[1, 0], [3, 0], [0, 0], [3, -1], [0, 2]],
            2 => [[0, -1], [-1, -1], [2, -1], [-1, -3], [2, 0]]
        },
        2 => {
            1 => [[0, 1], [2, 1], [1, 1], [-2, 0], [1, 2]],
            3 => [[1, 0], [3, 0], [0, 0], [3, -1], [0, 1]]
        },
        3 => {
            2 => [[-1, 0], [0, 0], [-3, 0], [0, -2], [-3, 1]],
            0 => [[0, 1], [-2, 1], [1, 1], [-2, 0], [1, 3]]
        }
    }

    def initialize(shape)
        @shape = shape
        @position = @@positions[shape]
        @rotation = 0
    end

    def draw_pos
        @position
    end

    def rotate_left
        return [[0, 0]] if @shape == :o

        new_rotation = @rotation - 1
        new_rotation = 3 if new_rotation < 0
        @position = @position.map { |x,y| [y, -x] }
        wallkicks = if @shape == :i
            @@alt_wallkicks[@rotation][new_rotation]
        else
            @@wallkicks[@rotation][new_rotation]
        end
        @rotation = new_rotation
        wallkicks
    end

    def rotate_right
        return [[0, 0]] if @shape == :o

        new_rotation = @rotation + 1
        new_rotation = 0 if new_rotation > 3
        @position = @position.map { |x,y| [-y, x] }
        wallkicks = if @shape == :i
            @@alt_wallkicks[@rotation][new_rotation]
        else
            @@wallkicks[@rotation][new_rotation]
        end
        @rotation = new_rotation
        wallkicks
    end
end