import std.stdio;

import dsfml.graphics;

import std.algorithm;
import resourceManager;
import dynamicSprite;
import constants;
import ship;
import laser;
import asteroid;

Laser[] lasers;
// Laser[] lasersToRemove;
Asteroid[] asteroids;

void main(string[] args) {
    ResourceManager.init(args[0]);
    ResourceManager.loadSounds();
    ResourceManager.loadTextures();

    auto window = new RenderWindow(VideoMode(SCREEN_WIDTH, SCREEN_HEIGHT), "Asteroids");
    window.setFramerateLimit(60);
    window.setVerticalSyncEnabled(true);

    Texture texture = new Texture();
    if (!texture.loadFromFile(ResourceManager.RES_PATH ~ "/img/playerShip1_blue.png")) { 
        writeln("Error: could not load playerShip1_blue.png");
    }

    PlayerShip s = new PlayerShip(Vector2f(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2));
    s.controls = controls1;

    for (int i = 0; i < 5; i++) {
        asteroids ~= new Asteroid();
    }

    while (window.isOpen()) {
        Event event;

        while(window.pollEvent(event)) {
            if(event.type == event.EventType.Closed) {
                window.close();
            }
        }

        s.update();
        foreach (l; lasers) {
            l.update();
        }
        foreach (m; asteroids) {
            m.update();
        }

        window.clear();

        foreach (l; lasers) {
            window.draw(l);
        }
        foreach (m; asteroids) {
            window.draw(m);
        }

        window.draw(s);
        window.display();
    }
}
