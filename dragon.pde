float P = 200; //the number of turns the line takes
float H = (float)Math.pow(2,(-P/2)); 
float step = 0;
float A = 90; //the angle at which the lines turn each time
float B = (PI-A); //this is used to scale the number we use to step through the cos or sin wave
float X = width/2;
float Y = height/2;
float pX = width/2;
float pY = height/2;
float D,F,M,N,scale;

void setup(){
  size(1000,1000);
  background(0);
  scale = 10;
  smooth();
  A = A*PI/90;
  fill(0,40);
  stroke(255);
  begin();
}

//the Turbo Basic line function seems to do some translating as it draws a line
//in the syntax they will sometimes omit the first point of the line
//which indicates that the next line should be drawn from last point of the previous line
//so this has been interesting to try to keep track of.

//this begins the process. 
void begin(){
      N++;
      M = N;
      checkAndTransform();
      transformLine();
      drawLine();
}

//if mod 2 is 0 then we change M and run the function again
//if M mod 2 is not 0 then we go on to check mod 4 to determine which direction to take
// above, we determined which angle we should turn with A
void checkAndTransform(){
    if(M%2==0){
      M = M/2;
      checkAndTransform();
    } else checkModFour();
}

//this decides which direction (which is why i assume they chose 'D' as variable name)
void checkModFour(){
    if(M%4==1){
      D = 1;
    } else {
      D = -1;
    }
}



//so, with cos() sin(), i think the numbers we provide create the size of the steps which
// which we walk thorugh the output of the sin and cos function.s
void transformLine(){
   step=(step+D);
   X=X+H+cos(step*B)*scale;
   Y=Y+H+sin(step*B)*scale;
}

//to keep track of where the line ended i save it ib pX and pY
void drawLine(){
  
  fill(0,10);
  //the turbo basic code drew lines, but in only one direction.
  //now, instead, i draw tiny dots at the corners and i can easily draw symmetical
  ellipse(X+width/2,Y+height/2,2,2);
  line(pX+width/2,pY+height/2,X+width/2,Y+height/2);
  ellipse(X+width/2,-Y+height/2,2,2);
  line(pX+width/2,-pY+height/2,X+width/2,-Y+height/2);
  ellipse(-X+width/2,Y+height/2,2,2);
  line(-pX+width/2,pY+height/2,-X+width/2,Y+height/2);
  ellipse(-X+width/2,-Y+height/2,2,2);
  line(-pX+width/2,-pY+height/2,-X+width/2,-Y+height/2);

  pX=X;
  pY=Y;
  
  if(pX+width/2 > width || pX+width/2 < 0 || pY+height/2 > height || pX+height/2 < 0){
    return;
  } else {
    begin();
  }
}

//we don't use draw for now. just looping through those functions above until the point leaves the window.
void draw(){
 
}
