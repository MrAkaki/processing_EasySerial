EasySerial es;
void settings(){
  size(800, 600 );
}
void setup() {
  es = new EasySerial(this);
}
int entrada = 0;
void draw() {
  background(0);
  fill(255);
  textSize(32);
  text(entrada, 400, 300);
  
  if(es.connected()){
    if(es.available()>0){
      entrada = es.read();
    }
  }
}