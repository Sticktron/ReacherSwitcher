//
//  Settings for ReacherSwitcher
//
//  ©2017 Sticktron
//

#import <Preferences/PSListController.h>


@interface RSSettingsController : PSListController
@end

@implementation RSSettingsController
- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}
@end
