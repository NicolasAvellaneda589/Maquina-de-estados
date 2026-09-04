class cuadrado {
  PVector pos;
  float w, h;
  float velocidadX = -4.0;

  cuadrado(float x, float y, float ancho, float alto) {
    pos = new PVector(x, y); w = ancho; h = alto;
  }
  void mover() { pos.x += velocidadX; }
  void mostrar() {
    stroke(255); strokeWeight(1.5); fill(30, 160, 90);
    rectMode(CORNER); rect(pos.x, pos.y, w, h, 4);
    stroke(255, 40); line(pos.x + 8, pos.y, pos.x + 8, pos.y + h);
  }
}
