//
//  HomeController.m
//  SmartLife
//
//  Created by zppro on 12-11-20.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
#import "PersonalCenterIndexController.h"
#import "ProvideForTheAgedIndexController.h"
#import "SmartPhoneController.h"
#import "RecentCallController.h"
#import "AddressBookController.h"
#import "DialingController.h"

@interface HomeController ()

@end

@implementation HomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //location
    soc.locationManager = [[[CLLocationManager alloc] init] autorelease];//创建位置管理器
    soc.locationManager.delegate = self;
    soc.locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    soc.locationManager.distanceFilter=100.0f;//设置距离筛选器，即更新频率
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [soc.locationManager startUpdatingLocation];//启动位置管理器
    });
    
    //adressbook
    //ab.delegate = self;
    
    
    if([self updateInterfaceWithReachability]){
        //开启了网络服务
        // 获得当前位置 
        
    }
    //各种初始化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //soc.reach = [Reachability reachabilityForInternetConnection];
    //[soc.reach startNotifier];
    
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *mainMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
          
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([self class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainMenu addSubview:btn];
        }
    } 
    [self.view addSubview:mainMenu];
    [mainMenu release];
    
    /*
    BOOL isSignIn = appSession.userId!=nil;
    if(!isSignIn){ 
        LoginController *loginController = [[LoginController alloc] init];
        [self presentModalViewController:loginController animated: YES];
    }
    */
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    BOOL isSignIn = appSession.userId!=nil;
    if(!isSignIn){
        LoginController *loginController = [[[LoginController alloc] init] autorelease];
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self presentModalViewController:nav2 animated: YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 子类重写方法
- (UIImage*) getHeaderBackgroundImage{
    return nil;
}
- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark 按钮事件
- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    [button scaleMe2D];
    
    switch (button.tag) {
        case 1:{
            [self navigationTo:[[[PersonalCenterIndexController alloc] init] autorelease]];
             break;
        }
        case 2: { 
            
            break;
        }
        case 5:{
            [self navigationTo:[[[ProvideForTheAgedIndexController alloc] init] autorelease]];
            break;
        }
        case 3:
        case 4:{
            UITabBarController *voipController = [[UITabBarController alloc] init];
            SmartPhoneController *smartPhoneVC = [[SmartPhoneController alloc] init];
            UITabBarItem *itemOfSmartPhone = [[UITabBarItem alloc] initWithTitle:@"智慧电话" image:nil tag:1];
            [itemOfSmartPhone setFinishedSelectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/01S.png") scaleToSize:CGSizeMake(24, 24)] withFinishedUnselectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/01.png") scaleToSize:CGSizeMake(24, 24)]];
            smartPhoneVC.tabBarItem = itemOfSmartPhone;
            [itemOfSmartPhone release];
            
            RecentCallController *recentCallVC = [[RecentCallController alloc] init];
            UITabBarItem *itemOfRecentCall = [[UITabBarItem alloc] initWithTitle:@"最近通话" image:nil tag:2];
            [itemOfRecentCall setFinishedSelectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/02S.png") scaleToSize:CGSizeMake(24, 24)] withFinishedUnselectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/02.png") scaleToSize:CGSizeMake(24, 24)]];
            recentCallVC.tabBarItem = itemOfRecentCall;
            [itemOfRecentCall release];
            
            AddressBookController *addressBookVC = [[AddressBookController alloc] init];
            UITabBarItem *itemOfAddressBook = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:nil tag:3];
            [itemOfAddressBook setFinishedSelectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/03S.png") scaleToSize:CGSizeMake(24, 24)] withFinishedUnselectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/03.png") scaleToSize:CGSizeMake(24, 24)]];
            addressBookVC.tabBarItem = itemOfAddressBook;
            [itemOfAddressBook release];
            
            DialingController *dialingController = [[DialingController alloc] init];
            UITabBarItem *itemOfDialing = [[UITabBarItem alloc] initWithTitle:@"拨号键盘" image:nil tag:4];
            [itemOfDialing setFinishedSelectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/04S.png") scaleToSize:CGSizeMake(24, 24)] withFinishedUnselectedImage:[MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/04.png") scaleToSize:CGSizeMake(24, 24)]];
            dialingController.tabBarItem = itemOfDialing;
            [itemOfDialing release];
            
            voipController.viewControllers=[NSArray arrayWithObjects:smartPhoneVC,recentCallVC,addressBookVC,dialingController,nil]; 
            [self navigationTo:voipController];
            [voipController release];
            break;
        }
        default:
            break;
    }

}



#pragma mark -
#pragma mark 检测网络

- (void) reachabilityChanged: (NSNotification* )note {
    DebugLog(@"reachabilityChanged!");
    soc.reach = [note object];
    if([self updateInterfaceWithReachability]){
        
    }
}

- (BOOL) updateInterfaceWithReachability{
    BOOL ret = YES;
    NSString *title = nil;
    appSession.networkStatus = [soc.reach currentReachabilityStatus];
     
    // 3G网络
    if (appSession.networkStatus == ReachableViaWWAN) {
        DebugLog(@"#####3G");
        title = @"正在使用3G";
    }
    // WIFI
    else if (appSession.networkStatus == ReachableViaWiFi) {
        DebugLog(@"#####Wifi");
        title = @"正在使用Wifi";
    }
    //没有连接到网络就弹出提示框
    else{
        DebugLog(@"#####NOInternet");
        title = @"没有网络信号";
        ret = NO;
    }
    
    //[self showWaitViewWithTitle:title andCloseDelay:2.f];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	//HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.delegate = self;
	HUD.labelText = title;
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:3];
    
    return ret;
}



#pragma mark -
#pragma mark 位置管理器

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation*) oldLocation
{
    //取得经纬度
    
    DebugLog(@"定位成功:%@",newLocation);
    soc.myLocation = newLocation;
    soc.canLocation = YES;
    //此处可访问第三方偏移量接口或者获得实际偏移量算法
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    soc.canLocation = NO;
    soc.debugMyLocation = [[[CLLocation alloc] initWithLatitude:30.290194 longitude:120.155073] autorelease];//120.155073,30.290194
    if (error.code == kCLErrorDenied){
        // User denied access to location service
        DebugLog(@"没有开启定位服务:%@",error);
        showHUDInfo(self,self.view,@"没有开启定位服务");
        
    }
    else{
        DebugLog(@"定位服务出错:%@",error);
        showHUDInfo(self,self.view,@"定位服务出错");
    }
    //[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameLocationDidUpdate object:nil];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}
 
@end
