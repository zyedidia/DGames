import std.stdio;
import std.parallelism;

import dsfml.graphics;

import app;
import dynamicSprite;
import resourceManager;
import util;
import constants;
import laser;

class Ship : DynamicSprite {
    bool canShoot = true;

    this(Vector2f pos) {
        super(pos, 0, 0, ResourceManager.textures["playerShip2_blue.png"]);
        sprite.scale(Vector2f(SCALE, SCALE));
    }

    override
    void updatePosition() {
        wrap(sprite);
        super.updatePosition();
    }

    override
    void update() {
        super.update();
    }

    void accelerate() {
        if (speed < shipMaxSpeed) {
            speed += shipAccel;
        }
    }

    void decelerate() {
        if (speed < 0) {
            speed = 0;
        } else if (speed > 0) {
            speed -= shipAccel;
        }
    }

    void cooldown() {
        core.thread.Thread.sleep(core.thread.dur!("msecs")(cooldownTime));
        canShoot = true;
    }

    void shoot() {
        if (canShoot) {
            canShoot = false;
            Laser l = new Laser(sprite.position, laserSpeed, angle);
            lasers ~= l;
            Thread thread = new Thread(&cooldown);
            thread.launch();
            ResourceManager.sounds["recording.ogg"].play();
        }
    }
}

class PlayerShip : Ship {
    Keyboard.Key[string] controls;

    this(Vector2f pos) {
        super(pos);
    }

    void updateInputs() {
        if (Keyboard.isKeyPressed(controls["up"])) {
            accelerate();
        } else {
            decelerate();
        } 
        if (Keyboard.isKeyPressed(controls["left"])) {
            angle -= 2;
        } 
        if (Keyboard.isKeyPressed(controls["right"])) {
            angle += 2;
        }
        if (Keyboard.isKeyPressed(controls["shoot"])) {
            shoot();
        }
    }

    override
    void update() {
        updateInputs();
        super.update();
    }
}
