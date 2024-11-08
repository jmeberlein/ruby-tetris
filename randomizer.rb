class Randomizer
    def initialize
        reset
    end

    def next
        reset if @bag.empty?
        @bag.pop
    end

    def reset
        @bag = [:i, :j, :l, :o, :s, :t, :z].shuffle
    end
end