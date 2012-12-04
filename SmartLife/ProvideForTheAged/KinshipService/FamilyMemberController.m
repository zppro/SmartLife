//
//  FamilyMemberController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "FamilyMemberController.h"
#import "ContactDetailController.h"

@interface FamilyMemberController ()
@property (nonatomic, retain) NSArray  *arrFamilyMembers;
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation FamilyMemberController
@synthesize arrFamilyMembers;
@synthesize myTableView;

- (void)dealloc {
    self.myTableView = nil;
    self.arrFamilyMembers = nil;
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
    self.arrFamilyMembers = [NSMutableArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"老爸",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"老妈",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"姑姑",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"姑夫",@"Name",@"1",@"LandPhone",@"",@"VOIP",@"",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"大阿姨",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"大姨父",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"小阿姨",@"Name",@"",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"小姨父",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"社区医生",@"Name",@"1",@"LandPhone",@"1",@"VOIP",@"1",@"NetworkIntercom",nil],
                            nil];
    
    self.headerView.headerLabel.text = @"亲情服务";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,self.containerView.height)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:myTableView];
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

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrFamilyMembers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93/2.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    NSDictionary *dataItem = (NSDictionary*)[arrFamilyMembers objectAtIndex:indexPath.row];
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
        landPhoneButton.tag = 1002;
        [cell.contentView addSubview:landPhoneButton];
        
        UIButton *voipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [voipButton setFrame:CGRectMake(392/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [voipButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/VOIP.png") forState:UIControlStateNormal];
        [voipButton addTarget:self action:@selector(doVOIP:) forControlEvents:UIControlEventTouchUpInside];
        [voipButton setBackgroundColor:[UIColor clearColor]];
        voipButton.tag = 1003;
        [cell.contentView addSubview:voipButton];
        
        UIButton *networkIntercomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [networkIntercomButton setFrame:CGRectMake(514/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [networkIntercomButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/NetworkIntercom.png") forState:UIControlStateNormal];
        [networkIntercomButton addTarget:self action:@selector(doNetworkIntercom:) forControlEvents:UIControlEventTouchUpInside];
        [networkIntercomButton setBackgroundColor:[UIColor clearColor]];
        networkIntercomButton.tag = 1004;
        [cell.contentView addSubview:networkIntercomButton];
    }
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = [dataItem objectForKey:@"Name"];
    ((UIButton*)[cell.contentView viewWithTag:1002]).hidden = [[dataItem objectForKey:@"LandPhone"] isEqualToString:@""];
    ((UIButton*)[cell.contentView viewWithTag:1003]).hidden = [[dataItem objectForKey:@"VOIP"] isEqualToString:@""];
    ((UIButton*)[cell.contentView viewWithTag:1004]).hidden = [[dataItem objectForKey:@"NetworkIntercom"] isEqualToString:@""];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataItem = (NSDictionary*)[arrFamilyMembers objectAtIndex:indexPath.row];
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
