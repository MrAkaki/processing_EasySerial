EasySerial es;
void settings(){
  size(700, 400 );
}
void setup() {
  es = new EasySerial(this);
}

void draw() {
  background(128);
  if(es.connected()){
    if(es.available()>0){
      print(es.read());
    }
  }
}