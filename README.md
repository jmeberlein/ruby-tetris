# Running the Program

Requires dependencies on Linux:

    $ sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

Use your Ruby manager of choice to install Ruby 2D

    $ gem install ruby2d

Run `tetris.rb`

    $ ruby tetris.rb

# Playing the "Game"

The D-pad moves the block, A and B rotate it (Xbox layout, so A is CCW, B is CW), X makes the block drop, and Y pockets the current block.

# Design Notes

Okay, so amblyopia. Basically, my right eye at least works for field of vision, but it's weak enough that my brain's learned to tune it out. Traditionally, the treatment is patching your dominant eye, but that doesn't actually solve the fundamental issue, where your brain just doesn't bother using both of them at once. So there's an alternate class of treatments, where you make some sort of game with complementary colors for a color scheme, then play it while wearing 3D glasses to force your eyes to work together. Because of this, instead of the *official* color scheme, I'm just using a simplified color scheme where the "dead" squares are red and the "live" squares are cyan. In other words, with a normal pair of red-cyan 3D glasses, only your right eye will be able to see the block that's currently moving around, while only your left eye will be able to see the blocks that are already in place.

## Practicalities

So... the 3D glasses I have aren't perfect. The red/left lens lets some green light through, and the cyan/right lens lets some red light through. I'm actually just using a red-blue color scheme. Blue actually *will* prevent my left eye from seeing things, and while there isn't really any color that will prevent my right eye from seeing things, it's also my bad eye, so I'm not worried.

# TODO

QOL features. It's *playable*, but lacks things like shadows, seeing what block is next, seeing what block is in your pocket, scorekeeping, etc.