#include "SAFRootListController.h"

#import "SparkAppListTableViewController.h"

NSDictionary *emptyDictionary = @{};

@implementation SAFRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)selectApps {
	NSString *path = @"/User/Library/Preferences/com.dimitarnestorov.searchautofocus.plist";
	NSDictionary *defaults = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	NSArray *apps = [defaults valueForKey:@"apps"];
	if (apps == nil) {
		NSMutableDictionary *newDefaults = [NSMutableDictionary dictionaryWithDictionary:defaults];
		[newDefaults setValue:@[
			@"com.apple.Music",
			@"com.apple.tv",
			@"xyz.willy.Zebra",
			@"com.apple.AppStore",
			@"com.apple.podcasts",
			@"org.coolstar.SileoStore",
			@"com.apple.iBooks",
			@"developer.apple.wwdc-Release",
			@"com.apple.mobileslideshow",
		] forKey:@"apps"];
		[newDefaults writeToFile:path atomically:YES];
	}

	SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.dimitarnestorov.searchautofocus" andKey:@"apps"];

	[self.navigationController pushViewController:s animated:YES];
	self.navigationItem.hidesBackButton = FALSE;
}

- (void)visitTwitter {
	[UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://twitter.com/dimitarnestorov"] options:emptyDictionary completionHandler:nil];
}

- (void)visitGithub {
	[UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://github.com/dimitarnestorov/SearchAutoFocus"] options:emptyDictionary completionHandler:nil];
}

- (void)visitPaypal {
	[UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://www.paypal.me/DimitarNestorov"] options:emptyDictionary completionHandler:nil];
}

- (void)visitDiscord {
	[UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://discord.gg/caPYtsN"] options:emptyDictionary completionHandler:nil];
}

@end
