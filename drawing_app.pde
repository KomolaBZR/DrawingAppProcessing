import processing.sound.*;
import processing.video.*;

Capture cam;
//Attribute
float oldX;
float oldY;
//undo
Undo undo;
ArrayList list = new ArrayList();
float joinDist = 90;
SoundFile sound, delete, camera;
boolean penBoolean, ssmall = true;
boolean blackB = true;
boolean eraserBoolean, brushBoolean, circleB, squareB, triangleB, starB, image, smedium, sbig, shuge= false;
boolean rotB, greenB, blueB, orangeB, yellowB = false;


//int strokesize=1;
int r, g, b = 0;
PImage background;

PImage  partialSave ;

PImage brush1;

float prevMouseX=0;
float prevMouseY=0;

int num = 0;

//Kamera
String[] cameras = Capture.list();
PImage undos;
PImage redo;
PImage camera1;
PImage save;
PImage bin;
PImage brush2;
PImage brush3;
PImage pen1;
PImage pen2;
PImage eraser1;
PImage eraser2;
PImage doneF;
PImage picture;





void setup() {

  size(1300, 800);
  undo = new Undo(20);

  //soundfile
  sound = new SoundFile(this, "click2.wav");
  delete  = new SoundFile(this, "delete.wav");
  // camera = new SoundFile(this,"camera.wav");

  //Balken oben,unten,links,rechts
  fill(156, 192, 226);
  noStroke();
  rect(0, 0, width, height);

  //Zeichenflaeche
  fill(255, 255, 255);
  rect(50, 150, width -400, height-200, 10, 10, 10, 10);

  //Boxes for the tools
  fill(16, 78, 139);
  //oben menue
  tint(255, 255, 255);
  rect(50, 25, width -400, 100, 10, 10, 10, 10);
  undos = loadImage("undo.png");
  image(undos, 75, 35);
  redo = loadImage("redo.png");
  image(redo, 175, 35);
  fill(156, 192, 226);
  ellipse(325, 75, 75, 75);
  camera1 = loadImage("camera.png");
  image(camera1, 298, 48, 55, 55);

  fill(156, 192, 226);
  ellipse(425, 75, 75, 75);
  picture= loadImage("picture.png");
  image(picture, 398, 48, 55, 55);

  fill(156, 192, 226);
  ellipse(525, 75, 75, 75);
  save = loadImage("save.png");
  image(save, 498, 48, 55, 55);

  fill(156, 192, 226);
  ellipse(890, 75, 75, 75);
  bin = loadImage("bin.png");
  image(bin, 863, 48, 55, 55);


  //Kamera

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    //// The camera can be initialized directly using an
    //// element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    tint(255, 255, 255);
    cam.start();
  }


  //boxes
  fill(16, 78, 139);
  rect(width -325, 150, 300, 183, 10, 10, 10, 10);
  rect(width -325, 358, 300, 183, 10, 10, 10, 10);
  rect(width-325, 566, 300, 183, 10, 10, 10, 10);
  rect(width -325, 25, 300, 100, 10, 10, 10, 10);

  //colors
  //black

  fill(0, 0, 0);
  ellipse(width - 270, 200, 66, 66);

  //red
  fill(255, 0, 0);
  ellipse(width - 180, 200, 66, 66);
  //green
  fill(0, 255, 0);
  ellipse(width - 90, 200, 66, 66);
  //gelb
  fill(255, 255, 0);
  ellipse(width - 270, 280, 66, 66);
  //orange
  fill(255, 127, 0);
  ellipse(width -180, 280, 66, 66);
  //blue
  fill(0, 0, 255);
  ellipse(width -90, 280, 66, 66);



  //brush,pencil,eraser
  fill(255, 255, 255);

  //  ellipse(width - 260, 420, 90, 90);
  //  ellipse(width - 90, 420, 90, 90);
  //  ellipse(width -175, 480, 90, 90);

  //brush = loadImage("brush.png");
  brush2= loadImage("brush2.png");
  brush3 = loadImage("brush3.png");
  // image(brush, width -115, 395, 50, 50);

  pen1 = loadImage("pen1.png");
  pen2 = loadImage("pen2.png");
  //pen = loadImage("pen.png");
  // image(pen, width -285, 395, 50, 50);


  // eraser = loadImage("eraser.png");
  eraser1 = loadImage("eraser1.png");
  eraser2 = loadImage("eraser2.png");
  //image(eraser, width -200, 455, 50, 50);
  //Formen unterste Box
  ellipse(width -100, 615, 80, 80);
  rect(width -285, 580, 70, 70);
  star(width -250, 700, 20, 40, 5);
  triangle(width -100, 670, width-60, 730, width - 140, 730);

  //strokeweight
  fill(0, 0, 0);
  ellipse(width - 290, 75, 10, 10);
  ellipse(width - 235, 75, 20, 20);
  ellipse(width - 170, 75, 45, 45);
  ellipse(width - 90, 75, 60, 60);

  undo.takeSnapshot();

  brush1 = loadImage("brush1.png");

  doneF = loadImage("doneF.png");


  strokeWeight(6);
  if (ssmall) {
    strokeWeight(6);
  }
  if (smedium) {
    strokeWeight(15);
  }
  if (sbig) {
    strokeWeight(40);
  }
  if (shuge) {
    strokeWeight(60);
  }
}

