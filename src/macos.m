// For MacOS, use Cocoa API
// written in Objective-C language

#import <Cocoa/Cocoa.h>
#import "platform.h"

static NSWindow *g_window = nil;

// 메뉴바를 생성하는 내부 함수
static void create_menu_bar(void) {
    NSMenu *menuBar = [[[NSMenu alloc] init] autorelease];
    [NSApp setMainMenu:menuBar];

    NSMenuItem *appMenuItem = [[[NSMenuItem alloc] init] autorelease];
    [menuBar addItem:appMenuItem];

    NSMenu *appMenu = [[[NSMenu alloc] init] autorelease];
    [appMenuItem setSubmenu:appMenu];

    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSString *quitTitle = [@"Quit " stringByAppendingString:appName];

    NSMenuItem *quitItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
                                                       action:@selector(terminate:)
                                                keyEquivalent:@"q"] autorelease];
    [appMenu addItem:quitItem];
}

// 윈도우를 생성하는 내부 함수
static void create_window(void) {
    NSRect frame = NSMakeRect(100, 100, 800, 600);
    NSUInteger style = NSWindowStyleMaskTitled |
                       NSWindowStyleMaskClosable |
                       NSWindowStyleMaskResizable;

    g_window = [[NSWindow alloc] initWithContentRect:frame
                                           styleMask:style
                                             backing:NSBackingStoreBuffered
                                               defer:NO];

    [g_window setTitle:@"My Objective-C Window"];
    [g_window makeKeyAndOrderFront:nil];
}

// 외부에서 호출할 초기화 함수
void platform_initialize(void) {
    if (NSApp == nil) {
        [NSApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
        create_menu_bar();
        [NSApp finishLaunching];
    }

    // 윈도우 생성
    create_window();

	[NSApp run];
}
