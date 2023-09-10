// Este código establece el funcionamiento de una máquina de dibujo sencilla
// Incluye una interfaz gráfica que se actualiza de acuerdo a la interacción con el usuario
// Con tal evitar complejizar la operación de la máquina, se evitó el uso de librerías externas
// A diferencia del ejemplo provisto, esta máquina dibuja al hacer click izquierdo con el mouse
// El borrador se activa y desactiva cliqueando en él y el pincel se puede aumentar de tamaño

// Declaración de variables globales
// Límites de donde el mouse capta el color, se limita al area de fotografia
float posx1 = 59;
float posx2 = 636.3133;
float posy1 = 251.7569;
float posy2 = 829.0702;
// Límites de donde el mouse dibuja, se limita al canvas
float px1 = 716.8504;
float px2 = 1644.6753;
float py1 = 251.7569;
float py2 = 829.0702;
// Límites botón cambio de fotografía
float foto_x1 = 80.6581;
float foto_x2 = 312.2066 ;
float foto_y1 = 80.6581;
float foto_y2 = 242.6626;
// Límites botón reinicio dibujo
float dib_x1 = 739.5403;
float dib_x2 = 1053.2763;
float dib_y1 = 211.0022;
float dib_y2 = 242.6626;
// Límites botón borrador
float bor_x1 = 739.4799;
float bor_x2 = 836;
float bor_y1 = 838.3744;
float bor_y2 = 870.0348;
// Límites botón color fondo
float cf_x1 = 926.1968;
float cf_x2 = 1348;
float cf_y1 = 838.3744;
float cf_y2 = 870.0348;
// Límites botón g
float sv_x1 = 1308.6775 ;
float sv_x2 = 1622.4135;
float sv_y1 = 211.0022;
float sv_y2 = 242.6626;
// Límites lienzo para guardar en jpg
float lz_x = 716.8504;
float lz_y = 251.7569;
float lz_w = 927.8249;
float lz_h = 577.3133;
// Colores UI
color gris_1 =  color(99, 101, 112);
color gris_2 =  color(80, 82, 91);
color cyan_1 =  color(189, 238, 255);
color yellow =  color(246, 255, 192);
// Iconos UI
PShape download;
PShape eraser;
PShape restart;
PShape shuffle;
//
PImage[] imagenes = new PImage [5]; //Array de imagenes
// Colores a elegir
color col_1 = color(255, 255, 255);
color col_2 = color(255, 255, 255);
color col_3 = color(255, 255, 255);
color col_4 = color(255, 255, 255);
color col_5 = color(255, 255, 255);
color col_mouse = color(255, 255, 255); // color inicial mouse
// Circulos de colores guardados y otras formas
PShape cir_1;
PShape cir_2;
PShape cir_3;
PShape cir_4;
PShape cir_5;
PShape lienzo;
// Fuente
PFont my_font;
// Variables de "cambio de estado"
int imagen_actual = 0;
color bg_color = color(255, 255, 255);
int usar_borrador = 0;
boolean save = false;
int save_index = 0;
boolean c1_save = false;
boolean c2_save = false;
boolean c3_save = false;
boolean c4_save = false;
boolean c5_save = false;
float ellipseSize = 10;


