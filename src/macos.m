// For MacOS, use Cocoa API
// written in Objective-C language

#import <Cocoa/Cocoa.h>
#import "platform.h"

static NSWindow *g_window = nil;
static int g_should_close = 0;

@interface WindowDelegate : NSObject <NSWindowDelegate>
@end

@implementation WindowDelegate
- (BOOL)windowShouldClose:(id)sender {
    g_should_close = 1;
    return (NO);
}
@end

void platform_initialize(void) {
    if (NSApp == nil) {
        [NSApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
        
        NSMenu *menuBar = [[[NSMenu alloc] init] autorelease];
        [NSApp setMainMenu:menuBar];
        NSMenuItem *appMenuItem = [[[NSMenuItem alloc] init] autorelease];
        [menuBar addItem:appMenuItem];
        NSMenu *appMenu = [[[NSMenu alloc] init] autorelease];
        [appMenuItem setSubmenu:appMenu];
        NSString *appName = [[NSProcessInfo processInfo] processName];
        NSString *quitTitle = [@"Quit " stringByAppendingString:appName];
        NSMenuItem *quitItem = [[[NSMenuItem alloc]
            initWithTitle:quitTitle
                  action:@selector(terminate:)
           keyEquivalent:@"q"] autorelease];
        [appMenu addItem:quitItem];

        [NSApp finishLaunching];
    }

    NSRect frame = NSMakeRect(100, 100, 800, 600);
    NSUInteger style = NSWindowStyleMaskTitled |
                       NSWindowStyleMaskClosable |
                       NSWindowStyleMaskResizable;

    g_window = [[NSWindow alloc] initWithContentRect:frame
                                           styleMask:style
                                             backing:NSBackingStoreBuffered
                                               defer:NO];
    [g_window setTitle:@"Renderer"];
    [g_window makeKeyAndOrderFront:nil];

    WindowDelegate *delegate = [[WindowDelegate alloc] init];
    [g_window setDelegate:delegate];
}

int window_should_close(void) {
    return (g_should_close);
}

void input_poll_events(void) {
    NSEvent *event;
    while ((event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                        untilDate:[NSDate distantPast]
                                           inMode:NSDefaultRunLoopMode
                                          dequeue:YES])) {
        [NSApp sendEvent:event];
    }
}
