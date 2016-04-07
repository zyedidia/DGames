import dsfml.graphics;

import std.math;

class DynamicSprite : Drawable {
    Sprite sprite;

    float angle;
    float speed;

    this(Vector2f pos, float speed, float angle, Texture texture) {
        this.speed = speed;
        this.angle = angle;

        sprite = new Sprite();
        sprite.setTexture(texture);
        sprite.position = pos;

        sprite.origin = Vector2f(texture.getSize().x / 2, texture.getSize().y / 2);
    }

    this(Sprite s) {
        this.sprite = s;
    }

    void update() {
        updatePosition();
    }

    void updatePosition() {
        sprite.rotation = angle + 90;
        Vector2f velocity = Vector2f(speed * cos(angle * (PI / 180)), speed * sin(angle * (PI / 180)));
        sprite.move(velocity);
    }

    void draw(RenderTarget target, RenderStates states) {
        target.draw(sprite);
    }

    auto dup() {
        DynamicSprite s = new DynamicSprite(sprite.dup());
        s.angle = angle;
        s.speed = speed;
        return s;
    }
}
