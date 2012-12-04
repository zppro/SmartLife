//
//  SmartPhoneController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "SmartPhoneController.h"
#import "ContactDetailController.h"

@interface SmartPhoneController ()
@property (nonatomic, retain) NSArray  *arrSmartPhoneNO;
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation SmartPhoneController
@synthesize arrSmartPhoneNO;
@synthesize myTableView;

- (void)dealloc {
    self.myTableView = nil;
    self.arrSmartPhoneNO = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"智慧电话";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.arrSmartPhoneNO = [NSMutableArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"王小美",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈昌达",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"董智勇",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方浩",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"范婷婷",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"丁鹏",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方小雪",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈静",@"Name",nil],
                            nil];
    
    self.headerView.headerLabel.text = @"智慧电话";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,self.containerView.height)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:myTableView];
    
	// Do any additional setup after loading the view.
    /*
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:2];
    [item setFinishedSelectedImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/01S.png")
       withFinishedUnselectedImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/01.png")];
    self.tabBarItem = item;
    [item release];
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrSmartPhoneNO count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93/2.f;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"]; 
    NSDictionary *dataItem = (NSDictionary*)[arrSmartPhoneNO objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"acell"] autorelease]; 
        
        UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 120, 93/2.f)];
        valueName.backgroundColor = [UIColor clearColor];
        valueName.font = [UIFont systemFontOfSize:14.0f];
        valueName.tag = 1001;
        valueName.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:valueName];
        [valueName release];
        
        UIButton *landPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [landPhoneButton setFrame:CGRectMake(270/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [landPhoneButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/LandPhone.png") forState:UIControlStateNormal];
        [landPhoneButton addTarget:self action:@selector(doLandPhone:) forControlEvents:UIControlEventTouchUpInside];
        [landPhoneButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:landPhoneButton];
        
        UIButton *voipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [voipButton setFrame:CGRectMake(392/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [voipButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/VOIP.png") forState:UIControlStateNormal];
        [voipButton addTarget:self action:@selector(doVOIP:) forControlEvents:UIControlEventTouchUpInside];
        [voipButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:voipButton];
        
        UIButton *networkIntercomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [networkIntercomButton setFrame:CGRectMake(514/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [networkIntercomButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/NetworkIntercom.png") forState:UIControlStateNormal];
        [networkIntercomButton addTarget:self action:@selector(doNetworkIntercom:) forControlEvents:UIControlEventTouchUpInside];
        [networkIntercomButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:networkIntercomButton];
    } 
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = [dataItem objectForKey:@"Name"]; 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataItem = (NSDictionary*)[arrSmartPhoneNO objectAtIndex:indexPath.row];
    [self navigationTo:[[[ContactDetailController alloc] initWithContactInfo:dataItem] autorelease]];
}

#pragma mark 按钮事件
- (void) doLandPhone:(id) sender{
    
}

- (void) doVOIP:(id) sender{
    
}

- (void) doNetworkIntercom:(id) sender{
    
}
@end