// Ciclo de ejecución
void setup() {
 size(1920, 1080); // relacion de aspecto 16:9 Full HD 
  // Carga los svg - iconos utilizados, tomados de nounproject
  download = loadShape("download.svg");
  eraser = loadShape("eraser.svg");
  restart = loadShape("restart.svg");
  shuffle = loadShape("shuffle.svg");
  // Escala los svg a tamaño adecuado y los colorea
  download.scale(0.035, 0.035);
  eraser.scale(0.035, 0.035);
  restart.scale(0.035, 0.035);
  shuffle.scale(0.035, 0.035);  
  // Carga la fuente
  my_font = loadFont("SegoeUI-Bold-34.vlw");
  textFont(my_font);
  textAlign(CENTER, CENTER);
  textSize(33.39);
  // Carga las imágenes en el array, estas fueron tomadas del sitio pexels
  imagenes[0] = loadImage("img_1.jpg");
  imagenes[1] = loadImage("img_2.jpg");
  imagenes[2] = loadImage("img_3.jpg");
  imagenes[3] = loadImage("img_4.jpg");
  imagenes[4] = loadImage("img_5.jpg");
  // Dibuja elementos estáticos de la UI
  background(gris_1);
  noStroke();
  fill(gris_2); 
  rect(716.59511, 201, 928.4241, 51.0123); //barra superior derecha
  rect(59, 201, 577.8304 , 51.0123); // barra superior izquierda
  rect(58.9827, 828.1999, 577.8304 , 50.8001 ); // barra inferior derecha
  rect(716.5951, 828.9152, 928.4241 , 50.0848 ); // barra inferior izquierda
  rect(1706, 0, 214, 1080); // barra lateral derecha
  //rect(x, y, width, height);
  fill(255, 255, 255);
  stroke(50);
  strokeWeight(5);
  // Crea los circulos que guardan color, estos son mutables y se trabajan en draw()
  cir_1 = createShape(ELLIPSE, 1814, 357, 105.5, 105.5);
  cir_2 = createShape(ELLIPSE, 1814, 357 + 120, 105.5, 105.5);
  cir_3 = createShape(ELLIPSE, 1814, 357 + 240, 105.5, 105.5);
  cir_4 = createShape(ELLIPSE, 1814, 357 + 360, 105.5, 105.5);
  cir_5 = createShape(ELLIPSE, 1814, 357 + 480, 105.5, 105.5);
  noStroke();
  //textos
  fill(cyan_1);
  text("Colores\nGuardados", 1814, 357 -120);
  textAlign(LEFT, CENTER);
  text("Guardar dibujo", 1308.6775 , 226.8324 );
  text("Reiniciar dibujo", 739.5403, 226.8324 );
  text("Foto aleatoria", 80.6581, 226.8324);
  textSize(22.26);
  text("Borrador", 739.4799, 854.2046);
  text("Color de fondo aleatorio", 926.1968, 854.2046);
  text("Guarda un color para dibujar,", 80.9799  , 854.2046 );
  fill(yellow);
  text("presiona 1, 2, 3, 4 o 5", 404.5967  , 854.2046 );
  // Canvas de dibujo
  fill(bg_color);
  lienzo = createShape(RECT, 716.8504, 251.7569, 927.8249 , 577.3133);
  shape(lienzo);
  // Dibuja una imagen inicial  
  int randomIndex = int(random(imagenes.length));
  image(imagenes[randomIndex], 59, 251.7569, 577.3133, 577.3133);
}

void draw() {
  shape(download, 1561.5144, 209.3475);
  shape(eraser, 851.8495, 839.1176);
  shape(restart, 1002.814, 209.3475);
  shape(shuffle, 315.9781, 209.3475);
  // Dibuja los circulos que guardan color
  shape(cir_1);
  shape(cir_2);
  shape(cir_3);
  shape(cir_4);
  shape(cir_5);
  // Dibuja los Números encima de los círculos que guardan colores
  fill(50);
  textAlign(CENTER, CENTER);
  textSize(33.39);
  text("1",1814, 357);
  text("2",1814, 357+120);
  text("3",1814, 357+240);
  text("4",1814, 357+360);
  text("5", 1814, 357+480);
  //Dibuja con el "pincel" en el área de dibujo
  if (usar_borrador == 0) {
    if (mouseX >= (px1 + (ellipseSize*0.485)) && mouseX <= (px2 - (ellipseSize*0.485)) && mouseY >= (py1 + (ellipseSize*0.485)) && mouseY <= (py2 - (ellipseSize*0.485))) {
     if (mousePressed && mouseButton == LEFT){
       noStroke();
       fill(col_mouse);
       ellipse(mouseX, mouseY, ellipseSize, ellipseSize);
     }
    }
  }
  if (usar_borrador == 1) {
    if (mouseX >= (px1 + (ellipseSize*0.485)) && mouseX <= (px2 - (ellipseSize*0.485)) && mouseY >= (py1 + (ellipseSize*0.485)) && mouseY <= (py2 - (ellipseSize*0.485))) {
      if (mousePressed && mouseButton == LEFT){
        noStroke();
        fill(bg_color);
        ellipse(mouseX, mouseY, ellipseSize, ellipseSize);
      }
    }
  }
  if (save == true) {
    save_index++;
    PImage to_save = get(int(lz_x),int(lz_y),int(lz_w),int(lz_h));
    to_save.save("/save/"+"imagen"+str(save_index)+".jpg");
    save = false;
  }
}

