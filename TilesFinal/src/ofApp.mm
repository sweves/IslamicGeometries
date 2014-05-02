#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::drawSingleTile(){
    
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
void ofApp::drawMultipleTiles(){
    
    
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
void ofApp::drawCardioid(int change, int startPoint){
    
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
void ofApp::drawCardioid2(int change, int startPoint){ //the sand colored tile
    
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
void ofApp::setup(){
	
    ofSetOrientation(OF_ORIENTATION_90_LEFT);
    //ofSetVerticalSync(true);
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
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    
    if( multiple ){
        drawMultipleTiles();
	}else{
        drawSingleTile();
	}
    //draw the GUI
    gui.draw();
	
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
