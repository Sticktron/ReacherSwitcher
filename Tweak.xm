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


%hook SBReachabilityManager
- (void)toggleReachability {
	BOOL isShowing = [[%c(SBMainSwitcherViewController) sharedInstance] isVisible];
	if (!isShowing) {
		[[%c(AXSpringBoardServer) server] openAppSwitcher];
	} else {
		[[%c(AXSpringBoardServer) server] dismissAppSwitcher];
	}
}
%end