void draw() {


  if (image) {
    //load Background image
    if (background != null) {
      tint(255, 255, 255);
      image(background, 50, 150, 900, 600);
      image = false;
    }
  }
  tint(255, 255, 255);


  if (mousePressed) {
    //strokeweight

    if (mouseX> 995 && mouseX < 1025) {
      if (mouseY > 60 &&mouseY < 90) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        //  strokeWeight(1);
        strokeWeight(6);
        ssmall = true;
        smedium = false;
        sbig = false;
        shuge = false;
      }
    }
    if (mouseX> 1045 && mouseX < 1085) {
      if (mouseY > 55 &&mouseY < 95) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        // strokeWeight(3);
        strokeWeight(15);
        ssmall = false;
        smedium = true;
        sbig = false;
        shuge = false;
      }
    }
    if (mouseX> 1105 && mouseX < 1155) {
      if (mouseY > 50 &&mouseY < 100) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        //strokeWeight(5);
        strokeWeight(40);
        ssmall = false;
        smedium = false;
        sbig = true;
        shuge = false;
      }
    }

    if (mouseX> 1180 && mouseX < 1240) {
      if (mouseY > 45 &&mouseY < 105) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        //strokeWeight(8);
        strokeWeight(60);
        ssmall = false;
        smedium = false;
        sbig = false;
        shuge = true;
      }
    }


    //color
    //schwarz
    if (mouseX > 997 && mouseX < 1063) {
      if (mouseY> 167 && mouseY < 233) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(0, 0, 0);
        r = 0;
        g =0;
        b = 0;

        blackB =true;
        rotB = false;
        greenB = false;
        blueB = false;
        orangeB = false;
        yellowB = false;
      }
    }
    //rot
    if (mouseX > 1087 && mouseX < 1153) {
      if (mouseY> 167 && mouseY < 233) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(255, 0, 0);
        r = 255;
        g =0;
        b = 0;

        blackB = false;
        rotB = true;
        greenB = false;
        blueB = false;
        orangeB = false;
        yellowB = false;
      }
    }

    //blau
    if (mouseX > 1177 && mouseX < 1243) {
      if (mouseY> 247 && mouseY < 313) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(0, 0, 255);
        r = 0;
        g =0;
        b = 255;
        blackB = false;
        rotB = false;
        greenB = false;
        blueB = true;
        orangeB = false;
        yellowB = false;
      }
    }
    //gruen
    if (mouseX > 1177 && mouseX < 1243) {
      if (mouseY> 167 && mouseY < 233) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(0, 255, 0);
        r = 0;
        g =255;
        b = 0;
        blackB = false;
        rotB = false;
        greenB = true;
        blueB = false;
        orangeB = false;
        yellowB = false;
      }
    }
    //gelb
    if (mouseX > 997 && mouseX < 1063) {
      if (mouseY> 247 && mouseY < 313) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(255, 255, 0);
        r = 255;
        g =255;
        b = 0;
        blackB = false;
        rotB = false;
        greenB = false;
        blueB = false;
        orangeB = false;
        yellowB = true;
      }
    }
    //orange
    if (mouseX > 1087 && mouseX < 1153) {
      if (mouseY> 247 && mouseY < 313) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        stroke(255, 165, 0);
        r =255;
        g =165;
        b = 0;

        blackB = false;
        rotB = false;
        greenB = false;
        blueB = false;
        orangeB = true;
        yellowB = false;
      }
    }

    //pen true
    if (mouseX >995 && mouseX < 1085) {
      if (mouseY >375 && mouseY<465) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = true;
        circleB = false;
        triangleB = false;
        squareB = false;
        starB = false;
        eraserBoolean =false;
      }
    }

    //brush true
    if (mouseX >1165 && mouseX < 1255) {
      if (mouseY >375 && mouseY<465) {
        if (!sound.isPlaying()) {
          sound.play();
        }

        brushBoolean =true;
        penBoolean = false;
        circleB = false;
        triangleB = false;
        squareB = false;
        starB = false;
        eraserBoolean =false;
      }
    }
    //square true
    if (mouseX >1015 && mouseX < 1085) {
      if (mouseY >580 && mouseY<650) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = false;
        circleB = false;
        triangleB = false;
        squareB = true;
        starB = false;
        eraserBoolean =false;
      }
    }

    //circle true
    if (mouseX >1160 && mouseX < 1240) {
      if (mouseY >575 && mouseY<655) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = false;
        circleB = true;
        triangleB = false;
        squareB = false;
        starB = false;
        eraserBoolean =false;
      }
    }
    //triangle true
    if (mouseX >1160 && mouseX < 1240) {
      if (mouseY >670 && mouseY<730) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = false;
        circleB = false;
        triangleB = true;
        squareB = false;
        starB = false;
        eraserBoolean =false;
      }
    }

    //star true
    if (mouseX >1000 && mouseX < 1090) {
      if (mouseY >665 && mouseY<745) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = false;
        circleB = false;
        triangleB = false;
        squareB = false;
        starB = true;
        eraserBoolean =false;
      }
    }

    //eraser
    if (mouseX> 1080 && mouseX < 1170) {
      if (mouseY > 435 && mouseY < 525) {
        if (!sound.isPlaying()) {
          sound.play();
        }
        brushBoolean =false;
        penBoolean = false;
        circleB = false;
        triangleB = false;
        squareB = false;
        starB = false;
        eraserBoolean =true;


        blackB = false;
        rotB = false;
        greenB = false;
        blueB = false;
        orangeB = false;
        yellowB = false;
      }
    }


    //Delete
    if (mouseX> 853 && mouseX< 928) {
      if (mouseY> 38 && mouseY < 113) {
        if (!delete.isPlaying()) {
          delete.play();
        }
        setup();
      }
    }
    //picture
    if (mouseX > 388 && mouseX <462) {
      if (mouseY>38 && mouseY < 113) {
        //load Background image
        if (background != null) {
          image(background, 50, 150, 900, 600);
        }
      }
    }
    if (mouseX > 288 && mouseX <362) {
      if (mouseY>38 && mouseY < 113) {
        if (cam.available() == true) {
          cam.read();
        }
        image(cam, 50, 150, width -400, height -200);
      }
    }
  }


  //linie zeichnen
  if (mousePressed) {
    if (mouseX > 55 && mouseX < 940) {
      if (mouseY > 165 && mouseY < 745 ) {
        if (penBoolean == true) {
          line(mouseX, mouseY, oldX, oldY);
        } else if (brushBoolean ==true) {
          //Variant 2
          float brushAngle = atan2(mouseX - prevMouseX, mouseY - prevMouseY);

          for (int i = 0; i<5; i++) {
            float jiggelColor = random(-255, 255);
            fill(r, g, b);
            // tint(101+jiggelColor,0,170+jiggelColor,200);
            tint(r+jiggelColor, g, b+jiggelColor, 100);

            pushMatrix();
            float jiggel = random(-5, 5);
            translate(mouseX + jiggel, mouseY + jiggel);

            float jiggelAngle = random(-20, 20);
            // rotate(brushAngle + ((3*PI)/2));
            rotate(brushAngle + (radians(90+jiggelAngle)));


            float jiggleScale = random(-0.01, 0.01);
            if (ssmall) {
              scale(.01 + jiggleScale);
            }

            if (smedium) {
              scale(.02 + jiggleScale);
            }
            if (sbig) {
              scale(.04 + jiggleScale);
            }
            if (shuge) {
              scale(.09 + jiggleScale);
            }
            // scale(.04 + jiggleScale);
            image(brush1, 0, 0);
            popMatrix();
          }
        } else if (eraserBoolean == true) {
          stroke(255, 255, 255);
          line(mouseX, mouseY, oldX, oldY);
        }
      }
      noStroke();
      fill(156, 192, 226);
      // fill(0);
      rect(width-350, 120, 25, height-110);
      rect(0, 120, 50, height-110);
      rect(50, height-50, width-390, 50);
      rect(50, 125, width-390, 25);
      stroke(r, g, b);
    }
    if (mouseX > 50 && mouseX < 905) {
      if (mouseY > 170 && mouseY < height-50) {

        if (squareB ==true) {
          fill(r, g, b);
          strokeWeight(6);
          ssmall = true;
          smedium = false;
          sbig = false;
          shuge = false;
          rect(mouseX, mouseY, 70, 70);
        } else if (circleB ==true) {
          fill(r, g, b);
          strokeWeight(6);
          ssmall = true;
          smedium = false;
          sbig = false;
          shuge = false;
          ellipse(mouseX, mouseY, 80, 80);
        } else if (triangleB ==true) {
          fill(r, g, b);
          ssmall = true;
          smedium = false;
          sbig = false;
          shuge = false;
          strokeWeight(6);
          triangle(mouseX, mouseY, mouseX -35, mouseY+60, mouseX+35, mouseY+60);
        } else if (starB == true) {
          fill(r, g, b);
          strokeWeight(6);
          ssmall = true;
          smedium = false;
          sbig = false;
          shuge = false;
          star(mouseX, mouseY, 20, 40, 5);
        }
      }
      noStroke();
      fill(156, 192, 226);
      // fill(0);
      rect(width-350, 120, 25, height-110);
      rect(0, 120, 50, height-110);
      rect(50, height-50, width-390, 50);
      rect(50, 125, width-390, 25);
      stroke(r, g, b);
    }
  }




  if (shuge) {
    noStroke();
    fill(0);
    ellipse(width - 90, 75, 60, 60);
    tint(255, 255, 255);
    image(doneF, width -110, 55, 40, 40);
  } else {
    noStroke();
    fill(0);
    ellipse(width - 90, 75, 60, 60);
  }

  if (sbig) {
    noStroke();
    fill(0);
    ellipse(width - 170, 75, 45, 45);
    tint(255, 255, 255);
    image(doneF, width -189, 57, 35, 35);
  } else {
    noStroke();
    fill(0);
    ellipse(width - 170, 75, 45, 45);
  }

  if (smedium) {
    noStroke();
    fill(0);
    ellipse(width - 235, 75, 30, 30);
    tint(255, 255, 255);
    image(doneF, width -246, 63, 20, 20);
  } else {
    noStroke();
    fill(0);
    ellipse(width - 235, 75, 30, 30);
  }

  if (ssmall) {
    noStroke();
    fill(0);
    ellipse(width - 290, 75, 10, 10);
    tint(255, 255, 255);
    image(doneF, width -293, 72, 5, 5);
  } else {
    noStroke();
    fill(0);
    ellipse(width - 290, 75, 10, 10);
  }


  if (blackB) {
    noStroke();
    fill(0, 0, 0);
    ellipse(width - 270, 200, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -289, 180, 40, 40);
  } else {
    noStroke();
    fill(0, 0, 0);
    ellipse(width - 270, 200, 66, 66);
  }

  if (rotB) {
    noStroke();
    fill(255, 0, 0);
    ellipse(width - 180, 200, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -199, 180, 40, 40);
  } else {
    noStroke();
    fill(255, 0, 0);
    ellipse(width - 180, 200, 66, 66);
  }

  if (greenB) {
    noStroke();
    fill(0, 255, 0);
    ellipse(width - 90, 200, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -109, 180, 40, 40);
  } else {
    noStroke();
    fill(0, 255, 0);
    ellipse(width - 90, 200, 66, 66);
  }

  if (yellowB) {
    noStroke();
    fill(255, 255, 0);
    ellipse(width - 270, 280, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -289, 260, 40, 40);
  } else {
    noStroke();
    fill(255, 255, 0);
    ellipse(width - 270, 280, 66, 66);
  }

  if (orangeB) {
    noStroke();
    fill(255, 127, 0);
    ellipse(width -180, 280, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -199, 260, 40, 40);
  } else {
    noStroke();
    fill(255, 127, 0);
    ellipse(width -180, 280, 66, 66);
  }

  if (blueB) {
    noStroke();
    fill(0, 0, 255);
    ellipse(width -90, 280, 66, 66);
    tint(255, 255, 255);
    image(doneF, width -109, 260, 40, 40);
    stroke(r, g, b);
  } else {
    noStroke();
    fill(0, 0, 255);
    ellipse(width -90, 280, 66, 66);
    stroke(r, g, b);
  }

  if (squareB) {
    noStroke();
    fill(255);
    rect(width -285, 580, 70, 70);
    tint(255, 255, 255);
    image(doneF, width -285, 580, 65, 65);
    stroke(r, g, b);
  } else {
    noStroke();
    fill(255);
    rect(width -285, 580, 70, 70);
    stroke(r, g, b);
  }

  if (circleB) {
    noStroke();
    fill(255);
    ellipse(width -100, 615, 80, 80);
    tint(255, 255, 255);
    image(doneF, width -135, 580, 65, 65);
    stroke(r, g, b);
  } else {
    noStroke();
    fill(255);
    ellipse(width -100, 615, 80, 80);
    stroke(r, g, b);
  }


  if (triangleB) {
    noStroke();
    fill(255);
    triangle(width -100, 670, width-60, 730, width - 140, 730);
    tint(255, 255, 255);
    image(doneF, width -125, 685, 40, 40);
    stroke(r, g, b);
  } else {
    noStroke();
    fill(255);
    triangle(width -100, 670, width-60, 730, width - 140, 730);
    stroke(r, g, b);
  }

  if (starB) {
    noStroke();
    fill(255);
    star(width -250, 700, 20, 40, 5);
    tint(255, 255, 255);
    image(doneF, width -272, 678, 40, 40);
    stroke(r, g, b);
  } else {
    noStroke();
    fill(255);
    star(width -250, 700, 20, 40, 5);
    stroke(r, g, b);
  }



  if (penBoolean) {
    stroke(r, g, b);
    tint(255, 255, 255);
    image(pen2, width -300, 375, 90, 90);
  } else {
    stroke(r, g, b);
    tint(255, 255, 255);
    image(pen1, width -300, 375, 90, 90);
  }


  if (brushBoolean) {
    image(brush3, width -140, 375, 90, 90);
  } else {
    image(brush2, width -140, 375, 90, 90);
  }

  if (eraserBoolean) {
    image(eraser2, width -220, 435, 90, 90);
  } else {
    image(eraser1, width -220, 435, 90, 90);
  }


  oldX = mouseX;
  oldY=mouseY;

  //für SaveButton
  partialSave = get(50, 150, width -400, height -200);
}



