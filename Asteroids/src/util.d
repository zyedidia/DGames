import std.string;
import std.math;

import dsfml.graphics;

import constants;

bool contains(string s, string s1) {
    return s.indexOf(s1) != -1;
}

float rad(float deg) {
    return deg * (PI / 180);
}

Vector2f fromPolar(float speed, float angle) {
    return Vector2f(speed * cos(angle * (PI / 180)), speed * sin(angle * (PI / 180)));
}

Vector2f toPolar(Vector2f velocity) {
    return Vector2f(atan2(velocity.y, velocity.x), sqrt(velocity.x * velocity.x + velocity.y * velocity.y));
}

void wrap(Sprite sprite) {
    Vector2f pos = sprite.position;
    FloatRect size = sprite.getLocalBounds();
    if (pos.x < -size.width / 2) {
        pos.x = SCREEN_WIDTH + size.width / 2;
    } else if (pos.x > SCREEN_WIDTH + size.width / 2) {
        pos.x = -size.width / 2;
    }
    
    if (pos.y < -size.height / 2) {
        pos.y = SCREEN_HEIGHT + size.height / 2;
    } else if (pos.y > SCREEN_HEIGHT + size.height / 2) {
        pos.y = -size.height / 2;
    }
    sprite.position = pos;
}
