//
//  HomeController.m
//  SmartLife
//
//  Created by zppro on 12-11-20.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
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
    
    BOOL isSignIn = FALSE;
    if(!isSignIn){ 
        LoginController *loginController = [[LoginController alloc] init];
        [self presentModalViewController:loginController animated: YES];
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
            
            
             break;
        }
        case 2: { 
            [self navigationTo:[[[ProvideForTheAgedIndexController alloc] init] autorelease]];
            break;
        }
        case 3:{
            break;
        }
        case 4:
        case 5:{
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
@end
