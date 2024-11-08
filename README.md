# Running the Program

Requires dependencies on Linux:

    $ sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

Use your Ruby manager of choice to install Ruby 2D

    $ gem install ruby2d

Run `ruby2d.rb`

    $ ruby ruby2d.rb

# Playing the "Game"

This is very much a work in progress. Currently, it's just a proof of concept, where I'm moving a square around a grid. You *should* be able to use any controller, with the D-pad moving the square, the A button freezing the square in place and generating a new one at the top left, and the Back/Select button exiting the program.

# Design Notes

Okay, so amblyopia. Basically, my right eye at least works for field of vision, but it's weak enough that my brain's learned to tune it out. Traditionally, the treatment is patching your dominant eye, but that doesn't actually solve the fundamental issue, where your brain just doesn't bother using both of them at once. So there's an alternate class of treatments, where you make some sort of game with complementary colors for a color scheme, then play it while wearing 3D glasses to force your eyes to work together. Because of this, instead of the *official* color scheme, I'm just using a simplified color scheme where the "dead" squares are red and the "live" squares are cyan. In other words, with a normal pair of red-cyan 3D glasses, only your left eye will be able to see the block that's currently moving around, while only your right eye will be able to see the blocks that are already in place.

# TODO

I mean... it's supposed to be Tetris. Next is adding tetronimoes, then rotation, then gravity, then "pocketing" a tetronimo, etc. Oh, and actually making this a proper project, so Bundler can handle dependencies.