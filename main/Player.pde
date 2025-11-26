class Player {
  PVector pos;
  PVector wh;
  PVector vel;
  float speed;
  float jumpForce;
  float gravity;
  boolean onGround;
  color playerColor;
  int type;
  
  // Controls
  int leftKey, rightKey, jumpKey;
  boolean movingLeft, movingRight, jumping;
  
  Player(float x, float y, color c, int leftKey, int rightKey, int jumpKey, int type) {
    this.pos = new PVector(x, y);
    this.wh = new PVector(30, 40);
    this.vel = new PVector(0, 0);
    this.speed = 5;
    this.jumpForce = 12;
    this.gravity = 0.6;
    this.onGround = false;
    this.playerColor = c;
    this.type = type;
    
    this.leftKey = leftKey;
    this.rightKey = rightKey;
    this.jumpKey = jumpKey;
    this.movingLeft = false;
    this.movingRight = false;
    this.jumping = false;
  }
  
  void update(ArrayList<Platform> platforms) {
    // Horizontal movement
    vel.x = 0;
    if (movingLeft) {
      vel.x = -speed;
    }
    if (movingRight) {
      vel.x = speed;
    }
    
    // Apply gravity
    vel.y += gravity;
    
    // Limit fall speed
    if (vel.y > 15) {
      vel.y = 15;
    }
    
    // Jump
    if (jumping && onGround) {
      vel.y = -jumpForce;
      onGround = false;
    }
    
    // Update position
    pos.add(vel);
    
    // Check platform collisions
    onGround = false;
    for (Platform p : platforms) {
      // Top collision (landing on platform)
      if (p.checkTopCollision(pos, wh, vel.y)) {
        pos.y = p.pos.y - wh.y;
        vel.y = 0;
        onGround = true;
      }
      // Side collisions
      else if (p.overlaps(pos, wh)) {
        // Coming from left
        if (vel.x > 0 && pos.x + wh.x > p.pos.x && pos.x < p.pos.x) {
          pos.x = p.pos.x - wh.x;
        }
        // Coming from right
        else if (vel.x < 0 && pos.x < p.pos.x + p.wh.x && pos.x + wh.x > p.pos.x + p.wh.x) {
          pos.x = p.pos.x + p.wh.x;
        }
        // Bottom collision (hitting head)
        else if (vel.y < 0 && pos.y < p.pos.y + p.wh.y && pos.y + wh.y > p.pos.y + p.wh.y) {
          pos.y = p.pos.y + p.wh.y;
          vel.y = 0;
        }
      }
    }
    
    // Keep player in bounds
    if (pos.x < 0) pos.x = 0;
    if (pos.x + wh.x > width) pos.x = width - wh.x;
    if (pos.y + wh.y > height) {
      pos.y = height - wh.y;
      vel.y = 0;
      onGround = true;
    }
  }
  
  void display() {
    // Draw body
    fill(playerColor);
    stroke(0);
    strokeWeight(2);
    rect(pos.x, pos.y, wh.x, wh.y);
    
    // Type 1: Default - Simple character with eyes
    if (type == 0) {
      fill(255);
      ellipse(pos.x + wh.x * 0.3, pos.y + wh.y * 0.3, 5, 5);
      ellipse(pos.x + wh.x * 0.7, pos.y + wh.y * 0.3, 5, 5);
    }
    
    // Type 2: Ninja - Headband and mask
    else if (type == 1) {
      // Headband
      fill(255, 0, 0);
      noStroke();
      rect(pos.x, pos.y + wh.y * 0.15, wh.x, wh.y * 0.15);
      
      // Eyes
      fill(255);
      ellipse(pos.x + wh.x * 0.3, pos.y + wh.y * 0.35, 6, 6);
      ellipse(pos.x + wh.x * 0.7, pos.y + wh.y * 0.35, 6, 6);
      
      // Mask covering lower face
      fill(0, 0, 50);
      noStroke();
      rect(pos.x + wh.x * 0.1, pos.y + wh.y * 0.5, wh.x * 0.8, wh.y * 0.25);
      
      stroke(0);
      strokeWeight(2);
    }
    
    // Type 3: Knight - Helmet and armor
    else if (type == 2) {
      // Helmet visor
      fill(150, 150, 150);
      noStroke();
      rect(pos.x, pos.y, wh.x, wh.y * 0.5);
      
      // Visor slit (eyes)
      fill(50);
      rect(pos.x + wh.x * 0.15, pos.y + wh.y * 0.25, wh.x * 0.7, wh.y * 0.1);
      
      // Armor chest plate
      fill(200, 200, 200);
      rect(pos.x + wh.x * 0.1, pos.y + wh.y * 0.55, wh.x * 0.8, wh.y * 0.35);
      
      // Chest decoration
      fill(255, 215, 0);
      ellipse(pos.x + wh.x * 0.5, pos.y + wh.y * 0.7, wh.x * 0.3, wh.y * 0.2);
      
      stroke(0);
      strokeWeight(2);
    }
    
    // Type 4: Wizard - Hat and robe details
    else if (type == 3) {
      // Wizard hat
      fill(100, 50, 200);
      noStroke();
      triangle(pos.x + wh.x * 0.5, pos.y - wh.y * 0.5, 
               pos.x, pos.y + wh.y * 0.2,
               pos.x + wh.x, pos.y + wh.y * 0.2);
      
      // Hat brim
      rect(pos.x - wh.x * 0.1, pos.y + wh.y * 0.15, wh.x * 1.2, wh.y * 0.1);
      
      // Eyes
      fill(255);
      ellipse(pos.x + wh.x * 0.3, pos.y + wh.y * 0.35, 6, 6);
      ellipse(pos.x + wh.x * 0.7, pos.y + wh.y * 0.35, 6, 6);
      
      // Beard
      fill(200, 200, 200);
      triangle(pos.x + wh.x * 0.5, pos.y + wh.y * 0.5,
               pos.x + wh.x * 0.2, pos.y + wh.y * 0.9,
               pos.x + wh.x * 0.8, pos.y + wh.y * 0.9);
      
      // Robe belt
      fill(255, 215, 0);
      rect(pos.x + wh.x * 0.1, pos.y + wh.y * 0.6, wh.x * 0.8, wh.y * 0.1);
      
      // Stars on robe
      fill(255, 255, 0);
      ellipse(pos.x + wh.x * 0.3, pos.y + wh.y * 0.75, 3, 3);
      ellipse(pos.x + wh.x * 0.7, pos.y + wh.y * 0.8, 3, 3);
      
      stroke(0);
      strokeWeight(2);
    }
    
    // Default fallback (same as type 1)
    else {
      fill(255);
      ellipse(pos.x + wh.x * 0.3, pos.y + wh.y * 0.3, 5, 5);
      ellipse(pos.x + wh.x * 0.7, pos.y + wh.y * 0.3, 5, 5);
    }
  }
  
  void handleKeyPress(int k, int kc) {
    if (k == leftKey || kc == leftKey) {
      movingLeft = true;
    }
    if (k == rightKey || kc == rightKey) {
      movingRight = true;
    }
    if (k == jumpKey || kc == jumpKey) {
      jumping = true;
    }
  }
  
  void handleKeyRelease(int k, int kc) {
    if (k == leftKey || kc == leftKey) {
      movingLeft = false;
    }
    if (k == rightKey || kc == rightKey) {
      movingRight = false;
    }
    if (k == jumpKey || kc == jumpKey) {
      jumping = false;
    }
  }
}
