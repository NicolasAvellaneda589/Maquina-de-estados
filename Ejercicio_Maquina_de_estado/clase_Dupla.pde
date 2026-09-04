class DuplaDeTubos {
  cuadrado superior;
  cuadrado inferior;
  boolean pasado = false;

  DuplaDeTubos(float x, float altoSuperior, float espacio) {
    superior = new cuadrado(x, 0, 65, altoSuperior);
    inferior = new cuadrado(x, altoSuperior + espacio, 65, height - (altoSuperior + espacio));
  }
  void mover() { superior.mover(); inferior.mover(); }
  void mostrar() { superior.mostrar(); inferior.mostrar(); }
}
