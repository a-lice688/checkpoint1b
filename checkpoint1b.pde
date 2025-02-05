// Alice Wang
// Jan 30, 2025
// Things I tried to do: a) A gradient sky; b) A setting sun; c) A gradient snowy ground;
// d) A house with a roof, a chimney, two windows, two sets of window dividers, a door, a doorknob, and four bushes;
// e) A snowman with a head, two body parts, two eyes, a carrot nose, three buttons, and two stick arms; f) Shadows for all objects

int Y_AXIS = 1;
int X_AXIS = 2;

float celestialX = - 20; //starts off-screen left
float celestialY = 500; //starts below ground
//float skyTransition = 0;
boolean day = true;
color dayTop, dayBottom, nightTop, nightBottom, groundLeftColour, groundRightColour, groundNightLeftColour, groundNightRightColour;


void setup() {
  size(1000, 600);
  
  dayTop = color(#5598AF); //day sky top
  dayBottom = color(#EAA75F); //day sky bottom
  nightTop = color(#2F3BB9); //night sky top
  nightBottom = color(#1B1F4E); //night sky bottom
  groundLeftColour = color(#FADBBD); //snowy ground left
  groundRightColour = color(#ABCFFC); //snowy ground right
  groundNightLeftColour = color(#A6ACB7); //snowy night ground left
  groundNightRightColour = color(#363F52); //snowy night ground right
  
}

void draw() {
  
  if (celestialX > width + 20) {
    celestialX = -20; 
    day = !day;
}

  if (day == true) {
    drawBackground();
    drawShadows();
    drawHouse();
    drawSnowman();
  } else {
    drawNight();
    drawShadows();
    drawHouse();
    drawSnowman();
  }
  
    drawCelestial();
    animateCelestial();
  
}

void drawBackground() {
  //Sky gradient (Top-to-bottom)
  setGradient(0, 0, width, 450, dayTop, dayBottom, Y_AXIS);

  //Ground gradient (Left-to-right)
  setGradient(0, 450, width, height - 450, groundLeftColour, groundRightColour, X_AXIS);
}

void drawNight() {
  //Night sky gradient 
  setGradient (0,0, width, 450, nightTop, nightBottom, Y_AXIS);
  
  //Night ground gradient
  setGradient (0, 450, width, height - 450, groundNightLeftColour, groundNightRightColour, X_AXIS);
}

void setGradient(int x, int y, float width, float height, color c1, color c2, int axis) {
  noFill();
  if (axis == Y_AXIS) {
    for (int i = y; i < y + height; i++) {
      float inter = map(i, y, y + height, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x + width, i);
    }
  } else if (axis == X_AXIS) {
    for (int i = x; i < x + width; i++) {
      float inter = map(i, x, x + width, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y + height);
    }
  }
}

void drawHouse() {

  //House body
  fill(#FFD700);
  stroke(0);
  rect(400, 300, 200, 200);

  //Roof
  fill(#FF4500);
  triangle(350, 300, 650, 300, 500, 200);

  //Door
  fill(#8B4513);
  rect(470, 400, 60, 100);

  //Doorknob
  fill(255, 204, 0);
  ellipse(520, 450, 10, 10);

  //Windows
  fill(#00BFFF);
  rect(420, 330, 50, 50);
  rect(530, 330, 50, 50);

  //Window Dividers
  stroke(0);
  line(445, 330, 445, 380);
  line(420, 355, 470, 355);

  line(555, 330, 555, 380);
  line(530, 355, 580, 355);

  //Chimney
  fill(#D2691E);
  rect(570, 230, 30, 50);

  //Bushes
  fill(#228B22);
  noStroke();
  ellipse(370, 470, 50, 50); //Bush#1
  ellipse(410, 480, 60, 60); //Bush#2
  ellipse(600, 480, 60, 60); //Bush#3
  ellipse(640, 470, 50, 50); //Bush#4
}

void drawShadows() {
  //All shadows are slightly to the right (to different extents) because the Sun is on the left
  if (day) {
    fill(130);
  } else {
    fill(50);
  }
  
  noStroke();

  //House shadow
  ellipse(525, 505, 220, 40);

  //Snowman shadow
  ellipse(275, 513, 90, 30);

  //Bush shadows
  ellipse(375, 495, 50, 20); //Bush#1
  ellipse(420, 505, 60, 25); //Bush#2
  ellipse(630, 505, 60, 25); //Bush#3
  ellipse(650, 495, 50, 30); //Bush#4
}

void drawSnowman() {
  fill(255);
  stroke(0);

  //Snowman body
  ellipse(270, 480, 70, 70); //Bottom
  ellipse(270, 430, 50, 50); //Middle
  ellipse(270, 390, 35, 35); //Head

  //Eyes
  fill(0);
  ellipse(263, 385, 5, 5);
  ellipse(277, 385, 5, 5);

  //Carrot nose
  fill(#FF4500);
  triangle(270, 390, 290, 390, 270, 395);

  //Buttons
  fill(0);
  ellipse(270, 420, 5, 5);
  ellipse(270, 440, 5, 5);

  //Stick arms
  stroke(139, 69, 19);
  line(250, 430, 220, 410);
  line(290, 430, 320, 410);
}

void drawCelestial() {
   noStroke();
   if (day) { //sun
     fill(#FFE250);
   } else { //moon
     fill(#D9D9D9);
  } ellipse(celestialX, celestialY, 100, 100);
}

void animateCelestial() {
  
 celestialX += 2;
 float angle = map(celestialX, - 20, width + 20, 0, PI); //had to look these up
 celestialY = 400 - 350 * sin(angle);
 
}
