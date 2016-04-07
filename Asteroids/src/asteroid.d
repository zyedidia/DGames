import std.stdio;
import std.random;
import std.algorithm;

import dsfml.graphics;

import app;
import dynamicSprite;
import resourceManager;
import util;
import constants;
import laser;

class Asteroid : DynamicSprite {
    this() {
        Vector2f randomPos = Vector2f(uniform(0, SCREEN_WIDTH), uniform(0, SCREEN_HEIGHT));
        float speed = uniform(0, 1) == 0 ? uniform(-maxAsteroidSpeed, -minAsteroidSpeed) : uniform(minAsteroidSpeed, maxAsteroidSpeed);
        super(randomPos, speed, uniform(0, 360), ResourceManager.textures["meteorBrown_big1.png"]);
        sprite.scale(Vector2f(SCALE, SCALE));
    }

    override
    void updatePosition() {
        wrap(sprite);
        super.updatePosition();
    }

    void split() {
        if (sprite.scale.x >= SCALE / (1.4)) {
            sprite.scale = Vector2f(sprite.scale.x / 1.4, sprite.scale.y / 1.4);
            Asteroid dup = new Asteroid();
            dup.sprite = sprite.dup();
            dup.angle = uniform(0, 360);
            dup.speed = speed;
            asteroids ~= dup;
        } else {
            if (asteroids.length > 0 && asteroids.countUntil(this) >= 0) {
                asteroids = asteroids.remove(asteroids.countUntil(this));
            }
        }
    }
}
