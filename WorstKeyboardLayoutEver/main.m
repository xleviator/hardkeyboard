//
//  main.m
//  WorstKeyboardLayoutEver
//
//  Created by Steven Moreland on 5.4.15.
//

// Proof of concept

@import Foundation;
@import AppKit;

#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        bool hard = false;
        
        NSString *nsarg = [NSString stringWithFormat:@"%s", argv[1]];
        
        switch(argc) {
            case 1: break; //isn't hard
            case 2: if ([nsarg isEqualToString:@"hard"]) {
                hard = true;
                break;
                    }
            default:
                NSLog(@"Usage: hardkeyboard [hard]");
                exit(0);
        }
        
        AppDelegate *delegate = [[AppDelegate alloc] initWithDifficulty:hard];
        
        NSApplication * application = [NSApplication sharedApplication];
        [application setDelegate:delegate];
        [NSApp run];
    }
    return 0;
}
