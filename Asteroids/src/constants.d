import dsfml.window;

enum SCREEN_WIDTH = 1440;
enum SCREEN_HEIGHT = 900;

enum X_SCALE = SCREEN_WIDTH / 1440.0f;
enum Y_SCALE = SCREEN_HEIGHT / 900.0f;
enum SCALE = 0.35f;

enum controls1 = ["up": Keyboard.Key.Up,
                  "down": Keyboard.Key.Down, 
                  "left": Keyboard.Key.Left, 
                  "right": Keyboard.Key.Right, 
                  "shoot": Keyboard.Key.Space];

enum shipAccel = .05f;
enum shipMaxSpeed = 3.0f;

enum laserSpeed = 7f;

enum cooldownTime = 250; // In milliseconds

enum minAsteroidSpeed = 2f;
enum maxAsteroidSpeed = 4f;
