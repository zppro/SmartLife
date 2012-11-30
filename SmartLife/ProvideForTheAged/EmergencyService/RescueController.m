//
//  RescueController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "RescueController.h"

@interface RescueController ()

@end

@implementation RescueController


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
    self.headerView.headerLabel.text = @"紧急服务－李琴需要救助";
    
    UIView *cameraView = [[UIView alloc] initWithFrame:CGRectMake(60.f, 3.5f, 200.f, 150.f)];
    cameraView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:cameraView];
    [cameraView release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
