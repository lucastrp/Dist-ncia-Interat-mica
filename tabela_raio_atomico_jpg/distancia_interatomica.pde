
/* 
 
 Nesta animação foi utilizada a biblioteca 'physics' desenvolvida na Universidade de Princeton, EUA, a
 biblioteca consiste na união de classes e métodos de simulação   de interações físicas, com a possibilidade
 de estabelecimento de forças de atração e repulsão, assim como forças gravitacionais em objetos de uma 
 classe de partículas.
 
 Mais informações a respeito da biblioteca em: http://www.cs.princeton.edu/~traer/physics/ 
 
 */
import traer.physics.*;

ParticleSystem physics; // sistema de partículas
Particle a, b; // átomos
Spring s; // força entre os átomos
//Attraction at;

Grafico g; // gráfico
PVector origem; // auxiliar de posicionamento
Botao[] grafico; //botões de escolha do gráfico apresentado
Credito credito;

PFont f; //fonte

//CONSTANTES
float raioA = 20; // raio do átomo que se move
float raioB = 40; // raio do átomo fixo

boolean modo = true; //quando modo = TRUE, mostramos o gráfico da energia
//quando modo = FALSE, mostramos o gráfico da força

String[] elementos = {"Fe", "C", "Si", "Ge", "P", "Al", "Ga", "Cu", "Au", "As"};
String[] elementos1 = {"Fe", "C", "Si", "Ge", "P", "Al", "Ga", "Cu", "Au", "As"};
float[] tamanhos = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int n_elementos = elementos.length;
int n_elementos1 = elementos1.length;

color branco = color(255, 255, 255);
color verde = color(0, 255, 0);
color azul = color(50, 0, 255);
color preto = color(0);
color rosa = color(234, 173, 234);
color ciano = color(162,205,255);
PVector [] posicao;
PVector [] posicao1;
int tamanho_bola = 10;

int current_choice = 0;
int current_choice1 = 0;
//variáveis globais
int w_width;
int w_height;


void setup() {
  size(500, 600/*, P3D*/);
  w_width = 500;
  w_height = 600;
  smooth();
  noStroke();
  rectMode(CORNERS);
  textAlign(CENTER);

  posicao = new PVector[n_elementos];
  for (int i=0; i < n_elementos; i++) {
    posicao[i] = new PVector(429, 150 + (i * 20));
  }  
  posicao1 = new PVector[n_elementos1];
  for (int i=0; i < n_elementos1; i++) {
    posicao1[i] = new PVector(469, 150 + (i * 20));
  }
  //inicialização
  physics = new ParticleSystem(0, .1);
  a = physics.makeParticle(1, 3*w_width/4, 5*w_height/16, 0);
  b = physics.makeParticle(5, w_width/4, a.position().y(), 0);
  b.makeFixed();

  // inicialização do gráfico 
  origem = new PVector(b.position().x(), b.position().y() + 3*raioB );
  g = new Grafico(origem, 100, 250, 30, 0, 100, -250);  

  g.rmin = (raioA + raioB)/g.escala_x; // colocamos o ponto mais baixo do grafico de energia na posição certa (soma dos raios)

  // inicialização das forças
  s = physics.makeSpring(a, b, .2, .3, /*115*/g.rmin*g.escala_x);
  //at = physics.makeAttraction(a, b, -10000, 500);

  //inicialização dos botões
  grafico = new Botao[2];
  grafico[0] = new Botao(8*w_width/11, origem.y + w_height/8, w_width/10, 12, "Energia");
  grafico[0].situacao = "SELECIONADO";
  grafico[0].psituacao = "LIBERADO";
  grafico[1] = new Botao(grafico[0].xpos + 1.4*grafico[0].comprimento, origem.y + w_height/8, 3*w_width/40, 12, "Força");

  //inicialização do botão de créditos
  credito = new Credito();

  // inicialização da fonte
  f = loadFont("CourierNewPS-BoldMT-38.vlw");
  textFont(f, 38);


  background(255);  
  // texto
  fill(0);
  text("Distância de Ligação", w_width/2, w_height/8);
  textFont(f, 12);
  text("Gráfico:", 6*w_width/11, origem.y + w_height/8);
  textFont(f, 14);
  text("A distância de ligação de dois átomos é a distância\n" +
    "correspondente ao ponto de mínima energia potencial,\n" +
    "no qual a força resultante entre os átomos assume\n" +
    "valor nulo devido à igualdade dos módulos e oposição\n" +
    "dos sentidos das forças atrativas e repulsivas.\n\n" +
    "Arraste o átomo para outra posição e observe como\n" + 
    "o mesmo assume naturalmente a distância de ligação,\n" +
    "procurando a situação de maior estabilidade.\n", w_width/2, 3*w_height/4);
}

