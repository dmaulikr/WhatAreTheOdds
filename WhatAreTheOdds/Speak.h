//
//  speak.h
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/22/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

/*#ifndef WhatAreTheOdds_speak_h
#define WhatAreTheOdds_speak_h


#endif*/

//#import <UIKit/UIKit.h>
//#import "AppDelegate.swift"
#import <SpeechKit/SpeechKit.h>

@interface Speak : NSObject <SpeechKitDelegate, SKRecognizerDelegate>

@property (strong, nonatomic) SKRecognizer* voiceSearch;
@property (strong, nonatomic) NSString* theirWords;
@property int theirOdds;

- (void)setupSpeechKitConnection;
- (void)speakingIsStarting/*:(SKRecognizer *) recognizer*/;
- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer;
- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results;
- (void) cancelListening;
- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion;
- (NSString *)convertResult:(NSString *)result;

@end
