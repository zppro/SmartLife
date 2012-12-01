//
//  AppBaseController.m
//  iWedding
//
//  Created by 钟 平 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppBaseController.h"

@interface AppBaseController ()
@property (nonatomic, retain) UIImageView* leftImage;
@end

@implementation AppBaseController
@synthesize containerView = _containerView;
@synthesize leftImage = _leftImage;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
- (void)dealloc {
    [_containerView release];
    [_leftImage release];
    [_headerView release];
    [_footerView release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = MF_ColorFromRGB(236, 236, 236);
    
    UIImage *backgroundImageOfHeader = [self getHeaderBackgroundImage];
    UIImage *backButtonImage = MF_PngOfDefaultSkin(@"Index/button.png");
    if(backgroundImageOfHeader != nil){
        _headerView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 87.0/2.f) andBackButtonImage:backButtonImage andTitleBGImage:backgroundImageOfHeader];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 87.0/2.f, 320, (920-87.0)/2.f)];
    _containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_containerView];
    
    self.waitView = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    [self.waitView setFrame:CGRectMake(0, 0, 320, 920)];
    self.waitView.delegate = self;
     
    
    UIImage *backgroundImageOfFooter = [self getFooterBackgroundImage];
    if(backgroundImageOfFooter != nil){
        _footerView = makeView(0, (920-89.0)/2.f, 320,89.f/2.f);
        [self.view addSubview:_footerView];
        UIImageView *bgFooter = makeImageView(0, 0, _footerView.width, _footerView.height);
        bgFooter.image = backgroundImageOfFooter;
        [_footerView addSubview:bgFooter];
    }
}

#pragma mark 子类重写方法
- (UIImage*) getHeaderBackgroundImage{
    return MF_PngOfDefaultSkin(@"Index/title_bg_1.png");
}

- (UIImage*) getFooterBackgroundImage{
    return MF_PngOfDefaultSkin(@"Index/title_bg_1.png");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // setting navigation bar hidden
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return FALSE;
}

@end
