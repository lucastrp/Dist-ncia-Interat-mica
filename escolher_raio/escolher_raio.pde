String[] elementos = {"Fe", "C", "Si", "Ge", "P", "Al", "Ga", "Cu", "Au", "As"};

int n_elementos = elementos.length;


color branco = color(255, 255, 255);
color verde = color(0, 255, 0);
color azul = color(50, 0, 255);
color preto = color(0);

PVector [] posicao;
int tamanho_bola = 10;

int current_choice = 0;

void settings() {
  size(100, 275, P3D);
}

void setup() {

  posicao = new PVector[n_elementos];
  for (int i=0; i < n_elementos; i++) {
    posicao[i] = new PVector(50, 70 + (i * 20));
  }
}

void draw() {
  background(branco);
  display_the_menu();
}

void display_the_menu() {
  for (int i = 0; i < n_elementos; i++) {

    fill(preto);
    text(elementos[i], posicao[i].x + tamanho_bola, posicao[i].y + 5);

    noFill();
    stroke(preto);
    strokeWeight(2);
    ellipse(posicao[i].x, posicao[i].y, tamanho_bola, tamanho_bola);
    if (i == current_choice) {
      noStroke();
      fill(verde);
      ellipse(posicao[i].x, posicao[i].y, tamanho_bola - 1, tamanho_bola - 1);
    }
  }
}

void mousePressed() {
  for (int i = 0; i < n_elementos; i++) {
    if ((mouseX > posicao[i].x - (tamanho_bola / 2)) && (mouseX < posicao[i].x + (tamanho_bola / 2)) && (mouseY > posicao[i].y - (tamanho_bola / 2)) && (mouseY < posicao[i].y + (tamanho_bola / 2))) {
      current_choice = i;
    }
  }
}
