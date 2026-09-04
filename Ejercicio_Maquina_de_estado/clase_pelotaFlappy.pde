class PelotaFlappy {
  PVector pos, vel;
  float r = 18;

  PelotaFlappy(float x, float y) { 
    pos = new PVector(x, y); 
    vel = new PVector(0, 0); 
  }

  void addFuerza(PVector fuerza) { 
    vel.add(fuerza); 
  }

  void saltar() { 
    vel.y = -6.8; 
  }

  void mover() { 
    pos.add(vel); 
    vel.limit(10); 
  }

  void mostrar() {
    pushMatrix(); 
    translate(pos.x, pos.y);

    
    float angulo = map(vel.y, -7, 10, -PI/6, PI/3);
    rotate(constrain(angulo, -PI/6, PI/2));

 
    fill(255, 210, 0); 
    stroke(0); 
    strokeWeight(2); 
    ellipse(0, 0, r * 2, r * 2);

   
    fill(255); 
    ellipse(r/3, -r/3, 8, 8);

    
    fill(255, 100, 0); 
    triangle(r/2, 0, r, -r/4, r, r/4);

    popMatrix();
  }
}
