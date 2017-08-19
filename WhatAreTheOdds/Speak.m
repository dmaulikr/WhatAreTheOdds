//
//  speak.m
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/22/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "speak.h"

@interface Speak ()

@end

const unsigned char SpeechKitApplicationKey[] = {0x04, 0x06, 0xbb, 0x75, 0xe1, 0xa9, 0x29, 0x5a, 0xd3, 0x33, 0x73, 0x7a, 0x94, 0x72, 0x0d, 0x09, 0xf1, 0x5a, 0x8e, 0x56, 0xe9, 0x79, 0x68, 0xc9, 0xed, 0xd7, 0x49, 0xc7, 0x40, 0xaf, 0x05, 0x44, 0xb6, 0xc0, 0xb9, 0x97, 0x6a, 0xe3, 0xf1, 0x3d, 0x16, 0x65, 0xb7, 0xaa, 0xd7, 0xc5, 0xb3, 0xc8, 0x1f, 0x41, 0x1f, 0x08, 0xbb, 0x87, 0xd1, 0xa8, 0x5e, 0x1a, 0x6f, 0x9e, 0xca, 0x74, 0xe3, 0x80};

@implementation Speak

# pragma mark - Setup SpeechKit Connection

- (void)setupSpeechKitConnection {
    [SpeechKit setupWithID:@"NMDPTRIAL_normdoow20141222173840"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:nil];
    
}

- (void)speakingIsStarting/*:(SKRecognizer *) recognizer*/ {
    self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                detection:SKShortEndOfSpeechDetection
                                                 language:@"en_US"
                                                 delegate:self];
}

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer{
    NSLog (@"In did begin recording");
    
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results{
    NSLog (@"finished recording");
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
       //self.theirWords = [results firstResult];
        self.theirWords = [self convertResult:[results firstResult]];           //get the results and change them if needed
        //NSLog([results firstResult]);
    }
    
    //self.recordButton.selected = !self.recordButton.isSelected;
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }
}

- (void) cancelListening {
    [self.voiceSearch cancel];
    NSLog(@"cancelled recording");
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion{
    //NSLog (@"In there was an error");
    self.theirWords = @"I did not understand what you said";
}

- (NSString *)convertResult :(NSString *)result {
    
    //array to hold the differen possibilities
    NSArray *possibilities = @[@"Nothing", @"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"Elleven" , @"Twelve", @"Thirteen", @"Fourteen", @"Fifteen", @"Sixteen", @"Seventeen", @"Eighteen", @"Nineteen", @"Twenty", @"Twentyone", @"Twentytwo", @"Twentythree", @"Twentyfour", @"Twentyfive"];
    
    for (int k = 0; k < [possibilities count]; k++) {
        if ([result isEqualToString:possibilities[k]]) {
            if (k > self.theirOdds) {
                return [NSString stringWithFormat:@"The number must be from 1 to %d",self.theirOdds ];
            }
            return [NSString stringWithFormat:@"%i", k];
        }
    }
    //check for a couple other possibilities
    if ([result intValue] != 0) {
        //NSLog([NSString stringWithFormat:@"%d", self.theirOdds]);
        if ([result intValue] > self.theirOdds) {
            return [NSString stringWithFormat:@"The number must be from 1 to %d",self.theirOdds ];
        } else {
            return result;
        }
    } else if ([result  isEqual: @"Tree"]) {
        return @"3";
    } else if ([result  isEqual: @"Or"] || [result  isEqual: @"For"]) {
        return @"4";
    } else if ([result  isEqual: @"Ive"]) {
        return @"5";
    } else {
        return @"I did not understand what you said";
    }

}

@end