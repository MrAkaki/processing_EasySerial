
import controlP5.*;
import processing.serial.*;

public class EasySerial extends PApplet{
  
  
  private ControlP5 cp5;
  private DropdownList portList;
  private DropdownList speedList;
  private Button btnConectar;
  private Button btnDesconectar;
  private Textarea debugO;
  
  private int nPorts = -1;
  
  private Serial serial = null;
  
  private PApplet context; 
  public EasySerial(PApplet context){
    super();
    this.context = context;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public void settings(){
    size(406,234);
  }
  
  public void setup(){
    surface.setLocation(context.width+2,0);
    //Inicializacion de objetos
    this.cp5 = new ControlP5(this);
    this.debugO = cp5.addTextarea("debug");
    this.portList = cp5.addDropdownList("portList");
    this.speedList = cp5.addDropdownList("speedList");
    this.btnConectar = cp5.addButton("Conectar");
    this.btnDesconectar = cp5.addButton("Desconectar");
    
 
    //Posicion de los objetos
    this.speedList.setPosition(2, 24); 
    this.portList.setPosition(204, 24);
    this.btnConectar.setPosition(102,2);
    this.btnDesconectar.setPosition(204,2);
    this.debugO.setPosition(2,40);
  
    //Configuracion de los objetos
    this.configDropDown(this.portList);
    this.configDropDown(this.speedList);
    this.portList.getCaptionLabel().set("Puerto"); 
    this.speedList.getCaptionLabel().set("BaudRate"); 
    
    
    this.btnConectar.setValue(0);
    this.btnConectar.setSize(100,19);
    this.btnDesconectar.setValue(0);
    this.btnDesconectar.setSize(100,19);
    
    
    this.debugO.setSize(402,192);
    this.debugO.setFont(createFont("arial",12));
    this.debugO.setColor(color(255,0,0));
    this.debugO.setColorBackground(color(255,200));
    this.debugO.setColorForeground(color(255));
    this.debugO.setText("DEBUG OUTPUT");
    
    //Rellenado d elos objeto
    this.setSpeeds();
    
    this.btnConectar.onClick(new CallbackListener(){
      public void controlEvent(CallbackEvent cbe){
        conectar();
      }
    });
    this.btnDesconectar.onClick(new CallbackListener(){
      public void controlEvent(CallbackEvent cbe){
        desconectar();
      }
    });
  }
  public void draw(){
    background(128);
    String [] ps = Serial.list();
    if(this.nPorts != ps.length){
      this.portList.clear();
      this.portList.addItems(ps);
      this.nPorts = ps.length;
    }
    try{
      Thread.sleep(250);
    }catch(Exception e){}
  }
  
  private void desconectar(){
    if(this.serial!=null){
      this.serial.stop();
      this.serial.dispose();
      this.serial = null;
      this.writeDebug("Desconectado!");
    }else{
      this.writeDebug("No se puede desconectar, debido a que no esta conectado!");
    }
  }
  
  private void conectar(){
    String puerto = this.portList.getItem((int)this.portList.getValue()).get("name").toString();
    int baud =  Integer.parseInt(this.speedList.getItem((int)this.speedList.getValue()).get("name").toString());
    this.writeDebug("Conectando en: "+puerto + " a: "+baud +" baud");
    try{
      this.serial = new Serial(this,puerto,baud);
      this.writeDebug("Conectado satisfatoriamente");
    }catch(Exception e){
      this.writeDebug("Error no se puede conectar en ese momento.\n"+e.getMessage());  
    }
  }
  
  
  
  public boolean connected(){
    return this.serial!=null && this.serial.active();
  }
  
  public int available(){
    return this.serial.available();
  }
  
  public int read(){
    return this.serial.read();
  }
  
  public byte[] readBytes(){
    return this.serial.readBytes();
  }
  
  public byte[] readBytes(int max){
    return this.serial.readBytes(max);
  }
  
  public int readBytes(byte[] dest){
    return this.serial.readBytes(dest);
  }
  
  public byte[] readBytesUntil(int inByte){
    return this.serial.readBytesUntil(inByte);
  }
  
  public int readBytesUntil(int inByte, byte[] dest){
    return this.serial.readBytesUntil(inByte,dest);
  }
  
  public char readChar(){
    return this.serial.readChar();
  }
  
  public String readString(){
    return this.serial.readString();
  }
  
  public String readStringUntil(int inByte){
    return this.serial.readStringUntil(inByte);
  }
  
  public boolean write(byte[] src){
    boolean done = true;
    try{
      this.serial.write(src);
    }catch(Exception e){
      done = false;
    }
    return done;
  }
  
  public boolean write(String src){
    boolean done = true;
    try{
      this.serial.write(src);
    }catch(Exception e){
      done = false;
    }
    return done;
  }
  
  ////////////////////////////    PRIVATE FUNCTIONS ///////////////////////
  
  private void writeDebug(String newText){
    this.debugO.setText(newText +"\n\n"+ this.debugO.getText());
  }
  
  private void configDropDown(DropdownList ddl){
    ddl.setBackgroundColor(color(190));
    ddl.setItemHeight(20);
    ddl.setBarHeight(15);
    ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
    ddl.setWidth(200);
    ddl.setHeight(200);
  }
  
  private void setSpeeds(){
    this.speedList.addItem("1200",1);
    this.speedList.addItem("2400",2);
    this.speedList.addItem("4800",3);
    this.speedList.addItem("9600",4);
    this.speedList.addItem("19200",5);
    this.speedList.addItem("38400",6);
    this.speedList.addItem("57600",7);
    this.speedList.addItem("74880",8);
    this.speedList.addItem("115200",9);
    this.speedList.addItem("230400",10);
    this.speedList.addItem("250000",11);
  }
  
}