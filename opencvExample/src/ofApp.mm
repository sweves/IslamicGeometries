#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){
    ofTrueTypeFont::setGlobalDpi(72);
    
	ofSetOrientation(OF_ORIENTATION_90_LEFT);//Set iOS to Orientation Landscape Right

	capW = 320;
	capH = 240;

	#ifdef _USE_LIVE_VIDEO
		vidGrabber.initGrabber(capW, capH);
		capW = vidGrabber.getWidth();
		capH = vidGrabber.getHeight();
    #else	
        vidPlayer.loadMovie("fingers.m4v");
        vidPlayer.setLoopState(OF_LOOP_NORMAL);
		vidPlayer.play();
	#endif

    colorImg.allocate(capW,capH);
    grayImage.allocate(capW,capH);
    grayBg.allocate(capW,capH);
    grayDiff.allocate(capW,capH);	

	bLearnBakground = true;
	threshold = 80;
	
	ofSetFrameRate(20);
    
    // START SCREEN
    startscreen = true;
    objectdetect = false;
    searching = false;
    
    tile.loadImage("tile.png");
    andalemono.loadFont("andalemono.ttf", 16, true, true);
    andalemono.setLetterSpacing(1.4);
    
    recognize.loadImage("tile2.jpg");
    tilesample.setFromPixels(recognize);
    
    recognize1.loadImage("tile1.jpg");
    tilesample1.setFromPixels(recognize1);
    
}

//--------------------------------------------------------------
void ofApp::update(){
	ofBackground(100,100,100);

    bool bNewFrame = false;

	#ifdef _USE_LIVE_VIDEO
       vidGrabber.update();
	   bNewFrame = vidGrabber.isFrameNew();
    #else
        vidPlayer.update();
        bNewFrame = vidPlayer.isFrameNew();    
    #endif


    
	if (bNewFrame){
	
		#ifdef _USE_LIVE_VIDEO
			if( vidGrabber.getPixels() != NULL ){
		#else
			if( vidPlayer.getPixels() != NULL && vidPlayer.getWidth() > 0 ){
		#endif

			#ifdef _USE_LIVE_VIDEO
				colorImg.setFromPixels(vidGrabber.getPixels(), capW, capH);
			#else
				colorImg.setFromPixels(vidPlayer.getPixels(), capW, capH);
			#endif

			grayImage = colorImg;
			if (bLearnBakground == true){
				grayBg = grayImage;		// the = sign copys the pixels from grayImage into grayBg (operator overloading)
				bLearnBakground = false;
			}

			// take the abs value of the difference between background and incoming and then threshold:
			grayDiff.absDiff(grayBg, grayImage);
			grayDiff.threshold(threshold);

			// find contours which are between the size of 20 pixels and 1/3 the w*h pixels.
			// also, find holes is set to true so we will get interior contours as well....
			contourFinder.findContours(grayDiff, 20, (capW*capH)/3, 10, true);	// find holes
		
		}
	}
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
        threshholdMatch = .978;
        
        double threshholdMatch1;
        threshholdMatch1 = .905;
        
        certain = maxVal > threshholdMatch;
        certain1 = maxVal1 > threshholdMatch1;

        //maximumvalue = maxVal;
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    //START SCREEN
    
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
        
        if(certain){
            ofSetColor(255,0,0);
            ofRect(subjectLocation.x, subjectLocation.y, tilesample.width, tilesample.height);
        }
        
        if(certain1){
            ofSetColor(0,255,0);
            ofRect(subjectLocation1.x, subjectLocation1.y, tilesample1.width, tilesample1.height);
        }
        
        ofPopMatrix();

        
        if(searching == true){
            /*
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
             */
        }
     
    }
}
    
//--------------------------------------------------------------
void ofApp::exit(){
        
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
	bLearnBakground = true;
    pressed = true;
    startscreen = false;
    objectdetect = true;
    searching = true;
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
        
}
    
//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    //pressed = false;
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
