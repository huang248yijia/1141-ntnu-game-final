class Game {
  Player player1;
  Player player2;
  ArrayList<Platform> platforms;
  
  Game() {
    this(1); // Default to stage 1
  }
  
  Game(int stage) {
    // Player 1: WAD controls (A=left, D=right, W=jump)
    player1 = new Player(100, 100, color(100, 150, 255), 'a', 'd', 'w');
    // Player 2: Arrow keys (LEFT, RIGHT, UP)
    player2 = new Player(600, 100, color(255, 150, 100), LEFT, RIGHT, UP);
    
    // Initialize platforms
    platforms = getStageplatforms(stage - 1);
  }
  
  void createPlatforms1() {
    // Stage 1: Classic Arena
    platforms.add(new Platform(0, 500, 960, 40));
    platforms.add(new Platform(150, 400, 150, 20));
    platforms.add(new Platform(660, 400, 150, 20));
    platforms.add(new Platform(50, 300, 120, 20));
    platforms.add(new Platform(300, 250, 200, 20));
    platforms.add(new Platform(790, 300, 120, 20));
    platforms.add(new Platform(150, 150, 100, 20));
    platforms.add(new Platform(710, 150, 100, 20));
    platforms.add(new Platform(430, 80, 100, 20));
  }
  void createPlatforms2() {
    // Stage 2: Sky Towers
    platforms.add(new Platform(0, 500, 200, 40));
    platforms.add(new Platform(760, 500, 200, 40));
    platforms.add(new Platform(100, 380, 100, 20));
    platforms.add(new Platform(760, 380, 100, 20));
    platforms.add(new Platform(200, 260, 100, 20));
    platforms.add(new Platform(660, 260, 100, 20));
    platforms.add(new Platform(300, 140, 100, 20));
    platforms.add(new Platform(560, 140, 100, 20));
    platforms.add(new Platform(430, 60, 100, 20));
  }
  
  void createPlatforms3() {
    // Stage 3: Minimal Stage
    platforms.add(new Platform(0, 500, 960, 40));
    platforms.add(new Platform(200, 350, 150, 20));
    platforms.add(new Platform(610, 350, 150, 20));
    platforms.add(new Platform(380, 200, 200, 20));
  }


  
  void update() {
    player1.update(platforms);
    player2.update(platforms);
  }
  
  void display() {
    // Display platforms
    for (Platform p : platforms) {
      p.display();
    }
    
    // Display players
    player1.display();
    player2.display();
    
    // Display controls info
    fill(0);
    textSize(14);
    text("Player 1 (Blue): W=Jump, A=Left, D=Right", 10, 20);
    text("Player 2 (Orange): UP=Jump, LEFT, RIGHT", 10, 40);
  }
  
  void handleKeyPress(char k, int kc) {
    player1.handleKeyPress(k, kc);
    player2.handleKeyPress(k, kc);
  }
  
  void handleKeyRelease(char k, int kc) {
    player1.handleKeyRelease(k, kc);
    player2.handleKeyRelease(k, kc);
  }
}