class Tetronimo
    @@positions = {
        i: [[0, 0], [-1, 0], [1, 0], [2, 0]],
        j: [[0, 0], [-1, -1], [-1, 0], [1, 0]],
        l: [[0, 0], [1, -1], [1, 0], [-1, 0]],
        o: [[0, 0], [1, 0], [1, -1], [0, -1]],
        s: [[0, 0], [1, -1], [0, -1], [-1, 0]],
        t: [[0, 0], [1, 0], [0, -1], [-1, 0]],
        z: [[0, 0], [-1, -1], [0, -1], [1, 0]]
    }

    def initialize(shape)
        @position = @@positions[shape]
    end

    def draw_pos
        @position
    end

    def left
        @position.map { |x,y| [x-1, y] }
    end

    def right
        @position.map { |x,y| [x+1, y] }
    end

    def up
        @position.map { |x,y| [x, y-1] }
    end

    def down
        @position.map { |x,y| [x, y+1] }
    end
end