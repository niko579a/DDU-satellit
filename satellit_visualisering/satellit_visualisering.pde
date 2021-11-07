float angle;

Table table;
float r = 200;

PImage earth;
PShape globe;
PShape sat1;

JSONObject j;
JSONArray positionsJson;
JSONObject pos1;
JSONObject pos2;
float sat1Lon;
float sat1Lat;
float sat2Lon;
float sat2Lat;

float rotation = 0;

PVector yAxis = new PVector(0, 1, 0);
PVector zAxis = new PVector(0, 0, 1);

void setup() {
 frameRate(60);
 
 j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=UJXN78-YE3DB8-NX877Y-4SW0");
 positionsJson = j.getJSONArray("positions");
 pos1 = positionsJson.getJSONObject(0);
 pos2 = positionsJson.getJSONObject(1);
 sat1Lon = pos1.getFloat("satlongitude");
 sat1Lat = pos1.getFloat("satlatitude");
 sat2Lon = pos2.getFloat("satlongitude");
 sat2Lat = pos2.getFloat("satlatitude");

 size(600, 600, P3D);
 earth = loadImage("earth.jpg");
 
 noStroke();
 globe = createShape(SPHERE, r);
 globe.setTexture(earth);
 
 sat1 = createShape(SPHERE, 5);
}

void draw() {
 background(51);
 pushMatrix();
 translate(width*0.5, height*0.5);
 rotateY(angle);
 angle += 0.002;

 ambientLight(255, 255, 255);
 fill(200);
 noStroke();
 shape(globe);
 popMatrix();
 
  float theta = radians(sat1Lat);

  float phi = radians(sat1Lon) + PI;

  float x = r * cos(theta) * cos(phi);
  float y = -r * sin(theta);
  float z = -r * cos(theta) * sin(phi);

  PVector pos = new PVector(x, y, z);
  
  rotation += 0.008;

  pushMatrix();
  translate(width*0.5, height*0.5);
  //translate(pos.x, pos.y, pos.z);
  //translate(0, 0, 255);
  //rotate(angle, yAxis.x, yAxis.y, yAxis.z);
  fill(255);
  rotateZ(PI/4);
  rotateY(rotation);
  translate(pos.x + 30, pos.y + 30, pos.z + 30);
  shape(sat1);
  popMatrix();
}
