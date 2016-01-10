import dsfml.graphics;
import constants;
import std.stdio;

class Paddle {
    Vector2f velocity;
    RectangleShape shape;

    int player;
    int score = 0;

    this(Vector2f pos, byte player = 0) {
        shape = new RectangleShape(Vector2f(10, 50));
        shape.fillColor = Color.White;
        shape.origin = Vector2f(5, 25);
        shape.position = pos;
        velocity = Vector2f(0, 0);

        this.player = player;
    }

    void update() {
        updateKeyInputs();
        updatePosition();
    }

    void updateKeyInputs() {
        auto up = up1;
        auto down = down1;
        if (player == 1) {
            up = up2;
            down = down2;
        }

        if (Keyboard.isKeyPressed(up)) {
            velocity.y = -PADDLE_VEL * X_SCALE;
        } else if (Keyboard.isKeyPressed(down)) {
            velocity.y = PADDLE_VEL * X_SCALE;
        } else {
            velocity.y = 0;
        }
    }

    void updatePosition() {
        shape.move(velocity);
    }

    void draw(RenderWindow w) {
        w.draw(shape);
    }
}
