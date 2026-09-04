class Paleta {
  PVector poss;
  float ancho = 16; float alto = 95; float vel = 8.5;

  Paleta(float x) { poss = new PVector(x, height / 2); }
  void mover(boolean arriba, boolean abajo) {
    if (arriba) poss.y -= vel;
    if (abajo) poss.y += vel;
    poss.y = constrain(poss.y, alto / 2, height - alto / 2);
  }
  boolean chocaCon(PVector posPelota, float radio) {
    float cercaX = max(poss.x - ancho / 2, min(posPelota.x, poss.x + ancho / 2));
    float cercaY = max(poss.y - alto / 2, min(posPelota.y, poss.y + alto / 2));
    float distX = posPelota.x - cercaX; float distY = posPelota.y - cercaY;
    return (distX * distX + distY * distY) < (radio * radio);
  }
  void mostrar(color colorNeon) {
    rectMode(CENTER); fill(colorNeon, 60); rect(poss.x, poss.y, ancho + 6, alto + 6, 6);
    fill(255); stroke(colorNeon); strokeWeight(2); rect(poss.x, poss.y, ancho, alto, 4);
  }
}
