//
//  AppDelegate.m
//  WorstKeyboardLayoutEver
//
//  Created by Steven Moreland on 5.4.15.
//

#import "AppDelegate.h"

@import Carbon;

@implementation AppDelegate

@synthesize hard;

NSString *dvorak = @"com.apple.keylayout.Dvorak";
NSString *qwerty = @"com.apple.keylayout.US";

- (id) initWithDifficulty:(bool)hard
{
    self = [super init];
    if (self!=nil) {
        self.hard = hard;
    }
    return self;
}

// 10.9+ only, see this url for compatibility:
// http://stackoverflow.com/questions/17693408/enable-access-for-assistive-devices-programmatically-on-10-9
BOOL checkAccessibility()
{
    NSDictionary* opts = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    return AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)opts);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if (checkAccessibility()) {
        NSLog(@"Hardkeyboard is running.");
    }
    else {
        NSLog(@"Accessibility Disabled. It must be enabled for this application to work.");
        exit(0);
    }
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler: ^(NSEvent *event){[self handleKeyEvent:event];} ];
}

- (void)handleKeyEvent:(NSEvent *)event
{
    NSString *string = event.characters;
    
    for(int i = 0; i < string.length; i++) {
        char c = [string characterAtIndex:i];
        
        // hard mode is every character
        // easy mode is every other words
        if (c == ' ' || self.hard) {
            [self toggleLayout];
        }
    }
}

// TODO read in
bool isQwerty = true; //asumme

- (void)toggleLayout
{
    NSString* layout = isQwerty ? dvorak : qwerty;
    
    NSArray* sources = CFBridgingRelease(TISCreateInputSourceList((__bridge CFDictionaryRef)@{ (__bridge NSString*)kTISPropertyInputSourceID : layout }, FALSE));
    TISInputSourceRef source = (__bridge TISInputSourceRef)sources[0];
    OSStatus status = TISSelectInputSource(source);
    if (status == noErr) {
        NSLog(@"Changed keyboard layout to %@", layout);
    }
    else
    {
        NSLog(@"Failed to change keyboard layout %d", status);
        NSLog(@"Make sure you activate both Dvorak and US keyboard layouts in system preferences.");
    }
    isQwerty = !isQwerty;
}

@end
