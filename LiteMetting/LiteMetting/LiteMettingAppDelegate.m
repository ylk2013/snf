//
//  LiteMettingAppDelegate.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "LiteMettingAppDelegate.h"

#import "LiteMettingViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

BMKMapManager* _mapManager;

@implementation LiteMettingAppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"9CB26C54E483CC37C61E1115B03544E15A61782D" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    //shareSDK
    //wx9e871c89691521c3
//    [WXApi registerApp:@"wx6dd7a9b94f3dd72a"];
    [WXApi registerApp:@"wx9e871c89691521c3"];
    [ShareSDK registerApp:@"529c55736c"];
    
    self.viewController = [[[LiteMettingViewController alloc] initWithNibName:@"LiteMettingViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url wxDelegate:self]; }
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url wxDelegate:self]; }

@end
