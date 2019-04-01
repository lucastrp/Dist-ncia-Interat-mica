// BOTÃO///

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
    pushMatrix();
    translate(xpos, ypos); //origem: centro do botão
   
    // as cores dos retângulos dependem da situação em que o botão se encontra
    
    //retângulo externo
    if(situacao == "LIBERADO")
      fill(180);
    else if(situacao == "PRESSIONADO")
      fill(200);
    else if(situacao == "SELECIONADO")
      fill(220);
    
    rect(0, 0, comprimento + 20, altura + 20); // desenhamos o retângulo
    
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
    if(situacao == "PRESSIONADO"){
      situacao = "SELECIONADO";
      psituacao = "LIBERADO";
    }
      
  }
  
  //função que libera o botão
  void libera(){
    psituacao = "SELECIONADO";
    situacao = "LIBERADO";
  }

}