void mousePressed() {
  // Registro color mouse
  if (mouseX >= (posx1 + (10)) && mouseX <= (posx2 - (10)) && mouseY >= (posy1 + (10)) && mouseY <= (posy2 - (10))) {
    col_mouse = get(mouseX, mouseY);
  }  
  
  // Cambio de imagen al presionar el botón "Shuffle"
  if (mouseX >= (foto_x1) && mouseX <= (foto_x2) && mouseY >= (foto_y1) && mouseY <= (foto_y2)) {
    int randomIndex = int(random(imagenes.length));
    image(imagenes[randomIndex], 59, 251.7569, 577.3133, 577.3133);
  } 
  
  // Reincio de Sketch
  if (mouseX >= (dib_x1) && mouseX <= (dib_x2) && mouseY >= (dib_y1) && mouseY <= (dib_y2)) {
    fill(bg_color);
    rect(716.8504, 251.7569, 927.8249, 577.3133);
  } 
  
  // Uso del borrador
  if (mouseX >= (bor_x1) && mouseX <= (bor_x2) && mouseY >= (bor_y1) && mouseY <= (bor_y2)) {
    if (usar_borrador == 0) {
      fill(yellow);
      textAlign(LEFT, CENTER);
      textSize(22.26);
      text("Borrador", 739.4799, 854.2046);
      fill(col_mouse);
      usar_borrador = 1;
    } else {
      fill(cyan_1);
      textAlign(LEFT, CENTER);
      textSize(22.26);
      text("Borrador", 739.4799, 854.2046);
      fill(col_mouse);
      usar_borrador = 0;
    }
  }
  
  // Cambio de color de fondo aleatorio
  if (mouseX >= (cf_x1) && mouseX <= (cf_x2) && mouseY >= (cf_y1) && mouseY <= (cf_y2)) {
    bg_color = color(int(random(256)), int(random(256)), int(random(256))); //randomizador de colores
    fill(bg_color);
    rect(716.8504, 251.7569, 927.8249 , 577.3133); // Dibuja el nuevo color
  }
  
  // Botón de guardado
  if (mouseX >= (sv_x1) && mouseX <= (sv_x2) && mouseY >= (sv_y1) && mouseY <= (sv_y2)) {
    save = true;
    println("Imagen guardada!");
  }
}

void keyPressed() {
  if (key == TAB) {
    // Reinicia dibujo al presionar TAB
    fill(bg_color);
    rect(716.8504, 251.7569, 927.8249, 577.3133);
  }
  if (key == 's' || key == 'S') {
  save = true;
  println("Imagen guardada!");
  }
  // Condicionales que guardan el estado del color de teclas numéricas
  if (key == '1') {
    if (mouseX >= (posx1) && mouseX <= (posx2) && mouseY >= (posy1) && mouseY <= (posy2)) {
      col_mouse = get(mouseX, mouseY);
      col_1 = col_mouse;
      cir_1.setFill(col_1);
      println("Color 1 guardado!");
    }
    else {
      col_mouse = col_1;
    }
  }
    if (key == '2') {
    if (mouseX >= (posx1) && mouseX <= (posx2) && mouseY >= (posy1) && mouseY <= (posy2)) {
      col_mouse = get(mouseX, mouseY);
      col_2 = col_mouse;
      cir_2.setFill(col_2);
      println("Color 2 guardado!");
    }
    else {
      col_mouse = col_2;
    }
  }
    if (key == '3') {
    if (mouseX >= (posx1) && mouseX <= (posx2) && mouseY >= (posy1) && mouseY <= (posy2)) {
      col_mouse = get(mouseX, mouseY);
      col_3 = col_mouse;
      cir_3.setFill(col_3);
      println("Color 3 guardado!");
    }
    else {
      col_mouse = col_3;
    }
  }
    if (key == '4') {
    if (mouseX >= (posx1) && mouseX <= (posx2) && mouseY >= (posy1) && mouseY <= (posy2)) {
      col_mouse = get(mouseX, mouseY);
      col_4 = col_mouse;
      cir_4.setFill(col_4);
      println("Color 4 guardado!");
    }
    else {
      col_mouse = col_4;
    }
  }
    if (key == '5') {
    if (mouseX >= (posx1) && mouseX <= (posx2) && mouseY >= (posy1) && mouseY <= (posy2)) {
      col_mouse = get(mouseX, mouseY);
      col_5 = col_mouse;
      cir_5.setFill(col_5);
      println("Color 5 guardado!");
    }
    else {
      col_mouse = col_5;
    }
  }
  // Ajusta el tamaño del pincel (elipse) en funcion de apretar la tecla + o -, dentro de un rango
  if (key == '+' || key == '=') { // se usa el signo + e = porque estan en la misma tecla en el teclado gringo, y mi teclado es gringo :)
    //aumenta tamaño
    ellipseSize = min(50, ellipseSize + 10);
   }
  else if (key == '-') {
    // Disminuye tamaño, cuidando que no baje del mínimo
    ellipseSize = max(10, ellipseSize - 10);
  }
}
