//
//  ContactDetailController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "ContactDetailController.h"

@interface ContactDetailController ()

@property (nonatomic, retain) NSDictionary  *contactInfo;

@end

@implementation ContactDetailController
@synthesize contactInfo;

- (void)dealloc {
    self.contactInfo = nil;
    [super dealloc];
}

-(id)initWithContactInfo:(NSDictionary*)dictContact {
    self = [super init];
    if (self) 
    { 
        self.contactInfo = dictContact;
    }  
    return self;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.headerView.headerLabel.text = [contactInfo objectForKey:@"Name"];
    
    UIImageView *profileImage = makeImageView((320.0-159/2.f)/2.f, 30.f, 159/2.f, 157/2.f);
    profileImage.image = MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/ProfileDefault.png");
    [self.containerView addSubview:profileImage];
    
    UIButton *landPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [landPhoneButton setFrame:CGRectMake((320.0 - 107.f/2.f)/2.0,250/2.f, 107/2.f, 38/2.f)];
    [landPhoneButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/LandPhone.png") forState:UIControlStateNormal];
    [landPhoneButton addTarget:self action:@selector(doLandPhone:) forControlEvents:UIControlEventTouchUpInside];
    [landPhoneButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:landPhoneButton];
    
    UIButton *voipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voipButton setFrame:CGRectMake((320.0 - 107.f/2.f)/2.0,318/2.f, 107/2.f, 38/2.f)];
    [voipButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/VOIP.png") forState:UIControlStateNormal];
    [voipButton addTarget:self action:@selector(doVOIP:) forControlEvents:UIControlEventTouchUpInside];
    [voipButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:voipButton];
    
    UIButton *networkIntercomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [networkIntercomButton setFrame:CGRectMake((320.0 - 107.f/2.f)/2.0,386/2.f, 107/2.f, 38/2.f)];
    [networkIntercomButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/NetworkIntercom.png") forState:UIControlStateNormal];
    [networkIntercomButton addTarget:self action:@selector(doNetworkIntercom:) forControlEvents:UIControlEventTouchUpInside];
    [networkIntercomButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:networkIntercomButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark 按钮事件
- (void) doLandPhone:(id) sender{
    
}

- (void) doVOIP:(id) sender{
    
}

- (void) doNetworkIntercom:(id) sender{
    
}
@end
