class Credito{
  
  Botao botao;
  
  PFont f;
  
  boolean mais;
  
  Credito(){
    botao = new Botao(width - 40, 20, 45, 20, "Créditos");
    f = loadFont("ArialUnicodeMS-11.vlw");
    mais = false;
  }

 void display(){     
   textFont(f, 11);
   botao.display();
   rectMode(CORNERS);
   if( botao.situacao == "SELECIONADO" ){
     fill(240, 200);
     textAlign(LEFT);     
     if(mais){
       //rect(width/2, height/2, 400, 400);
       rect(width/2 - 200, height/2 - 200, width/2 + 200, height/2 + 200);
       fill(0);
       text( "\t\t                                                                            CRÉDITOS" +
           "\n\nDesenvolvimento: Gustavo S. Jacomini (2ºano, Engenharia Civil-Escola Politécnica)" +
           "\n" + 
           "\n\nOrientação: Ivette Frida Cymbaum Oppenheim (Departamento de Engenharia " + 
           "\n                                                                        Metalúrgica e de Materiais - Escola Politécnica)" +
           "\n\ncriado em:" + 
//           " Processing" + 
           "\n\n\nO meio:    'Processing' é uma linguagem de programação e ambiente de" +  
           "\n                      desenvolvimento com foco principal nas artes visuais, apro-" +
           "\n                      veitando-se da plataforma Java e de uma comunidade virtual" + 
           "\n                      intensamente atuante através do compartilhamento de códi-" + 
           "\n                      gos e bibliotecas através da internet." + 
           "\n\n                      Surgiu como iniciativa de Casey Reas e Ben Fry, pesquisa-" +
           "\n                      dores do Instituto de Tecnologia de Massachussets (MIT)," +
           "\n                      sendo, desde sua criação,disponibilizado gratuitamente co-" +
           "\n                      mo software livre,acessível a qualquer interessado a partir" + 
           "\n                      do download no site 'processing.org',onde podem ser en-" +
           "\n                      contradas informações adicionais sobre 'Processing'." +    
           "\n\n\nApoio:     'Animações para Disciplinas Introdutórias de Ciência e Engenharia dos"  + 
           "\n                      Materiais' é integrante do 'Programa Ensinar com Pesquisa', inciativa da"  +
           "\n                     Pró-Reitoria de Graduação da Universidade de São Paulo, à qual expres-"  +
           "\n                     samos nossos agradecimentos (Projeto 598 -  Ano 2009).",width/2 - 190, height/2 - 170);
     }
     
     else if(mais == false){
       rect(width/2 - 200, height/2 - 200, width/2 + 200, height/2 + 30);
       fill(0);
       text( "\t\t                                                                            CRÉDITOS" +
           "\n\nDesenvolvimento: Gustavo S. Jacomini (2ºano, Engenharia Civil-Escola Politécnica)" +
           "\n" + 
           "\n\nOrientação: Ivette Frida Cymbaum Oppenheim (Departamento de Engenharia " + 
           "\n                                                                        Metalúrgica e de Materiais - Escola Politécnica)" +
           "\n\ncriado em:" +    
           "\n\n\nApoio:     'Animações para Disciplinas Introdutórias de Ciência e Engenharia dos"  + 
           "\n                      Materiais' é integrante do 'Programa Ensinar com Pesquisa', inciativa da"  +
           "\n                     Pró-Reitoria de Graduação da Universidade de São Paulo, à qual expres-"  +
           "\n                     samos nossos agradecimentos (Projeto 598 -  Ano 2009).",width/2 - 190, height/2 - 170);
       
     }
     textAlign(CENTER);
     
     if(!mais)
       fill(0, 0, 150);
     else if(mais)
       fill(150);
     
     if(abs(mouseX - (width/2 - 86)) < 30 && abs(mouseY - (height/2 - 68)) < 10){
       if(mousePressed)
         fill(255);
       else{
         if(!mais)
           fill(100, 100, 255);
         else if(mais)
           fill(200);
       }
     }
     
     text("Processing", width/2 - 86, height/2 - 68);
    
          
   }
   rectMode(CENTER);
 }
 
 class Botao{
  float xpos, ypos; // coordenadas do centro do botão
  
  String texto, // guarda o texto a ser impresso no botão
  
         situacao, // guarda a situação em que se encontra o botão, podendo estar "LIBERADO", "PRESSIONADO" ou "SELECIONADO"
  
         psituacao;  // guarda a situação 'estável' que o botão assumira antes de ser pressionado pela última vez
                     // (pode guardar "LIBERADO" ou "SELECIONADO") 
  
  float comprimento; // comprimento de referência do botão (retângulo interno)
  