void draw() {

  if (credito.botao.situacao != "LIBERADO") {
    textFont(f, 38);
    background(255);
    fill(0);
    text("Distância de Ligação", w_width/2, w_height/8);
    textFont(f, 12);
    text("Gráfico:", 6*w_width/11, origem.y + w_height/8);
    textFont(f, 14);
    text("A distância de ligação de dois átomos é a distância\n" +
      "correspondente ao ponto de mínima energia potencial,\n" +
      "no qual a força resultante entre os átomos assume\n" +
      "valor nulo devido à igualdade dos módulos e oposição\n" +
      "dos sentidos das forças atrativas e repulsivas.\n\n" +
      "Arraste o átomo para outra posição e observe como\n" + 
      "o mesmo assume naturalmente a distância de ligação,\n" +
      "procurando a situação de maior estabilidade.\n", w_width/2, 3*w_height/4);
  }

  fill(255);
  rectMode(CORNERS);
  rect(0, b.position().y() - raioB, w_width, b.position().y() + 3*raioB + g.y_max*g.escala_y + 5); //ao invés de atualizarmos a tela inteira
  physics.tick(.2);                                                                              //o fazemos apenas com o retângulo em que
  display();                                                                                     //a animação ocorre
  g.desenha_grafico();
  segue();
  botaoDisplay();
  credito.display();
}

// função que desenha os átomos 
void display() {
  pushMatrix();
  translate(b.position().x(), b.position().y()/*, b.position().z()*/);
  fill(162, 205, 255);
  //sphere(40);
  ellipse(0, 0, 2*raioB, 2*raioB);
  fill(100);
  ellipse(0, 0, 10, 10);
  popMatrix();
  pushMatrix();
  translate(a.position().x(), a.position().y()/*, a.position().z()*/);
  fill(247, 175, 255);
  //sphere(20);
  ellipse(0, 0, 2*raioA, 2*raioA);
  fill(100);
  ellipse(0, 0, 10, 10);
  popMatrix();
  for (int i = 0; i < n_elementos; i++) {

    fill(preto);
    text(elementos[i], posicao[i].x + tamanho_bola + 10, posicao[i].y + 5);

    noFill();
    stroke(preto);
    strokeWeight(2);
    ellipse(posicao[i].x, posicao[i].y, tamanho_bola, tamanho_bola);
    if (i == current_choice) {
      noStroke();
      fill(rosa);
      ellipse(posicao[i].x, posicao[i].y, tamanho_bola - 1, tamanho_bola - 1);
    }
  }
  for (int i = 0; i < n_elementos1; i++) {

    fill(preto);
    text(elementos1[i], posicao1[i].x + tamanho_bola + 10, posicao[i].y + 5);

    noFill();
    stroke(preto);
    strokeWeight(2);
    ellipse(posicao1[i].x, posicao1[i].y, tamanho_bola, tamanho_bola);
    if (i == current_choice1) {
      noStroke();
      fill(ciano);
      ellipse(posicao1[i].x, posicao1[i].y, tamanho_bola - 1, tamanho_bola - 1);
    }
  }
}

