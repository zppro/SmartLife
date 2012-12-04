//
//  LifeServiceAcceptOrderController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "LifeServiceAcceptOrderController.h"

@interface LifeServiceAcceptOrderController ()
@property (nonatomic, retain) NSDictionary  *orderInfo;
@end

@implementation LifeServiceAcceptOrderController
@synthesize orderInfo;
- (void)dealloc {
    self.orderInfo = nil;
    [super dealloc];
}


-(id)initWithOrderInfo:(NSDictionary*)aOrderInfo {
    self = [super init];
    if (self)
    {
        self.orderInfo = aOrderInfo;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = @"生活服务－任务派单";
    self.headerView.delegate = self;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 67/2.f, 285, 48/2.f)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:16.0f];
    nameLabel.textAlignment = UITextAlignmentLeft;
    nameLabel.text = MF_SWF(@"老人姓名:%@",[self.orderInfo objectForKey:@"Name"]);
    [self.containerView addSubview:nameLabel];
    [nameLabel release];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 110/2.f, 285, 3*48/2.f)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = [UIFont systemFontOfSize:16.0f];
    addressLabel.textAlignment = UITextAlignmentLeft;
    addressLabel.text = MF_SWF(@"地址:%@",[self.orderInfo objectForKey:@"Address"]);
    addressLabel.numberOfLines = 3;
    [self.containerView addSubview:addressLabel];
    [addressLabel release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 260/2.f, 285, 48/2.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.text = @"服务内容";
    [self.containerView addSubview:titleLabel];
    [titleLabel release];
    
    UIImageView *bgBox = makeImageView(34/2.f, 350/2.f, 570/2.f, 350/2.f);
    bgBox.image = MF_PngOfDefaultSkin(@"ProvideForTheAged/xiankuang.png");
    bgBox.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:bgBox];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10/2.f, 10/2.f, 285, 350/2.f)];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = [UIFont systemFontOfSize:16.0f];
    descriptionLabel.textAlignment = UITextAlignmentLeft;
    descriptionLabel.text = @"打扫卫生";
    descriptionLabel.numberOfLines = 7;
    [bgBox addSubview:descriptionLabel];
    [descriptionLabel release];
    [descriptionLabel sizeToFit];
    
    UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [acceptButton setFrame:CGRectMake((self.footerView.width-589/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 589/2.f, 61/2.f)];
    [acceptButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/11.png") forState:UIControlStateNormal];
    [acceptButton addTarget:self action:@selector(doAccept:) forControlEvents:UIControlEventTouchUpInside];
    [acceptButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:acceptButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableHeaderDelegate
- (void)backButtonOnClickWithPOPVC {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -Button click
- (void)doAccept:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
