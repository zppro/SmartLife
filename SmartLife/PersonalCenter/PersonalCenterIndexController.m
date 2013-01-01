//
//  PersonalCenterIndexController.m
//  SmartLife
//
//  Created by zppro on 13-1-1.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "PersonalCenterIndexController.h"

@interface PersonalCenterIndexController ()

@end

@implementation PersonalCenterIndexController

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
    self.headerView.headerLabel.text = @"个人中心";
    
    UIButton *btnAccountManage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAccountManage setFrame:CGRectMake((640/2.f-548/2.f)/2.f,40/2.f,548/2.f, 82/2.f)];
    //[btnAccountManage setTitle:@"账号管理" forState:UIControlStateNormal];
    [btnAccountManage setEnabled:FALSE];
    [btnAccountManage setBackgroundImage:MF_PngOfDefaultSkin(@"PersonalCenter/b01.png") forState:UIControlStateNormal];
    [btnAccountManage addTarget:self action:@selector(doAccountManageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btnAccountManage];
    
    UIButton *btnAccountSecurity = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAccountSecurity setFrame:CGRectMake((640/2.f-548/2.f)/2.f,40/2.f+82/2.f+40/2.f,548/2.f, 82/2.f)];
    //[btnAccountSecurity setTitle:@"账号安全" forState:UIControlStateNormal];
    [btnAccountSecurity setEnabled:FALSE];
    [btnAccountSecurity setBackgroundImage:MF_PngOfDefaultSkin(@"PersonalCenter/b02.png") forState:UIControlStateNormal];
    [btnAccountSecurity addTarget:self action:@selector(doAccountSecurityClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btnAccountSecurity];
    
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setFrame:CGRectMake((640/2.f-548/2.f)/2.f,40/2.f+82/2.f+40/2.f+82/2.f+40/2.f,548/2.f, 82/2.f)];
    //[btnLogout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [btnLogout setBackgroundImage:MF_PngOfDefaultSkin(@"PersonalCenter/b03.png") forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(doLogoutClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btnLogout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark - button click
- (void)doAccountManageClick:(id)sender{
    
}

- (void)doAccountSecurityClick:(id)sender{
    
}

- (void)doLogoutClick:(id)sender{
    [appSession abandon];
    [self navigationToRoot];
}
@end
