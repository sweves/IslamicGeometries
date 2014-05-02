#pragma once

#include "ofMain.h"
#include "ofxGui.h"

class testApp : public ofBaseApp{
    
public:
    void setup();
    void update();
    void draw();
    void drawSingleTile();
    void drawMultipleTiles();
    
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);
    
    vector <ofPoint> points;
    vector <ofPoint> cardioidPoints;
    vector <ofPoint> cardioidPoints2;
    
    
    void drawCardioid(int change, int startPoint);
    void drawCardioid2(int change, int startPoint);
    void drawStar();
    void drawStar2();
    
    int cardioidSum;
    int cardioidOrder;
    
    ofImage stoneTexture;
    
    //GUI variables
    
	bool bHide;
    
    ofxIntSlider numOfPoints;
    ofxIntSlider cardioid2Size;
    ofxIntSlider cardioid1Size;
    ofxIntSlider warpOuter;
    ofxIntSlider warpInner;
    ofxToggle multiple;
	ofxLabel screenSize;
    
	ofxPanel gui;
};
