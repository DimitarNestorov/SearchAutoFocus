#include "SAFRootListController.h"

#include "NSTask.h"

#import "SparkAppListTableViewController.h"

NSDictionary *emptyDictionary = @{};

@implementation SAFRootListController

- (instancetype)init {
    self = [super init];

    if (self) {
        self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
        self.appListRespringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
        self.navigationItem.rightBarButtonItem = self.respringButton;
    }

    return self;
}

- (void)respring {
	NSTask *t = [[NSTask alloc] init];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
    [t launch];
}

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
	s.navigationItem.rightBarButtonItem = self.appListRespringButton;
	s.navigationItem.title = @"Select Apps";

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
