//
//  Tweak.xm
//
//  ReacherSwitcher (iOS 9/10)
//
//  ©2017 Sticktron
//

@interface SBReachabilityManager : NSObject
- (void)toggleReachability;
@end

@interface SBMainSwitcherViewController : NSObject
+ (id)sharedInstance;
- (BOOL)isVisible;
- (char)activateSwitcherNoninteractively;
- (char)dismissSwitcherNoninteractively;
- (char)toggleSwitcherNoninteractively;
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
		[[%c(SBMainSwitcherViewController) sharedInstance] toggleSwitcherNoninteractively];
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
