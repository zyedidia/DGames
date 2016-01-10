import dsfml.graphics;
import std.conv;
import std.random;
import std.stdio;
import std.path;
import paddle;
import ball;
import constants;
import resourceManager;

void main(string[] args) {
    Font font = new Font();
    if (!font.loadFromFile(dirName(args[0]) ~ "/res/pong.ttf")) {
        writeln("Error loading font!");
    }

    ResourceManager.loadSounds(dirName(args[0]) ~ "/res");

    RenderWindow window = new RenderWindow(VideoMode(SCREEN_WIDTH, SCREEN_HEIGHT), "Pong");
    window.setFramerateLimit(60);
    window.setVerticalSyncEnabled(true);

    // Player 1
    Paddle p1 = new Paddle(Vector2f(SCREEN_WIDTH - 100.0f * X_SCALE, SCREEN_HEIGHT / 2));
    // Player 2
    Paddle p2 = new Paddle(Vector2f(100.0f * X_SCALE, SCREEN_HEIGHT / 2), 1);

    Text scoreText1 = new Text();
    scoreText1.setFont(font);
    scoreText1.setCharacterSize(36);
    scoreText1.setColor(Color.White);
    scoreText1.position = Vector2f(200 * X_SCALE, 100 * Y_SCALE);

    Text scoreText2 = new Text();
    scoreText2.setFont(font);
    scoreText2.setCharacterSize(36);
    scoreText2.setColor(Color.White);
    scoreText2.position = Vector2f(SCREEN_WIDTH - 200 * X_SCALE, 100 * Y_SCALE);

    Ball b = new Ball(uniform(BALL_MIN, BALL_MAX), uniform(0, 360f), [p1, p2]);

    while (window.isOpen()) {
        Event event;

        while(window.pollEvent(event)) {
            if(event.type == event.EventType.Closed) {
                window.close();
            }
        }

        p1.update();
        p2.update();
        b.update();

        scoreText1.setString(to!string(p1.score));
        scoreText2.setString(to!string(p2.score));

        window.clear();
        p1.draw(window);
        p2.draw(window);
        b.draw(window);

        window.draw(scoreText1);
        window.draw(scoreText2);

        window.display();
    }
}
