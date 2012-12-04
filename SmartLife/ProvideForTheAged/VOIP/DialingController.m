//
//  DialingController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "DialingController.h"

@interface DialingController ()

@end

@implementation DialingController

- (void)dealloc { 
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"拨号键盘";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = @"拨号键盘";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
