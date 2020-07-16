@interface SAFSearchAutoFocusViewController : UIViewController
@end

%hook SAFSearchAutoFocusViewController
- (void)viewDidAppear:(BOOL)animated {
	%orig;

	id input = ((SAFSearchAutoFocusViewController *)self).navigationItem.searchController.searchBar;
	if (input) {
		[input becomeFirstResponder];
		[UIApplication.sharedApplication sendAction:@selector(selectAll:) to:nil from:nil forEvent:nil];
	}
}
%end

%ctor {
	NSDictionary *defaults = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.dimitarnestorov.searchautofocus.plist"];
	NSNumber *isEnabledNumber = [defaults valueForKey:@"enabled"];
	BOOL isEnabled = isEnabledNumber == nil ? YES : [isEnabledNumber boolValue];

	if (!isEnabled) return;

	NSArray *userApps = [defaults valueForKey:@"apps"];
	NSArray *apps = userApps == nil ? @[
		@"com.apple.Music",
		@"com.apple.tv",
		@"xyz.willy.Zebra",
		@"com.apple.AppStore",
		@"com.apple.podcasts",
		@"org.coolstar.SileoStore",
		@"com.apple.iBooks",
		@"developer.apple.wwdc-Release",
		@"com.apple.mobileslideshow",
	] : userApps;

	NSString *bundleIdentifier = NSBundle.mainBundle.bundleIdentifier;

	if ([apps containsObject:bundleIdentifier]) {
		%init(SAFSearchAutoFocusViewController=objc_getClass("UIViewController"));
	}
}
