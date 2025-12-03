class Game {
  Player player1;
  Player player2;
  ArrayList<Platform> platforms;
  
  
  Game(int stage, int type1, int type2) {
    // Player 1: WAD controls (A=left, D=right, W=jump)
    player1 = new Player(100, 100, color(100, 150, 255), 'a', 'd', 'w', 'e', type1);
    // Player 2: Arrow keys (LEFT, RIGHT, UP)
    player2 = new Player(600, 100, color(255, 150, 100), LEFT, RIGHT, UP, 'k', type2);
    
    // 設定角色特殊能力
    if (type1 == 0) player1.setBomberMode();
    if (type2 == 0) player2.setBomberMode();
    
    // Initialize platforms
    platforms = getStageplatforms(stage);
  }
  
  void update() {
    player1.update(platforms, player2);
    player2.update(platforms, player1);
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
    textAlign(LEFT, CENTER);
    
    // Player 1 控制說明（根據角色類型）
    String p1Controls = "Player 1 (Blue): W=Jump, A=Left, D=Right";
    if (player1.type == 0) {
      p1Controls += ", E=Bomb (Double Jump for 3x high!)";
    } else if (player1.type == 1) {
      p1Controls += " (Ninja)";
    } else if (player1.type == 2) {
      p1Controls += " (Knight)";
    } else if (player1.type == 3) {
      p1Controls += " (Wizard)";
    }
    text(p1Controls, 10, 20);
    
    // Player 2 控制說明（根據角色類型）
    String p2Controls = "Player 2 (Orange): UP=Jump, LEFT/RIGHT=Move";
    if (player2.type == 0) {
      p2Controls += ", K=Bomb (Double Jump for 3x high!)";
    } else if (player2.type == 1) {
      p2Controls += " (Ninja)";
    } else if (player2.type == 2) {
      p2Controls += " (Knight)";
    } else if (player2.type == 3) {
      p2Controls += " (Wizard)";
    }
    text(p2Controls, 10, 40);
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
