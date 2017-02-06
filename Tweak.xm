//
//  Tweak.xm
//
//  ReacherSwitcher
//
//  ©2017 Sticktron
//

@interface AXSpringBoardServer : NSObject
+ (id)server;
- (void)openAppSwitcher;
- (void)dismissAppSwitcher;
@end

@interface SBReachabilityManager : NSObject
- (void)toggleReachability;
@end

@interface SBMainSwitcherViewController : NSObject
+ (id)sharedInstance;
- (BOOL)isVisible;
@end


static BOOL isEnabled;

static void loadSettings() {
	CFPreferencesAppSynchronize(CFSTR("com.sticktron.reacherswitcher"));
	Boolean valid;
	Boolean value = CFPreferencesGetAppBooleanValue(CFSTR("Enabled"), CFSTR("com.sticktron.reacherswitcher"), &valid);
	isEnabled = valid ? (BOOL)value : YES; //enabled by default
}

static void settingsCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	loadSettings();
}

%hook SBReachabilityManager
- (void)toggleReachability {
	if (isEnabled) {
		BOOL isShowing = [[%c(SBMainSwitcherViewController) sharedInstance] isVisible];
		if (!isShowing) {
			[[%c(AXSpringBoardServer) server] openAppSwitcher];
		} else {
			[[%c(AXSpringBoardServer) server] dismissAppSwitcher];
		}
	} else {
		%orig;
	}
}
%end

%ctor {
	@autoreleasepool {
		loadSettings();
		%init;
		
		// listen for settings changes
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
			NULL,
			(CFNotificationCallback)settingsCallback,
			CFSTR("com.sticktron.reacherswitcher.settingschanged"),
			NULL,
			CFNotificationSuspensionBehaviorDeliverImmediately
		);
	}
}
