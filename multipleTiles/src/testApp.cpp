#include "testApp.h"

//--------------------------------------------------------------
void testApp::drawSingleTile(){
    
    ofPushMatrix();
    
    ofDisableAlphaBlending();
    
    //this draws the chubby, sand-colored, curved 8 star
    ofPushMatrix();
    ofScale(2, 2);
    ofTranslate(-ofGetWidth()/4, -ofGetHeight()/4);
    for(int i = 0; i <= 360; i+=(360/numOfPoints)){
        ofPushMatrix();
        ofPushMatrix();
        ofPopMatrix();
        ofTranslate(ofGetWidth()/2, ofGetHeight()/2); //y is diagonal right up if negative
        ofRotate(0+i);
        for(int j=0; j<= 20; j+=20)
        {
            drawCardioid2(1, j);
            ofTranslate(-ofGetWidth()/2, -ofGetHeight()/2-30);
        }
        ofPopMatrix();
    }
    ofPopMatrix();
    ofPopMatrix();
    
    
    //this draws the blue cardioids
    ofPushMatrix();
    ofScale(2,2);
    ofTranslate(-ofGetWidth()/4, -ofGetHeight()/4);
    for(int i = 0; i <= 360; i+=45){ //changes number of angles
        ofPushMatrix();
        ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
        ofRotate(0+i);
        for(int j=0; j<= 20; j+=20)
        {
            drawCardioid(1, j);
            ofTranslate(-ofGetWidth()/2, -ofGetHeight()/2-30);
        }
        ofPopMatrix();
    }
    ofPopMatrix();
    
    //add the texture
    ofEnableBlendMode(OF_BLENDMODE_MULTIPLY);
    ofSetColor(255, 238, 195, 140);
    stoneTexture.draw(0, 0, ofGetWidth(), ofGetHeight());
}

//--------------------------------------------------------------
void testApp::drawMultipleTiles(){
    
    
    ofPushMatrix();
    //ofScale(0.5, 0.5);
    {
    ofPushMatrix();
    
    ofDisableAlphaBlending();
    
    //this draws the chubby, sand-colored, curved 8 star
    ofPushMatrix();
    //ofScale(2, 2);
    for(int i = 0; i <= 360; i+=(360/numOfPoints)){
        ofPushMatrix();
        ofPushMatrix();
        ofPopMatrix();
        ofTranslate(ofGetWidth()/2, ofGetHeight()/2); //y is diagonal right up if negative
        ofRotate(0+i);
        for(int j=0; j<= 20; j+=20)
        {
            drawCardioid2(1, j);
            ofTranslate(-ofGetWidth()/2, -ofGetHeight()/2-30);
        }
        ofPopMatrix();
    }
    ofPopMatrix();
    ofPopMatrix();
    
    
    //this draws the blue cardioids
    ofPushMatrix();
  //  ofScale(2,2);
    for(int i = 0; i <= 360; i+=45){ //changes number of angles
        ofPushMatrix();
        ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
        ofRotate(0+i);
        for(int j=0; j<= 20; j+=20)
        {
            drawCardioid(1, j);
            ofTranslate(-ofGetWidth()/2, -ofGetHeight()/2-30);
        }
        ofPopMatrix();
    }
    ofPopMatrix();
        ofPopMatrix();

    //add the texture
    ofEnableBlendMode(OF_BLENDMODE_MULTIPLY);
    ofSetColor(255, 238, 195, 140);
    stoneTexture.draw(0, 0, ofGetWidth(), ofGetHeight());
    }
}


//--------------------------------------------------------------
void testApp::drawCardioid(int change, int startPoint){
    
    ofSetColor(44, 176, 196);
    
    int a=startPoint + cardioid1Size - 3; //this increases the size of the cardioid
    int centerX=ofGetWidth()/2 - warpInner; //this warps it  (ex int centerX=ofGetWidth()/2 -40;)
    int centerY=ofGetHeight()/2-40; //this makes it chubby somehow
    //
    float x, y;
    float x2, y2, x3, y3;
    
    for(int t=0; t <= 360; t+=1){
        float rad= ofDegToRad(t);
        
        y2=centerY-a*(3*cos(rad)-1.75*cos(2*rad));
        x2=centerX+a*(1.5*sin(rad)-sin(3*rad));
        
        y3=centerY-(a-3)*(3*cos(rad)-1.75*cos(2*rad));
        x3=centerX+(a-3)*(1.5*sin(rad)-sin(3*rad));
        ofLine(x2, y2, x3, y3);
    }
}

//--------------------------------------------------------------
void testApp::drawCardioid2(int change, int startPoint){ //the sand colored tile
    
    ofSetColor(255, 255, 215);
    int a=startPoint + cardioid2Size - 4; //this increases the size of the cardioid
    int centerX=ofGetWidth()/2 - warpOuter; //this warps it  (ex int centerX=ofGetWidth()/2 -40;)
    int centerY=ofGetHeight()/2-40; //this makes it chubby somehow
    //
    float x, y;
    float x2, y2, x3, y3;
    
    for(int t=0; t < 360; t+=1){
        float rad= ofDegToRad(t);
        
        y2=centerY-a*(3*cos(rad)-1.75*cos(2*rad));
        x2=centerX+a*(1.5*sin(rad)-sin(3*rad));
        
        y3=centerY-(a-5)*(3*cos(rad)-1.75*cos(2*rad));
        x3=centerX+(a-5)*(7.5*sin(rad)-sin(3*rad)); //7.5
        ofLine(x2, y2, x3, y3);
    }
}



//--------------------------------------------------------------
void testApp::setup(){
    ofSetVerticalSync(true);
    ofEnableAlphaBlending();
    ofSetLineWidth(3);
    ofBackground(0, 0, 0);
    // ofBackgroundGradient(ofColor::gray, ofColor::black);
    
    gui.setup(); // most of the time you don't need a name to setup the GUI
    //	gui.add(radius.setup( "radius", 140, 10, 300 ));
    //	gui.add(center.setup("center",ofVec2f(ofGetWidth()*.5,ofGetHeight()*.5),ofVec2f(0,0),ofVec2f(ofGetWidth(),ofGetHeight())));
    //	gui.add(color.setup("color",ofColor(100,100,140),ofColor(0,0),ofColor(255,255)));
    gui.add(numOfPoints.setup("Number of points", 8, 1, 16));
    gui.add(cardioid1Size.setup("Inner tile size", 0, -17, 17));
    gui.add(cardioid2Size.setup("Outer tile size", 0, -7, 7));
    gui.add(warpInner.setup("Inner tile warp", 0, -50, 50));
    gui.add(warpOuter.setup("Outer tile warp", 0, -50, 50));
    gui.add(multiple.setup("Multiple tiles", false));
    
	bHide = true;
    
    cardioidSum = 0;
    cardioidOrder = 0;
    
    stoneTexture.loadImage(("stoneTexture1.jpg"));
}

//--------------------------------------------------------------
void testApp::update(){
}

//--------------------------------------------------------------
void testApp::draw(){
    
    
    if( multiple ){
        drawMultipleTiles();
	}else{
        drawSingleTile();
	}
        //draw the GUI
    gui.draw();
    
}

//--------------------------------------------------------------
void testApp::keyPressed(int key){
    
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){
    
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
    
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
    
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
    
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
    
}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){
    screenSize = ofToString(w) + "x" + ofToString(h);
}

//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){
    
}

//--------------------------------------------------------------
void testApp::dragEvent(ofDragInfo dragInfo){
    
}