class Grafico{
  PVector o; // vetor posição da origem do gráfico
  float altura; // altura total do gráfico
  float largura; // largura total do gráfico
  float x_max, x_min; // abscissas ABSOLUTAS maxima e mínima
  float y_max, y_min; // ordenadas ABSOLUTAS máxima e mínima
  float escala_x, escala_y; // escalas para que a distâncias entre os dados ABSOLUTOS se encaixem na largura e na altura
  float rmin = 10; // distância de ligação entre os átomos (em ângstrons)
  
  //CONSTRUTORA
  Grafico(PVector origem, float _altura, float _largura, float _x_max, float _x_min, float _y_max, float _y_min){
    o = new PVector (origem.x, origem.y);
    altura = _altura;
    largura = _largura;
    x_max = _x_max;
    x_min = _x_min;
    y_max = _y_max;
    y_min = _y_min;   
    
    //definimos as escalas
    escala_x = largura/(x_max - x_min);
    escala_y = altura/(y_max - y_min);
  }  
  
  // função que desenha o gráfico
  void desenha_grafico(){
    strokeWeight(2); 
    stroke(200);// os eixos ordenados são claros, destacando a linha da função
     
     // desenhamos os eixos ordenados
     pushMatrix();
     translate(o.x, o.y);
     line((x_min)*(escala_x) - 5, 0, (x_max)*(escala_x), 0);
     line((x_max)*(escala_x), 0, (x_max)*(escala_x) - 5, 5);
     line((x_max)*(escala_x), 0, (x_max)*(escala_x) - 5, -5);    
     line(0, (y_min)*(escala_y), 0, (y_max)*(escala_y));
     line(0, (y_min)*(escala_y), 5, (y_min)*(escala_y) + 5);
     line(0, (y_min)*(escala_y), -5, (y_min)*(escala_y) + 5);
     // nomeamos os eixos
     textFont(f, 10);
     fill(150);
     pushMatrix();
     translate((x_max)*(escala_x) - 20, 20);
     text("SEPARAÇÃO INTERATÔMICA", 0, 0);
     popMatrix();
     pushMatrix();
     translate(-20, -20);
     rotate(3*PI/2);
     if(modo == true)
       text("ENERGIA POTENCIAL", 0, 0);
     if(modo == false)
       text("FORÇA", 0, 0);
     popMatrix();
     popMatrix(); 
     
     // para desenhar o gráfico da função, pegamos duas coordenadas (x, y) 
     // chamadas 'a' e 'b' e traçamos uma linha entre elas     
     strokeWeight(1);
     stroke(0);
     for(float t = x_min + 0.02; t < x_max - 1; t += 0.02){ // 't' é o parâmetro no qual calculamos a função
      float p = rmin/t;
      float ax = t*escala_x; // criamos 'a'
      float ay = funcao(p);
      float t1 = t + 0.02;
      p = rmin/t1;
      float bx = t1*escala_x; // criamos 'b'
      float by = funcao(p);
      if((ay < y_max*escala_y && ay > y_min*escala_y) && (by < y_max*escala_y && by > y_min*escala_y) ){
        pushMatrix();
        translate(o.x, o.y); // mudança de origem
        line(ax, ay, bx, by); // linha entre os pontos 'a' e 'b'
        popMatrix();
      }
     }
     noStroke();
  }
  
  /*void desenha_grafico(PGraphics pg){
     pg.stroke(255);
     
     pg.pushMatrix();
     pg.translate(o.x, o.y);
     pg.line((x_min)*(escala_x), 0, (x_max)*(escala_x), 0);
     pg.line(0, y_min*escala_y, 0, y_max*escala_y);     
     for(float t = x_min + 0.1; t < x_max - 0.1; t += 0.1){
      float rmin = 3.5;
      float p = rmin/t;
      float ax = t*escala_x;
      float ay = 100*(pow(p, 12) - pow(p, 6))*escala_y;
      float t1 = t + 0.1;
      p = rmin/t1;
      float bx = t1*escala_x;
      float by = 100*(pow(p, 12) - pow(p, 6))*escala_y;
      if((ay < y_max && ay > y_min) && (by < y_max && by > y_min) ){
        pg.strokeWeight(2);
        pg.line(ax, ay, bx, by);
      }
     pg.popMatrix();
     }
  }*/
  
  //calculamos as funções
  float funcao(float x){
    float y = 0;
    // dependendo do modo, a função devolve o valor (em escala) da energia ou da força
    if(modo)
      y = (- 100*(pow(x, 8) - 2*pow(x, 4))*escala_y); //função da energia (o sinal negativo refere-se à troca de sentido dos eixos no processing)
    if(!modo)
      y = (800*(pow(x, 7) - pow(x, 3))*escala_y); //função da força
    return y;
  }
} 