  float altura; // altura de referência do botão (retângulo interno)
  
  
  //CONSTRUTORA SIMPLES//
  Botao(float _xpos, float _ypos, String _texto){
    xpos = _xpos;
    ypos = _ypos;
    texto = _texto;
    situacao = "LIBERADO";        // a priore, o botão é iniciado como se não estivesse ativado 
    psituacao = "SELECIONADO";    // caso queiramos que ele apresente-se 'selecionado' logo de
                                  // início, trocamos estas variáveis apos a chamada da função
                                  // construtora (tratam-se de parâmetros PUBLICOS)
                                  
    //comprimento = 12*texto.length();
    
    // dimensões-padrão
    altura = 20;    
    comprimento = 92;
  }

  //CONSTUTRUTORA EXTENDIDA (entramos com os valores de 'comprimento' e 'altura' do retângulo interno do botão)
  Botao(float _xpos, float _ypos, float _comprimento, float _altura, String _texto){
    xpos = _xpos;
    ypos = _ypos;
    comprimento = _comprimento;
    altura = _altura;
    texto = _texto;
    situacao = "LIBERADO";        // da mesma forma que na outra construtora 
    psituacao = "SELECIONADO"; 
    }

  //desenhamos o botão
  void display(){
    noStroke();
    rectMode(CENTER);
    pushMatrix();
    translate(xpos, ypos); //origem: centro do botão
   
    // as cores dos retângulos dependem da situação em que o botão se encontra
    
   /* //retângulo externo
    if(situacao == "LIBERADO")
      fill(255 - 180);
    else if(situacao == "PRESSIONADO")
      fill(255 - 200);
    else if(situacao == "SELECIONADO")
      fill(255 - 220);
    
    rect(0, 0, comprimento + 20, altura + 20); // desenhamos o retângulo
    */
    //retângulo intermediário
    if(situacao == "LIBERADO")
      fill(200);
    else if(situacao == "PRESSIONADO")
      fill(220);
    else if(situacao == "SELECIONADO")
      fill(180);
    
    rect(0, 0, comprimento + 10, altura + 10); // desenhamos o retângulo
    
    //retângulo interno
    if(situacao == "LIBERADO")
      fill(220);
    else if(situacao == "PRESSIONADO")
      fill(180);
    else if(situacao == "SELECIONADO")
      fill(200);
    
    rect(0, 0, comprimento , altura); // desenhamos o retângulo
    
    //a cor do texto também depende da situação do botão
    if(situacao == "PRESSIONADO")
      fill(255);
    else
      fill(0);
    
    text(texto, 0, 4); // escrevemos o texto
    
    popMatrix();  
  }
  
  //função chamada pelo clique do botão (embora o nome seja o mesmo da função da biblioteca interna
  //                                     do Processing, esta função não é chamada automaticamente
  //                                     pelo clique do mouse. Portanto devemos chamá-la dentro da
  //                                     função mousePressed do Processing)
  void mousePressed(){
    float dx = mouseX - xpos;
    float dy = mouseY - ypos;
    
    //se, no momento do clique do mouse, este estiver sobre o botão, o mesmo assume a situação "PRESSIONADO"
    if(abs(dx) < (comprimento)/2 && abs(dy) < (altura)/2)
      situacao = "PRESSIONADO";
    
    //gerenciamos a apresentação de informações adicionais pelo clique sobre a palavra 'Processing'
    if(abs(mouseX - (width/2 - 86)) < 30 && abs(mouseY - (height/2 - 68)) < 10)
      mais = !mais;    
  }
  
  //função chamada pela liberação do botão do mouse (vale o mesmo dito para a função mousePressed)
  void mouseReleased(){
    
    /*if(situacao == "PRESSIONADO" && psituacao == "LIBERADO"){
      situacao = psituacao;
      psituacao = "SELECIONADO";
    }
    
    if(situacao == "PRESSIONADO" && psituacao == "SELECIONADO"){
      situacao = psituacao;
      psituacao = "LIBERADO";
    }*/
    
    //se o botão foi pressionado, após a liberação do mouse o primeiro assume a situação "SELECIONADO"
    if(situacao == "PRESSIONADO" && psituacao == "SELECIONADO"){
      situacao = "SELECIONADO";
      psituacao = "LIBERADO";
    }
    
    if(situacao == "PRESSIONADO" && psituacao == "LIBERADO"){
      situacao = "LIBERADO";
      psituacao = "SELECIONADO";
    }
    
    
       
  }
  
  //função que libera o botão
  void libera(){
    psituacao = "SELECIONADO";
    situacao = "LIBERADO";
  }

}
}
 