// função que desenha os botões
void botaoDisplay() {
  rectMode(CENTER);
  textFont(f, 11);
  grafico[0].display();
  grafico[1].display();
  rectMode(CORNERS);
  textFont(f, 12);
}
// função que desenha a bolinha que acompanha o gráfico
void segue() {
  float dx = a.position().x() - g.o.x;
  float t = dx/(g.escala_x);
  float p = (g.rmin)/t;
  float yt = g.funcao(p)/(g.escala_y);
  if ((t < g.x_max - 1 && t > g.x_min) && (yt <= g.y_max && yt > g.y_min)) {
    noStroke();
    fill(255, 0, 0);
    ellipse(g.o.x + t*(g.escala_x), g.o.y + yt*(g.escala_y), 10, 10);
  }
}

void mousePressed() {

  /*  
   //o botão direito do mouse determina qual o gráfico apresentado
   if(mouseButton == RIGHT)
   modo = !modo;
   */

  // com o botão esquerdo do mouse, deslocamos o átomo livre por seu eixo x  
  if (mouseButton == LEFT) {
    grafico[0].mousePressed();
    grafico[1].mousePressed();

    float dx = mouseX - a.position().x();
    float dy = mouseY - a.position().y();
    float d = sqrt(dx*dx + dy*dy);

    if ( d <= 20 && mouseX - b.position().x() > raioA + raioB && mouseX < width - raioA ) {
      a.makeFixed(); // para que o átomo não se mova quando paramos o mouse, fixamos-lo
      a.position().set(mouseX, a.position().y(), 0); // o átomo livre desloca-se para a posição do mouse
    }
  }
  credito.botao.mousePressed();
  for (int i = 0; i < n_elementos; i++) {
    if ((mouseX > posicao[i].x - (tamanho_bola / 2)) && (mouseX < posicao[i].x + (tamanho_bola / 2)) && (mouseY > posicao[i].y - (tamanho_bola / 2)) && (mouseY < posicao[i].y + (tamanho_bola / 2))) {
      current_choice = i;
    }
  }
  for (int i = 0; i < n_elementos1; i++) {
    if ((mouseX > posicao1[i].x - (tamanho_bola / 2)) && (mouseX < posicao1[i].x + (tamanho_bola / 2)) && (mouseY > posicao1[i].y - (tamanho_bola / 2)) && (mouseY < posicao1[i].y + (tamanho_bola / 2))) {
      current_choice1 = i;
    }
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    float dx = mouseX - a.position().x();
    float dy = mouseY - a.position().y();
    float d = sqrt(dx*dx + dy*dy);

    if ( d <= 20 && mouseX - b.position().x() > raioA /*+ raioB*/ && mouseX < width - raioB ) {
      a.makeFixed(); // para que o átomo não se mova quando paramos o mouse, fixamos-lo
      a.position().set(mouseX, a.position().y(), 0); // o átomo livre desloca-se para a posição do mouse
    } else
      a.makeFree(); // se o átomo não é selecionado, ele está livre
  }
}

void mouseReleased() {
  /*
  for(int i = 0; i < grafico.length; i++)
   if(grafico[i].situacao == "PRESSIONADO"){
   for(int j = 0; j < grafico.length; j++)
   if(j != i)
   grafico[j].libera();
   grafico[i].mouseReleased();
   modo = !modo;
   }
   */

  if (grafico[0].situacao == "PRESSIONADO") {
    modo = true;
    grafico[1].libera();
    grafico[0].mouseReleased();
  }

  if (grafico[1].situacao == "PRESSIONADO") {
    modo = false;
    grafico[0].libera();
    grafico[1].mouseReleased();
  }

  a.makeFree(); // quando liberamos o botão, o átomo passa a sofrer as forças interatômicas

  credito.botao.mouseReleased();
}
