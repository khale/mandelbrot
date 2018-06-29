/* 
 * Mandelbrot Set
 * z = z^2 + c
 *
 */
int GRID_SIZE = 600;
float STEP_SIZE = 0.2;
float STEP_MULT_THRESH = 16.0;
int ITER = 100;

void setup()
{
  size(GRID_SIZE, GRID_SIZE);
  background(255);
  do_draw();
}


float xorigin = 0;
float yorigin = 0;

float dx = 0.01;
float dy = 0.01;
float k = (9.0/10.0);
float kclick = 0.7;
  
void mouseClicked() {
 
   // first translate
  xorigin = xorigin + dx*(mouseX - GRID_SIZE/2);
  yorigin = yorigin + dy*(mouseY - GRID_SIZE/2);
  // then scale
  dx *= kclick;
  dy *= kclick;
  do_draw();
  
}

void mouseWheel(MouseEvent e)
{
  float s = e.getCount();
  float zoom = abs(s);
  float scale;
  
  if (s > 0) {
    scale = 1.0/(k*zoom);
  } else {
    scale = k*zoom;
  }
  xorigin = xorigin + dx*(mouseX - GRID_SIZE/2);
  yorigin = yorigin + dy*(mouseY - GRID_SIZE/2);
  dx *= scale;
  dy *= scale;
  do_draw();
}

boolean pressed = false;
boolean released = false;
int keyc = 0;
void keyPressed() {
  pressed = true;
  released = false;
  float shift = 20;
  float scale;
  keyc = keyCode;
  
  switch (keyCode) {
    case 67: /* c */
      xorigin = 0;
      yorigin = 0;
      break;
    case 73: /* zoom in: i */
      scale = k;
      dx *= scale;
      dy *= scale;
  
      break;
    case 79: /* zoom out: o */
      scale = 1.0/k;
      dx *= scale;
      dy *= scale;
      break;
    case 72: /* left: h */
    case 37:
      xorigin -= dx*shift;
      break;
    case 75: /* up: k */
    case 38:
      yorigin -= dy*shift;
      break;
    case 76: /* right: l */
    case 39:
      xorigin += dx*shift;
      break;
    case 74: /* down: j */
    case 40:
      yorigin += dy*shift;
      break;
  default:
    break;
  }
  
  
  do_draw();

  
}

void keyReleased ()
{
  released = true;
  pressed = false;
}

void draw() {
  //do nothing
  float scale;
  float shift = 20;
  
  if (released == false && pressed == true) {
    switch (keyc) {
    case 73: /* zoom in: i */
      scale = k;
      dx *= scale;
      dy *= scale;
      break;
    case 79: /* zoom out: o */
      scale = 1.0/k;
      dx *= scale;
      dy *= scale;
      break;
    case 72: /* left: h */
    case 37:
      xorigin -= dx*shift;
      break;
    case 75: /* up: k */
    case 38:
      yorigin -= dy*shift;
      break;
    case 76: /* right: l */
    case 39:
      xorigin += dx*shift;
      break;
    case 74: /* down: j */
    case 40:
      yorigin += dy*shift;
      break;
  default:
    break;
  }
  }
  do_draw();
    
}

void do_draw()
{
  loadPixels();

  float y = yorigin - GRID_SIZE*dy/2;
  for (int i = 0; i < GRID_SIZE; i++) {
    float x = xorigin - GRID_SIZE*dx/2;
    for (int j = 0; j < GRID_SIZE; j++) {
      int k = 0;
      float a = x;
      float b = y;
      while (k < ITER) {
        float aa    = a*a;
        float bb    = b*b;
        float twoab = 2.0*a*b;
        a = aa - bb + x;
        b = twoab + y;
        if (aa + bb > 200) {
          break;
        }
        k++;
      }

      if (k == ITER) {
        pixels[j+i*GRID_SIZE] = color(0);
      } else {
        pixels[j+i*GRID_SIZE] = color(k*2%255, k*4%255, k*8%255);
      }
      x += dx;
    }
    y += dy;
  }

  updatePixels();
  String s = "c: center\narrow keys: move around\no: zoom out\ni: zoom in\nMouse click to zoom in on point";
  fill(255);
  text(s, 10, 10, 200, 100);
}

