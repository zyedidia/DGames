import dsfml.graphics;
import dsfml.audio;
import std.math;
import constants;
import std.stdio;
import std.c.time;
import std.random;
import std.parallelism;
import resourceManager;

import paddle;

class Ball {
    Vector2f velocity;
    RectangleShape shape;

    Paddle[] paddles;

    this(float speed, float angle, Paddle[] paddles) {
        shape = new RectangleShape(Vector2f(10, 10));
        shape.fillColor = Color.White;
        shape.origin = Vector2f(5, 5);
        shape.position = Vector2f(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);

        this.velocity = Vector2f(speed*cos(angle * (PI / 180)), speed*sin(angle * (PI / 180)));
        this.paddles = paddles;
    }

    void update() {
        checkCollision();
        updatePosition();
    }

    void checkCollision() {
        foreach (Paddle p; paddles) {
            if (p.shape.getGlobalBounds().intersects(shape.getGlobalBounds())) {
                velocity.x = -velocity.x;
                ResourceManager.sounds["hit_paddle.wav"].play();
            }
        }
        if (shape.position.y < 0 + shape.size.y / 2) {
            velocity.y = -velocity.y;
            ResourceManager.sounds["hit_wall.wav"].play();
        } else if (shape.position.y > SCREEN_HEIGHT - shape.size.y / 2) {
            velocity.y = -velocity.y;
            ResourceManager.sounds["hit_wall.wav"].play();
        } else if (shape.position.x < 0 + shape.size.x / 2) {
            paddles[1].score++;
            Thread thread = new Thread(&reset);
            thread.launch();
            ResourceManager.sounds["get_point.wav"].play();
        } else if (shape.position.x > SCREEN_WIDTH - shape.size.x / 2) {
            paddles[0].score++;
            Thread thread = new Thread(&reset);
            thread.launch();
            ResourceManager.sounds["get_point.wav"].play();
        }
    }

    void reset() {
        velocity = Vector2f(0, 0);
        shape.position = Vector2f(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        sleep(seconds(1));
        auto angle = uniform(0, 360f);
        auto speed = uniform(BALL_MIN, BALL_MAX);
        this.velocity = Vector2f(speed*cos(angle * (PI / 180)), speed*sin(angle * (PI / 180)));
    }

    void updatePosition() {
        shape.move(velocity);
    }

    void draw(RenderWindow window) {
        window.draw(shape);
    }
}
