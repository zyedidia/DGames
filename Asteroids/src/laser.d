import std.stdio;
import std.algorithm;

import dsfml.graphics;

import app;
import dynamicSprite;
import resourceManager;
import util;
import constants;
import asteroid;

class Laser : DynamicSprite {
    this(Vector2f pos, float speed, float angle) {
        super(pos, speed, angle, ResourceManager.textures["laserBlue01.png"]);
        sprite.scale(Vector2f(SCALE, SCALE));
    }

    override
    void update() {
        Vector2f pos = sprite.position;
        FloatRect size = sprite.getLocalBounds();
        if (pos.x > SCREEN_WIDTH + size.width ||
            pos.x < -size.width ||
            pos.y > SCREEN_HEIGHT + size.height ||
            pos.y < -size.height) {
            if (lasers.length > 0 && lasers.countUntil(this) >= 0) {
                lasers = lasers.remove(lasers.countUntil(this));
            }
        }
        checkCollisions();
        super.update();
    }

    void checkCollisions() {
        foreach (a; asteroids) {
            if (sprite.getGlobalBounds().intersects(a.sprite.getGlobalBounds())) {
                if (lasers.length > 0 && lasers.countUntil(this) >= 0) {
                    lasers = lasers.remove(lasers.countUntil(this));
                }
                a.split();
            }
        }
    }
}
