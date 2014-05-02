#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "ofxOpenCv.h"
#include "ofxGui.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
        void drawSingleTile();
        void drawMultipleTiles();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    //----------SARAHS OPENCV CODE
    
    ofVideoGrabber vidGrabber;
    
    ofTexture tex;
    
    ofxCvColorImage	colorImg;
    
    ofxCvGrayscaleImage grayImage;
    ofxCvGrayscaleImage grayBg;
    ofxCvGrayscaleImage grayDiff;
    
    float capW;
    float capH;
    
    ofxCvContourFinder contourFinder;
    
    int threshold;
    bool bLearnBakground;
    
    ofImage tile;
    ofxCvColorImage tilesample;
    ofxCvColorImage tilesample1;
    
    ofImage recognize;
    ofImage recognize1;
    
    ofTrueTypeFont andalemono;
    ofxCvColorImage subjectImg;
    ofxCvColorImage subjectImg1;
    
    
    bool pressed;
    bool startscreen;
    bool objectdetect;
    bool searching;
    
    double maximumvalue;
    
    ofPoint subjectLocation;
    ofPoint subjectLocation1;
    
    
    bool certain;
    bool certain1;

    
    //----------BETTYS PATTERN CODE
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


