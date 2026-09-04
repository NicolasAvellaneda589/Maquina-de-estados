class PelotaPong {
  PVector pos, vel;
  float r = 10;
  float velocidadBase = 5.5;

  PelotaPong(float x, float y) {
    pos = new PVector(x, y);
    float dirX = random(1) > 0.5 ? velocidadBase : -velocidadBase;
    vel = new PVector(dirX, random(-2, 2));
  }
  void mover() { pos.add(vel); }
  void contener() {
    if (pos.y - r < 0) { pos.y = r; vel.y *= -1; }
    else if (pos.y + r > height) { pos.y = height - r; vel.y *= -1; }
  }
  void rebotarEspecial(float paletaY, float paletaAlto) {
    vel.x *= -1;
    float influenciaY = (pos.y - paletaY) / (paletaAlto / 2);
    vel.y = influenciaY * 5.5;
    vel.mult(1.06);
  }
  void separar(float xFix) { pos.x = xFix; }
  void mostrar() {
    fill(255); noStroke(); ellipse(pos.x, pos.y, r * 2, r * 2);
    fill(255, 70); ellipse(pos.x - vel.x * 0.5, pos.y - vel.y * 0.5, r * 1.5, r * 1.5);
  }
}