//image as Background
void imageSelected(File selection) {
  if (selection == null) {
    println("no Image chosen");
  } else {
    String path = selection.getAbsolutePath();
    background = loadImage(path);
    image = true;
  }
}




void mousePressed() {
  //für SaveButton
  if (mouseX >488 && mouseX <563) {
    if (mouseY> 38 && mouseY < 113) {
      selectFolder("Select a folder to process:", "folderSelected");
    }
  }

  //image as Background
  if (mouseX > 388 && mouseX <462) {
    if (mouseY>38 && mouseY < 113) {
      //cam.stop();
      selectInput("Select an Image to use as a Background!", "imageSelected");
    }
  }



  //Undo
  if (mouseX<150&&mouseX>50&&mouseY>30&&mouseY<110&&mousePressed)
  {
    undo.undo();
  }
  //redo
  if (mouseX<259&&mouseX>175&&mouseY>30&&mouseY<120&&mousePressed)
  {
    undo.redo();
  }
}





void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI/npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a< TWO_PI; a+=angle) {
    float sx = x + cos(a) * radius2;
    float sy = y +sin(a) *radius2;
    vertex(sx, sy);
    sx = x +cos(a+halfAngle) *radius1;
    sy = y + sin(a+halfAngle) *radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void mouseReleased() {
  //testUndo
  if (mouseX>50&&mouseX<1200&&mouseY>150 &&mouseY < height-30) {

    // Save each line we draw to our stack of UNDOs
    undo.takeSnapshot();
  }
}

//für SaveButton

void folderSelected (File selection) {
  if (selection == null) {
    return;
  } else {
    String dir2 = selection.getPath() ;
    partialSave.save(dir2 + "/screenshot-" + num + ".png");
    num ++;
  }
}


//Undo und redo
class Undo {
  int undoschritt=0;
  int redoschritt=0;
  ImagesC images;

  Undo(int levels) {
    images = new ImagesC(levels);
  }

  public void takeSnapshot() {
    undoschritt = min(undoschritt+1, images.anzahl-1);
    redoschritt = 0;
    images.vor();
    images.aufnahme();
  }
  public void undo() {
    if (undoschritt > 1) {
      undoschritt--;
      redoschritt++;
      images.zurueck();
      images.anzeigen();
    }
  }
  public void redo() {
    if (redoschritt > 0) {
      undoschritt++;
      redoschritt--;
      images.vor();
      images.anzeigen();
    }
  }
}

class ImagesC {
  int anzahl;
  int a;
  PImage[] img;
  ImagesC(int bildAnzahl) {
    anzahl = bildAnzahl;

    // Initialize all images as copies of the current display
    img = new PImage[anzahl];
    for (int i=0; i<anzahl; i++) {
      img[i] = createImage(width, height, RGB);
      img[i] = get();
    }
  }
  void vor() {
    a = (a + 1) % anzahl;
  }
  void zurueck() {
    a = (a - 1 + anzahl) % anzahl;
  }
  void aufnahme() {
    img[a] = get();
  }
  void anzeigen() {
    image(img[a], 0, 0);
  }
}
