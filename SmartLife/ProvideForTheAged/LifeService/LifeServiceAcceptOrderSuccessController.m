//
//  LifeServiceAcceptOrderSuccessController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "LifeServiceAcceptOrderSuccessController.h"
#import "LifeServiceAcceptOrderProcessController.h"

@interface LifeServiceAcceptOrderSuccessController ()
@property (nonatomic, retain) NSDictionary  *orderInfo;
@end

@implementation LifeServiceAcceptOrderSuccessController
- (void)dealloc {
    self.orderInfo = nil;
    [super dealloc];
}

-(id)initWithOrderInfo:(NSDictionary*)orderInfo {
    self = [super init];
    if (self)
    {
        self.orderInfo = orderInfo;
    }
    return self;
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
    self.headerView.headerLabel.text = @"生活服务－任务受理";
    self.headerView.delegate = self;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30/2.f, 58/2.f, 290, 5*48/2.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.numberOfLines = 5;
    titleLabel.text = @"    您好:\n    感谢您对智慧生活服务平台的支持，感谢您对社区老人的关怀之心。经过我们的综合考虑将帮助此任务交予给您。祝您工作愉快！";
    [self.containerView addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 372/2.f, 285, 48/2.f)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:16.0f];
    nameLabel.textAlignment = UITextAlignmentLeft;
    nameLabel.text = MF_SWF(@"老人姓名:%@",[self.orderInfo objectForKey:@"Name"]);
    [self.containerView addSubview:nameLabel];
    [nameLabel release];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 420/2.f, 285, 48/2.f)];
    sexLabel.backgroundColor = [UIColor clearColor];
    sexLabel.font = [UIFont systemFontOfSize:16.0f];
    sexLabel.textAlignment = UITextAlignmentLeft;
    sexLabel.text = MF_SWF(@"性别:%@",[self.orderInfo objectForKey:@"Sex"]);
    [self.containerView addSubview:sexLabel];
    [sexLabel release];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 468/2.f, 285, 3*48/2.f)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = [UIFont systemFontOfSize:16.0f];
    addressLabel.textAlignment = UITextAlignmentLeft;
    addressLabel.text = MF_SWF(@"地址:%@",[self.orderInfo objectForKey:@"Address"]);
    addressLabel.numberOfLines = 3;
    [self.containerView addSubview:addressLabel];
    [addressLabel release];
    [addressLabel sizeToFit];
    
    UILabel *serveContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 612/2.f, 285, 48/2.f)];
    serveContentLabel.backgroundColor = [UIColor clearColor];
    serveContentLabel.font = [UIFont systemFontOfSize:16.0f];
    serveContentLabel.textAlignment = UITextAlignmentLeft;
    serveContentLabel.text = MF_SWF(@"服务内容:%@",[self.orderInfo objectForKey:@"ServeContent"]);
    [self.containerView addSubview:serveContentLabel];
    [serveContentLabel release];
    
    UILabel *serveModeLabel = [[UILabel alloc] initWithFrame:CGRectMake(34/2.f, 660/2.f, 285, 48/2.f)];
    serveModeLabel.backgroundColor = [UIColor clearColor];
    serveModeLabel.font = [UIFont systemFontOfSize:16.0f];
    serveModeLabel.textAlignment = UITextAlignmentLeft;
    serveModeLabel.text = MF_SWF(@"服务方式:%@",[self.orderInfo objectForKey:@"ServeMode"]);
    [self.containerView addSubview:serveModeLabel];
    [serveModeLabel release];
    
    UIButton *callAgedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callAgedButton setFrame:CGRectMake(11.5/2.f,(self.footerView.height - 61.f/2.f)/2.f, 198/2.f, 61/2.f)];
    [callAgedButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/B1.png") forState:UIControlStateNormal];
    [callAgedButton addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
    [callAgedButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:callAgedButton];
    
    UIButton *callSeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callSeatButton setFrame:CGRectMake(198/2.f+11.5,(self.footerView.height - 61.f/2.f)/2.f, 198/2.f, 61/2.f)];
    [callSeatButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/B4.png") forState:UIControlStateNormal];
    [callSeatButton addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
    [callSeatButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:callSeatButton];
    
    UIButton *processButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [processButton setFrame:CGRectMake(198+11.5/2.f+11.5,(self.footerView.height - 61.f/2.f)/2.f, 198/2.f, 61/2.f)];
    [processButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/B3.png") forState:UIControlStateNormal];
    [processButton addTarget:self action:@selector(doProcess:) forControlEvents:UIControlEventTouchUpInside];
    [processButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:processButton];
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
- (void)doCall:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)doProcess:(id)sender{ 
    LifeServiceAcceptOrderProcessController *lifeServiceAcceptOrderProcessVC = [[LifeServiceAcceptOrderProcessController alloc] init];
    [self presentModalViewController:lifeServiceAcceptOrderProcessVC animated: YES];
}

@end
