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
    //ofSetColor(255, 238, 195, 140);
    //stoneTexture.draw(0, 0, ofGetWidth(), ofGetHeight());
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
        //ofSetColor(255, 238, 195, 140);
        //stoneTexture.draw(0, 0, ofGetWidth(), ofGetHeight());
        

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
    
    ofTrueTypeFont::setGlobalDpi(72);

    
    //---------------BETTYS TILE CODE
	
    ofSetOrientation(OF_ORIENTATION_90_LEFT);
    //ofSetVerticalSync(true);
    ofEnableAlphaBlending();
    ofSetLineWidth(3);
    //ofBackground(0, 0, 0);
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
    //gui.add(multiple.setup("Multiple tiles", false));
    
	bHide = true;
    
    cardioidSum = 0;
    cardioidOrder = 0;
    
    stoneTexture.loadImage(("stoneTexture1.jpg"));
    
    // START SCREEN
    startscreen = true;
    objectdetect = false;
    searching = false;
    
    tile.loadImage("tile.png");
    andalemono.loadFont("andalemono.ttf", 16, true, true);
    andalemono.setLetterSpacing(1.4);
    
    //---------------SARAHS OPENCV CODE
    
    capW = 320;
	capH = 240;
    
    vidGrabber.initGrabber(capW, capH);
    capW = vidGrabber.getWidth();
    capH = vidGrabber.getHeight();

    colorImg.allocate(capW,capH);
    grayImage.allocate(capW,capH);
    grayBg.allocate(capW,capH);
    grayDiff.allocate(capW,capH);
    
	bLearnBakground = true;
	threshold = 80;
	
	ofSetFrameRate(20);
    
    recognize.loadImage("tile2.jpg");
    tilesample.setFromPixels(recognize);
    
    recognize1.loadImage("tile1.jpg");
    tilesample1.setFromPixels(recognize1);
    

}

//--------------------------------------------------------------
void ofApp::update(){
    if(startscreen == true){
        ofBackground(100,100,100);
    }

    vidGrabber.update();
    
    if( vidGrabber.getPixels() != NULL ){
        colorImg.setFromPixels(vidGrabber.getPixels(), capW, capH);

	}
        if(objectdetect == true){

        subjectImg.allocate(tilesample.width, tilesample.height);//Allocate space for the template
        subjectImg = tilesample; //Copy the specific area to the subject image
        
        subjectImg1.allocate(tilesample1.width, tilesample1.height);//Allocate space for the template
        subjectImg1 = tilesample1; //Copy the specific area to the subject image
        
        
        IplImage *result = cvCreateImage(cvSize(capW - subjectImg.width + 1, capH - subjectImg.height + 1), 32, 1);
        cvMatchTemplate(colorImg.getCvImage(), subjectImg.getCvImage(), result, CV_TM_CCORR_NORMED);
        
        IplImage *result1 = cvCreateImage(cvSize(capW - subjectImg1.width + 1, capH - subjectImg1.height + 1), 32, 1);
        cvMatchTemplate(colorImg.getCvImage(), subjectImg1.getCvImage(), result1, CV_TM_CCORR_NORMED);
        
        double minVal, maxVal;
        CvPoint minLoc, maxLoc;
        cvMinMaxLoc(result, &minVal, &maxVal, &minLoc, &maxLoc, 0);
        //cvThreshold(subjectImg.getCvImage(), colorImg.getCvImage(), 0.8, 1, CV_THRESH_TOZERO);
        
        double minVal1, maxVal1;
        CvPoint minLoc1, maxLoc1;
        cvMinMaxLoc(result1, &minVal1, &maxVal1, &minLoc1, &maxLoc1, 0);
        
        subjectLocation.x = minLoc.x;
        subjectLocation.y = minLoc.y;
        
        subjectLocation1.x = minLoc1.x;
        subjectLocation1.y = minLoc1.y;
        
        double threshholdMatch;
        threshholdMatch = .98;
        
        double threshholdMatch1;
        threshholdMatch1 = .89;
    cout << "maxVal :" << maxVal << endl;
            cout << "maxVal1 :" << maxVal1 << endl;

    
        certain = maxVal > threshholdMatch;
        certain1 = maxVal1 > threshholdMatch1;
        
        //maximumvalue = maxVal;
    }

}

