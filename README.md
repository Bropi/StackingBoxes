# StackingBoxes
Simple stacking boxes game, made for practice in Godot using GDscript. 

Components that were required for implementation:
Gold 1:

    The game can be in 3D or 2D, you get to pick.
    It consists of 1 'level'. This scene has a 'floor' and a higher platform, like a 'table'.
    Like in Tetris, the player gets a random object/shape that they can drop unto the table from a certain height.
    Important: dropping the boxes and their collision is Physics-based. Either use RigidBody-type nodes, or 'fake' physics on your own (both are challenging).
    The goal of the game is to stack the highest tower of boxes. If a box is dropped on the floor and not on the table or another box, it is game over.
    When the box lands, the player gets a new box (Again, like in Tetris)
    The boxes are of different shapes and colours. Shapes can be inspired by Tetris or you can mix it up by using triangles, circles, capsules, etc. Only using square cubes isn't sufficient.
    Before the player drops the box they can move it around left-right horizontally using either arrow keys or mouse position (one of the options, both isn't required).
    If the tower of boxes gets higher and higher, make sure your camera responds by moving up or zooming out.

Gold 2:

    Add persistent data (saving the game). Find something that is interesting to be able to load when booting the game back up and add that feature. For example: a high score.
    Add a Pause/Play option to the game making everything stop and start again. This pause option shows a menu to continue or exit the game.
    Add a Start Game screen that shows a menu with a background, a start game option and exit the game option. Also add a way to navigate to the Settings menu.
    Add a Game Over screen that shows a Restart and Exit option. If your game doesn't have a way for the player to fail yet, implement that as well.
    Add audio to the game. You'll have to add both background music and a sound effect that plays when the player does something. The sounds can be royalty free and found on the internet, or something you created-           yourself.
    Add at least the following accessibility options:
        Audio slides for both background music and sound effects,
        Dynamic resolution, v-sync, window options (full screen, borderless, windowed)
        Key rebinding. One input per action is fine.
