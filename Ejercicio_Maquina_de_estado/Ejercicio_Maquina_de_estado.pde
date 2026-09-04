int estadoGeneral;
final int MENU_PRINCIPAL = -1;
final int FLAPPY_BIRD = 1;
final int PONG = 2;

int estadoJuegoActual = 0;
final int ST_INICIO = 0;
final int ST_JUGANDO = 1;
final int ST_GAMEOVER = 2;

// FLAPPY BIRD
ArrayList<DuplaDeTubos> tubos;
PelotaFlappy bird;
float ultimoPar = 0;
PVector g = new PVector(0, 0.28);
PImage imgPajaro;
int scoreFlappy = 0;

// PONG
PelotaPong pelotaPong;
Paleta j1, j2;
int sep = 40;
boolean is_w, is_s, is_up, is_down;
int scoreJ1 = 0, scoreJ2 = 0;


void setup() {
  size(800, 600);
  estadoGeneral = MENU_PRINCIPAL;
}

void draw() {
  switch(estadoGeneral) {
    case MENU_PRINCIPAL:
      dibujarMenuPrincipal();
      break;
    case FLAPPY_BIRD:
      ejecutarFlappyBird();
      break;
    case PONG:
      ejecutarPong();
      break;
  }
}

void dibujarMenuPrincipal() {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(10, 15, 30), color(25, 20, 50), inter);
    stroke(c);
    line(0, i, width, i);
  }
 
  stroke(255, 255, 255, 10);
  strokeWeight(1);
  for (int x = 0; x < width; x += 40) line(x, 0, x, height);
  for (int y = 0; y < height; y += 40) line(0, y, width, y);

  textAlign(CENTER, CENTER);
 
  fill(255, 0, 128, 150);
  textSize(52);
  text("GBUNKER DEL 70", width / 2 + 4, 120 + 4);
  fill(0, 240, 255);
  text("GBUNKER DEL 70", width / 2, 120);


  boolean hoverFlappy = mouseX > 140 && mouseX < 360 && mouseY > 250 && mouseY < 370;
  rectMode(CORNER);
  if (hoverFlappy) {
    fill(0, 255, 128, 40); stroke(0, 255, 128); strokeWeight(3); cursor(HAND);
  } else {
    fill(15, 25, 40); stroke(0, 180, 100); strokeWeight(1.5);
  }
  rect(140, 250, 220, 120, 12);
  fill(255); textSize(24); text("Flappy Bird", 250, 295);
  fill(0, 255, 128); textSize(14); text("[Presiona 1 para jugar]", 250, 330);


  boolean hoverPong = mouseX > 440 && mouseX < 660 && mouseY > 250 && mouseY < 370;
  if (hoverPong) {
    fill(255, 0, 128, 40); stroke(255, 0, 128); strokeWeight(3); cursor(HAND);
  } else {
    fill(15, 25, 40); stroke(200, 0, 100); strokeWeight(1.5);
  }
  rect(440, 250, 220, 120, 12);
  fill(255); textSize(24); text("Pong Retro", 550, 295);
  fill(255, 0, 128); textSize(14); text("[Presiona 2 para jugar]", 550, 330);
 
  if (!hoverFlappy && !hoverPong) cursor(ARROW);
 
  fill(180); textSize(15);
  text("clic en los paneles o usa el teclado para ingresar.", width / 2, 500);
}

void iniciarFlappy() {
  tubos = new ArrayList<DuplaDeTubos>();
  bird = new PelotaFlappy(150, height / 2);
  ultimoPar = millis();
  scoreFlappy = 0;
  estadoJuegoActual = ST_JUGANDO;
}

void ejecutarFlappyBird() {
  background(240, 110, 90);
  for (int i = 0; i < height / 2; i++) {
    stroke(135 - (i*0.2), 170 - (i*0.3), 235 - (i*0.2));
    line(0, i, width, i);
  }

  if (estadoJuegoActual == ST_INICIO) {
    fill(10, 20, 30, 200); rect(0, 0, width, height);
    textAlign(CENTER, CENTER); fill(0, 240, 255); textSize(50);
    text("FLAPPY BIRD", width / 2, 200);
    fill(255); textSize(20);
    text("Presiona ESPACIO para saltar y comenzar\n\n[M] Volver al Menu Principal", width / 2, 360);
  } else if (estadoJuegoActual == ST_JUGANDO) {
    AgregarTubos();
    bird.addFuerza(g);
    bird.mover();
    borrarTubos();

    for (DuplaDeTubos t : tubos) {
      t.mover();
      t.mostrar();
      if (!t.pasado && bird.pos.x > t.superior.pos.x + t.superior.w) {
        scoreFlappy++; t.pasado = true;
      }
      if (chequearColision(bird, t.superior) || chequearColision(bird, t.inferior)) {
        estadoJuegoActual = ST_GAMEOVER;
      }
    }
    bird.mostrar();
    if (bird.pos.y >= height - bird.r || bird.pos.y <= bird.r) estadoJuegoActual = ST_GAMEOVER;
   
    textAlign(LEFT, TOP); fill(255); textSize(32); text("SCORE: " + scoreFlappy, 30, 30);
  } else if (estadoJuegoActual == ST_GAMEOVER) {
    for (DuplaDeTubos t : tubos) t.mostrar();
    bird.mostrar();
    fill(20, 10, 25, 220); rect(0, 0, width, height);
    textAlign(CENTER, CENTER); fill(255, 50, 100); textSize(55);
    text("GAME OVER", width / 2, 180);
    fill(255); textSize(28); text("Puntaje Final: " + scoreFlappy, width / 2, 260);
    textSize(18); fill(200);
    text("Presiona [R] para volver a intentar\nPresiona [M] para salir al menu", width / 2, 380);
  }
}


