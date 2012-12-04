//
//  RecentCallController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "RecentCallController.h"
#import "ContactDetailController.h"

@interface RecentCallController ()
@property (nonatomic, retain) NSArray  *arrRecentCalls;
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation RecentCallController
@synthesize arrRecentCalls;
@synthesize myTableView;

- (void)dealloc {
    self.myTableView = nil;
    self.arrRecentCalls = nil;
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
    
    self.arrRecentCalls = [NSMutableArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:@"王小美",@"Name",@"昨天",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈昌达",@"Name",@"昨天",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"董智勇",@"Name",@"12-11-12",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方浩",@"Name",@"12-11-12",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"范婷婷",@"Name",@"12-11-11",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"丁鹏",@"Name",@"12-11-11",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方小雪",@"Name",@"12-11-10",@"Time",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈静",@"Name",@"12-11-10",@"Time",nil],
                            nil];
    
    self.headerView.headerLabel.text = @"最近通话";
    
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


#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrRecentCalls count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93/2.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    NSDictionary *dataItem = (NSDictionary*)[arrRecentCalls objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"acell"] autorelease];
        
        UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 180, 93/2.f)];
        valueName.backgroundColor = [UIColor clearColor];
        valueName.font = [UIFont systemFontOfSize:14.0f];
        valueName.tag = 1001;
        valueName.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:valueName];
        [valueName release];
        
        UILabel *valueTime = [[UILabel alloc] initWithFrame:CGRectMake(215, 0, 105, 93/2.f)];
        valueTime.backgroundColor = [UIColor clearColor];
        valueTime.font = [UIFont systemFontOfSize:12.0f];
        valueTime.tag = 1002;
        valueTime.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:valueTime];
        [valueTime release];
    }
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = [dataItem objectForKey:@"Name"];
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = [dataItem objectForKey:@"Time"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 按钮事件
- (void) doLandPhone:(id) sender{
    
}

- (void) doVOIP:(id) sender{
    
}

- (void) doNetworkIntercom:(id) sender{
    
}
@end