//--------------------------------------------------------------
void ofApp::draw(){
    
    //----------------------START SCREEN
    
    if(startscreen == true){
        ofBackground(40, 40, 40);
        ofSetColor(255, 255, 255);
        
        ofSetRectMode(OF_RECTMODE_CENTER);
        tile.draw(ofGetWidth()/2.0, (ofGetHeight()/2.0)-90);
        
        ofSetColor(0, 130, 130);
        ofRect(ofGetWidth()/2.0, (ofGetHeight()/2.0+90), 260, 50);
        
        ofSetColor(255, 255, 255);
        andalemono.drawString("SEARCH FOR TILES", ofGetWidth()/2.0-110, (ofGetHeight()/2.0+95));
        
        if (pressed == true){
            
            ofSetColor(0, 80, 80);
            ofRect(ofGetWidth()/2.0, (ofGetHeight()/2.0+90), 260, 50);
            
            ofSetColor(255, 255, 255);
            andalemono.drawString("SEARCH FOR TILES", ofGetWidth()/2.0-110, (ofGetHeight()/2.0+95));
        }
    }
    
    //OBJECT DETECT
	
    if(objectdetect == true){
        
        
        ofSetRectMode(OF_RECTMODE_CORNER);
        ofSetColor(255);
        ofDrawBitmapString(ofToString(ofGetFrameRate()), 20, 20);
        
        ofPushMatrix();
        ofScale(2.135, 2.135, 1);
        //ofScale(1, 1, 1);
        
        // draw the incoming, the grayscale, the bg and the thresholded difference
        ofSetHexColor(0xffffff);
        colorImg.draw(0,0);
        //grayBg.draw(capW+4, 0);
        //grayDiff.draw(0, capH + 4);
        
        // lets draw the contours.
        // this is how to get access to them:
        //for (int i = 0; i < contourFinder.nBlobs; i++){
        //contourFinder.blobs[i].draw(0, 0);
        //}
        
        // finally, a report:
        
        ofSetHexColor(0xffffff);
        char reportStr[1024];
        sprintf(reportStr, "bg subtraction and blob detection\npress ' ' to capture bg\nthreshold %i\nnum blobs found %i, fps: %f", threshold, contourFinder.nBlobs, ofGetFrameRate());
        //ofDrawBitmapString(reportStr, 4, 380);
        
        ofSetLineWidth(3);
        ofNoFill();
        //ofSetRectMode(OF_RECTMODE_CENTER);
        
        /*if(certain){
            ofSetColor(255,0,0);
            ofRect(subjectLocation.x, subjectLocation.y, tilesample.width, tilesample.height);
        }*/
        
        cout << "certain " << certain << endl;
        cout << "subject x " << subjectLocation.x << endl;
        cout << "subject y " << subjectLocation.y << endl;

        
        if(certain1){
          //  ofSetColor(0,255,0);
           // ofRect(subjectLocation1.x, subjectLocation1.y, tilesample1.width, tilesample1.height);
                    andalemono.drawString("TILE COMING SOON", ofGetWidth()/2.0-110, (ofGetHeight()/2.0+95));
        }
        
        ofPopMatrix();
        
        
        if(searching == true){
            
             ofSetColor(255, 255, 255);
             ofSetLineWidth(5);
             ofLine(ofGetWidth()/2-25, ofGetHeight()/2, ofGetWidth()/2+25, ofGetHeight()/2);
             ofLine( ofGetWidth()/2, ofGetHeight()/2-25, ofGetWidth()/2, ofGetHeight()/2+25);
             
             ofNoFill();
             
             ofBeginShape();
             ofVertex(ofGetWidth()/2-200, ofGetHeight()/2-100);
             ofVertex(ofGetWidth()/2-200, ofGetHeight()/2-150);
             ofVertex(ofGetWidth()/2-134, ofGetHeight()/2-150);
             ofEndShape();
             
             ofBeginShape();
             ofVertex(ofGetWidth()/2+200, ofGetHeight()/2-100);
             ofVertex(ofGetWidth()/2+200, ofGetHeight()/2-150);
             ofVertex(ofGetWidth()/2+134, ofGetHeight()/2-150);
             ofEndShape();
             
             ofBeginShape();
             ofVertex(ofGetWidth()/2+200, ofGetHeight()/2+100);
             ofVertex(ofGetWidth()/2+200, ofGetHeight()/2+150);
             ofVertex(ofGetWidth()/2+134, ofGetHeight()/2+150);
             ofEndShape();
             
             ofBeginShape();
             ofVertex(ofGetWidth()/2-200, ofGetHeight()/2+100);
             ofVertex(ofGetWidth()/2-200, ofGetHeight()/2+150);
             ofVertex(ofGetWidth()/2-134, ofGetHeight()/2+150);
             ofEndShape();
             
             ofFill();
             
        }
        
    }

    
    
    if( certain ){
   
        drawSingleTile();
            gui.draw();
        objectdetect = false;
        searching = false;
        startscreen = false;
	}
    //draw the GUI

	
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
    ofSetRectMode(OF_RECTMODE_CENTER);
    tile.draw(ofGetWidth()/2.0, (ofGetHeight()/2.0)-90);
    ofRect(ofGetWidth()/2.0, (ofGetHeight()/2.0+90), 260, 50);


    if(startscreen == true){
    //bLearnBakground = true;
    pressed = true;
    startscreen = false;
    objectdetect = true;
    searching = true;
    }

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
    pressed = false;


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
