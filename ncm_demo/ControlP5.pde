void addUI(){
  cp5 = new ControlP5(this);
  pfont = createFont("Arial",20,true);
  ControlFont font = new ControlFont(pfont,16);
  
  cp5.addTextfield("UserName")
     .setPosition(100, 25)
     .setSize(150, 40)
     .getValueLabel().setFont(new ControlFont(pfont, 24));
     
  cp5.addButton("Start")
     .setPosition(280, 25)
     .setSize(60, 40)
     .setFont(font);
  
  cp5.addSlider("Volume")
     .setPosition(100, 100)
     .setSize(600, 60)
     .setRange(0, 40)
     .setValue(20)
     .setNumberOfTickMarks(41)
     .snapToTickMarks(true)
     .setLabelVisible(false)
     .hide();
     
  cp5.addButton("Play")
     .setPosition(100, 200)
     .setSize(100, 60)
     .setFont(font)
     .hide();
     
  cp5.addButton("Next")
     .setPosition(600, 200)
     .setSize(100, 60)
     .setFont(font)
     .hide();
}

void controlEvent(ControlEvent theEvent){
  switch(theEvent.getController().getName()){
    case "Start":
      isStarted = true;
      cp5.get(Textfield.class, "UserName").hide();
      cp5.get(Button.class, "Start").hide();
      cp5.get(Slider.class, "Volume").show();
      cp5.get(Button.class, "Play").show();
      //cp5.get(Button.class, "Next").show();
    
      // determine CSV file name
      String user_name = cp5.get(Textfield.class, "UserName").getText();
      String file_name = user_name +".csv";
      writer = createWriter( file_name );
      writer.println("step,music_id,noise_id,value");
      
      // get a pear of file ID from txt and load MP3
      rows = loadStrings(user_name +".txt");
      //println(rows);
      for(int i = 0; i < rows.length ; i++){
        String[] ids = rows[i].split(",");
        IDpears[i] = new int[]{int(ids[0]), int(ids[1])};
      }
      
      println("ユーザネーム "+ user_name +" で実験を開始します");
      loadMP3();
      break;
    
    case "Volume":
      float gain = cp5.getController("Volume").getValue();
      noise.setGain(gain - CORRECTION);
      
      if(!cp5.get(Button.class, "Next").isVisible()){
        cp5.get(Button.class, "Next").show();
      }
      break;
      
    case "Play":

      if( isTurnOfMusic ){
        for(int i = 0; i < 3; i ++){
          count.rewind();
          count.play();
          delay(1000);
        }
        noise.play();
        music.play();
      }else{

        
        noise.play();
        noise.loop();
      }
      break;
    
    case "Next":
      // Export gain to PrintWriter
      gain = cp5.getController("Volume").getValue();
      String row_export = (progress+1) +","+ IDpears[progress][0] +","+ IDpears[progress][1] +","+ int(gain); 
      println(row_export);
      writer.println(row_export);
      
      // show NEXT button by setting value of VOLUME slider --> hide NEXT button again
      cp5.getController("Volume").setValue(20);
      cp5.getController("Next").hide();
      
      // Reload MP3 files and step to next phase
      noise.pause();
      progress ++;
      if( progress == PROG_MAX ){
        writer.flush();
        writer.close();
        exit();
      }
      loadMP3();
      break;
  }
}
