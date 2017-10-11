ArrayList <Brick> bricks;
Ball ball;
Paddle paddle;

void setup() {
  size(500,500);
  background(0);
    ball = new Ball(width/2, height/2, 30, color(#13F05E));
  bricks = new ArrayList<Brick>();
    paddle = new Paddle(width/2, height - 30, width/5, 20, color(#DCE022));

 
 
 int brickWidth = width/10; //there are 10 bricks in each row, and it should take up the whole screen
 int brickHeight = height/40; //divide screen by 4, then by 10 for 10 bricks
 
 
  for (int i = 0; i < 10; i++) { //counter for bricks in row
     for (int j = 0; j < 10; j++) {  //counter for bricks in column
             //TODO: make a new Brick object called b here
            //make sure when your set the width and height for the brick, you do brickWidth-2 and brickHeight-2, so that there’s space between the bricks!
    //make sure your group of bricks starts a little down from the top of the screen - that way your ball can bounce above the bricks later!
          Brick b = new Brick(i*brickWidth, j*brickHeight + height/6, brickWidth-2, brickHeight-2, color(#982241));
         bricks.add(b); //uncomment this line once you’ve make your brick object!
             
     }    
  }

 
}

void draw() {

//clear the screen with black before drawing
//notice the 15 at the end of fill - this makes the game semi-translucent, and thus creates a blur effect - just for fun! You can get rid of that alpha value if you want.
  fill(0,0,0,15);
  rect(0,0,width,height);

//draw the bricks on the screen
//we are using a different kind of for loop here - a for: each loop
//this means, for each Brick in the ArrayList bricks, call the display() function on it.
for (Brick b: bricks) {
  b.display();
}



//TODO #5 and #6: display and move both the paddle and the ball
  ball.display();
  ball.move();
  paddle.display();
  paddle.move();

//TODO #7: code for what to do when the ball hits the paddle
  if (ball.x + ball.size/2 > paddle.x   //ball is to the right of the left side of the paddle
    && ball.x - ball.size/2 < paddle.x + paddle.pwidth //ball is to the left of right side of paddle
    && ball.y + ball.size/2 > paddle.y) {  //ball has crossed the top of the paddle

    ball.setVelocity(ball.vx, -ball.vy);          //negate the Y velocity of the ball
  }

//TODO #8: code for what to do when the ball hits a brick
for(int i = 0; i < bricks.size(); i++){
   Brick b = bricks.get(i);

   //only works if top of ball hits bottom of brick
   if((ball.x+ball.size/2) > b.x  //right edge of ball to right of left edge of brick
      && (ball.x-ball.size/2) < b.x + b.bwidth //left edge of ball to left of right edge of brick
      && ball.y - ball.size/2 < (b.y+b.bheight) //top edge of ball to the top of bottom edge of brick
      && ball.y + ball.size/2 > (b.y+b.bheight) ) { //bottom of ball is below bottom of brick

      ball.setVelocity(ball.vx, -ball.vy);
      bricks.remove(b);
   }
   //ADVANCED: Add another if to check when the bottom of the ball hits the top of a brick. 
   //This will only be necessary in your game when your ball is able to go *above* the brick stack! 
   //(ie when there’s only a few bricks left.)
  }


//TODO #9: code to check if you lost (when the ball hits the bottom of the screen
  if(ball.y + ball.size/2 > height) { 
      background(0); //erase everything
      text("you lost", width/2, height/2);
      ball.setVelocity(0, 0); //stop the ball so the game will stop
   }


}