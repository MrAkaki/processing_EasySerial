# ProcessingEasySerial
Scketch base con GUI para facil coneccion serial
Crea un frame externo donde tiene:
  1. Dropdown con los puertos disponible, para seleccionar el puerto de la conexion.
  2. Dropdown con los baudrates mas comunes, para seleccionar la velocidad de la conexion.
  3. Boton de conectar.
  4. Boton de desconectar.
  5. Consola de salida debug para un poco de informacion util.
  
Utiliza la libreria controlP5 (http://www.sojamo.de/libraries/controlP5/), para crear el GUI en el frame externo.
<p>
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>
<br />
This work is licensed under a <br/>
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
Creative Commons Attribution-ShareAlike 4.0 <br/>International License
</a>.
</p>

<hr/>

Dispone de las funciones:
+ EasySerial(PApplet)

   El Constructor recibe por parametro el PApplet creado por defecto.
   ```java
   EasySerial es;
   void settings(){
     size(700, 400 );
   }
   void setup() {
     es = new EasySerial(this);
   }
```
+ connected(): boolean
   
   Reviza si se a conectado a algun dispositivo y no han avido erroes de comunicacion.
   ```java
   EasySerial es;
   void settings(){
     size(700, 400 );
   }
   void setup() {
     es = new EasySerial(this);
   }
   void draw(){
     if(es.connected()){
      println("estoy conectado a un dispositivo C:");
     }else{
      println("no estoy conectado a un dispositivo :C");
     }
   }
```
