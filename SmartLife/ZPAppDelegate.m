//
//  ZPAppDelegate.m
//  SmartLife
//
//  Created by zppro on 12-11-20.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "ZPAppDelegate.h"
#import "AppMacro.h"
#import "HomeController.h"
 
@implementation ZPAppDelegate 

- (void)dealloc
{ 
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initSettings];
    
    [theSkinManager loadWithContentsOfFile:@"SkinIndex"];
    
    soc.reach = [Reachability reachabilityForInternetConnection];
    [soc.reach startNotifier];
    
    /*
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            // First time access has been granted, add the contact
            DebugLog(@"%d",granted);
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // The user has previously given access, add the contact
        
    }
    else {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
    */
    
    //APS
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    
    
    HomeController *homeController = [[[HomeController alloc] init] autorelease];
    [_window setRootViewController:[[[UINavigationController alloc] initWithRootViewController:homeController] autorelease]];
     
    
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

#pragma mark -
#pragma mark 收到远程通知以后注册到CNS
- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //将来地址可以通过配置解决
    DebugLog(@"deviceToken:%@",deviceToken); 
    const unsigned *tokenBytes = [deviceToken bytes]; 
    soc.rom.deviceToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                           ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                           ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                           ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    soc.rom.applicationId = appId;
    
    DebugLog(@"deviceToken:%@",soc.rom.deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    DebugLog(@"CNS Error:%@",error);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    DebugLog(@"%@",userInfo);
}

//系统第一次运行时，初始化参数
-(void)initSettings {
    //MARK;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //认证地址
    if (![defaults objectForKey:APP_SETTING_AUTH_BASE_URL_KEY]) {
        [NSUserDefaults setString:@"115.236.175.109:16812"  forKey:APP_SETTING_AUTH_BASE_URL_KEY];
    }
    //Debug Mode
    if (![defaults objectForKey:SETTING_DEBUG_KEY]) {
        [NSUserDefaults setBool:FALSE forKey:SETTING_DEBUG_KEY];
    }
    //设置版本
    [NSUserDefaults setString:[[NSBundle mainBundle] bundleVersion]  forKey:SETTING_DEPLOY_VERSION_KEY];
    [defaults synchronize];
}

@end