void iniciarPong() {
  pelotaPong = new PelotaPong(width / 2, height / 2);
  j1 = new Paleta(sep);
  j2 = new Paleta(width - sep);
  scoreJ1 = 0; scoreJ2 = 0;
  estadoJuegoActual = ST_JUGANDO;
}

void ejecutarPong() {
  background(15, 15, 25);
  if (estadoJuegoActual == ST_INICIO) {
    textAlign(CENTER, CENTER); fill(255, 0, 128); textSize(50);
    text("PONG RETRO", width / 2, 180);
    fill(255); textSize(18);
    text("Jugador 1 (Azul): Teclas W / S\nJugador 2 (Rosa): Flechas ARRIBA / ABAJO\n\nPresiona ESPACIO para iniciar el saque\n[M] Volver al Menu", width / 2, 350);
  } else if (estadoJuegoActual == ST_JUGANDO) {
    stroke(255, 255, 255, 30); strokeWeight(3);
    for (int i = 0; i < height; i += 30) line(width / 2, i, width / 2, i + 15);

    pelotaPong.mover(); pelotaPong.contener();
    j1.mover(is_w, is_s); j2.mover(is_up, is_down);

    if (j1.chocaCon(pelotaPong.pos, pelotaPong.r)) {
      pelotaPong.rebotarEspecial(j1.poss.y, j1.alto);
      pelotaPong.separar(j1.poss.x + j1.ancho / 2 + pelotaPong.r);
    }
    if (j2.chocaCon(pelotaPong.pos, pelotaPong.r)) {
      pelotaPong.rebotarEspecial(j2.poss.y, j2.alto);
      pelotaPong.separar(j2.poss.x - j2.ancho / 2 - pelotaPong.r);
    }

    if (pelotaPong.pos.x < 0) { scoreJ2++; pelotaPong = new PelotaPong(width / 2, height / 2); }
    else if (pelotaPong.pos.x > width) { scoreJ1++; pelotaPong = new PelotaPong(width / 2, height / 2); }

    pelotaPong.mostrar();
    j1.mostrar(color(0, 200, 255));
    j2.mostrar(color(255, 0, 128));
   
    textAlign(CENTER, CENTER); textSize(48);
    fill(0, 200, 255, 150); text(scoreJ1, width / 2 - 100, 60);
    fill(255, 0, 128, 150); text(scoreJ2, width / 2 + 100, 60);
    fill(100); textSize(13); text("[M] Menu Principal", width / 2, height - 30);
  }
}


void mousePressed() {
  if (estadoGeneral == MENU_PRINCIPAL) {
    if (mouseX > 140 && mouseX < 360 && mouseY > 250 && mouseY < 370) {
      estadoGeneral = FLAPPY_BIRD; estadoJuegoActual = ST_INICIO;
    } else if (mouseX > 440 && mouseX < 660 && mouseY > 250 && mouseY < 370) {
      estadoGeneral = PONG; estadoJuegoActual = ST_INICIO;
    }
  }
}

void keyPressed() {
  if (key == 'm' || key == 'M') { estadoGeneral = MENU_PRINCIPAL; cursor(ARROW); return; }

  if (estadoGeneral == MENU_PRINCIPAL) {
    if (key == '1') { estadoGeneral = FLAPPY_BIRD; estadoJuegoActual = ST_INICIO; }
    else if (key == '2') { estadoGeneral = PONG; estadoJuegoActual = ST_INICIO; }
  } else if (estadoGeneral == FLAPPY_BIRD) {
    if (estadoJuegoActual == ST_INICIO && key == ' ') iniciarFlappy();
    else if (estadoJuegoActual == ST_JUGANDO && key == ' ') bird.saltar();
    else if (estadoJuegoActual == ST_GAMEOVER && (key == 'r' || key == 'R')) iniciarFlappy();
  } else if (estadoGeneral == PONG) {
    if (estadoJuegoActual == ST_INICIO && key == ' ') iniciarPong();
    if (key == 'w' || key == 'W') is_w = true;
    if (key == 's' || key == 'S') is_s = true;
    if (keyCode == UP) is_up = true;
    if (keyCode == DOWN) is_down = true;
  }
}

void keyReleased() {
  if (estadoGeneral == PONG) {
    if (key == 'w' || key == 'W') is_w = false;
    if (key == 's' || key == 'S') is_s = false;
    if (keyCode == UP) is_up = false;
    if (keyCode == DOWN) is_down = false;
  }
}

boolean chequearColision(PelotaFlappy p, cuadrado c) {
  float cercanoX = constrain(p.pos.x, c.pos.x, c.pos.x + c.w);
  float cercanoY = constrain(p.pos.y, c.pos.y, c.pos.y + c.h);
  float distanciaX = p.pos.x - cercanoX;
  float distanciaY = p.pos.y - cercanoY;
  return (distanciaX * distanciaX + distanciaY * distanciaY) < (p.r * p.r);
}

void borrarTubos() {
  for (int i = tubos.size() - 1; i >= 0; i--) {
    if (tubos.get(i).superior.pos.x < -70) tubos.remove(i);
  }
}

void AgregarTubos() {
  float tActual = millis();
  if (tActual - ultimoPar > 2000) {
    float espacio = 160;
    float altoSuperior = random(80, height - 80 - espacio);
    tubos.add(new DuplaDeTubos(width, altoSuperior, espacio));
    ultimoPar = tActual;
  }
}
