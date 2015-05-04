//
//  AppDelegate.h
//  WorstKeyboardLayoutEver
//
//  Created by Steven Moreland on 5.4.15.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property bool hard;

- (id)initWithDifficulty:(bool) hard;

- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (void)handleKeyEvent:(NSEvent *)event;
- (void)toggleLayout;

@end
