//
//  CommunityServiceAcceptOrderFailController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CommunityServiceAcceptOrderFailController.h"

@interface CommunityServiceAcceptOrderFailController ()

@end

@implementation CommunityServiceAcceptOrderFailController
- (void)dealloc { 
    [super dealloc];
}
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
    
    self.headerView.headerLabel.text = @"社区服务－接单失败";
    self.headerView.delegate = self;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30/2.f, 58/2.f, 290, 5*48/2.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.numberOfLines = 5;
    titleLabel.text = @"    您好:\n    感谢您对智慧生活服务平台的支持，感谢您对社区老人的关怀之心。经过我们的综合考虑，我们已经将任务交予给别家公司，希望我们有下此合作机会。";
    [self.containerView addSubview:titleLabel];
    [titleLabel release];
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

#pragma mark -TableHeaderDelegate
- (void)backButtonOnClickWithPOPVC {
    [self dismissModalViewControllerAnimated:YES];
}
@end
