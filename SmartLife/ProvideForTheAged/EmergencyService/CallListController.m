//
//  CallListController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CallListController.h"
#import "RescueController.h"

@interface CallListController ()
@property (nonatomic, retain) NSArray      *arrCalls;
@property (nonatomic, retain) UITableView  *myTableView;

@end

@implementation CallListController
@synthesize myTableView;
@synthesize arrCalls;
- (void)dealloc {
    self.myTableView = nil;
    self.arrCalls = nil;
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
    
    self.arrCalls = [NSMutableArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 10:30:23",@"CallTime", @"李琴",@"Name",@"未处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 08:30:23",@"CallTime", @"李四",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-31 08:30:23",@"CallTime", @"张三",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-30 18:30:23",@"CallTime", @"李三",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-29 08:30:23",@"CallTime", @"李琴",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-28 08:30:23",@"CallTime", @"张四",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-27 08:30:23",@"CallTime", @"王二",@"Name",@"已处理",@"Status",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-26 08:30:23",@"CallTime", @"李琴",@"Name",@"已处理",@"Status",nil],
                     nil];
    
    self.headerView.headerLabel.text = @"紧急服务－呼叫列表";
    
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
    return [arrCalls count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.size.width, 52)] autorelease];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    tableHeaderView.tag = section + 3200;
     
      
    UILabel *headerCallTime = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 150, 52)];
    headerCallTime.textColor = MF_ColorFromRGB(58, 58, 57);
    headerCallTime.backgroundColor = [UIColor clearColor];
    headerCallTime.text = @"呼叫时间";
    headerCallTime.textAlignment = UITextAlignmentCenter;
    headerCallTime.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerCallTime];
    [headerCallTime release];
    
    UILabel *headerName = [[UILabel alloc] initWithFrame:CGRectMake(164, 0, 86, 52)];
    headerName.textColor = MF_ColorFromRGB(58, 58, 57);
    headerName.backgroundColor = [UIColor clearColor];
    headerName.text = @"老人姓名";
    headerName.textAlignment = UITextAlignmentCenter;
    headerName.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerName];
    [headerName release];
    
    UILabel *headerStatus = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 52)];
    headerStatus.textColor = MF_ColorFromRGB(58, 58, 57);
    headerStatus.backgroundColor = [UIColor clearColor];
    headerStatus.text = @"处理状态";
    headerStatus.textAlignment = UITextAlignmentCenter;
    headerStatus.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerStatus];
    [headerStatus release];
     
    
    return tableHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    NSDictionary *dataItem = (NSDictionary*)[arrCalls objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"acell"] autorelease];
        UILabel *valueCallTime = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 150, 45)];
        //valueCallTime.textColor = MF_ColorFromRGB(140, 137, 111);
        valueCallTime.backgroundColor = [UIColor clearColor];
        valueCallTime.font = [UIFont systemFontOfSize:14.0f];
        valueCallTime.tag = 1001;
        valueCallTime.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueCallTime];
        [valueCallTime release];
        
        UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(164, 0, 86, 45)];
        //valueName.textColor = MF_ColorFromRGB(140, 137, 111);
        valueName.backgroundColor = [UIColor clearColor];
        valueName.font = [UIFont systemFontOfSize:14.0f];
        valueName.tag = 1002;
        valueName.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueName];
        [valueName release];
        
        UILabel *valueStatus = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 45)];
        //valueStatus.textColor = MF_ColorFromRGB(140, 137, 111);
        valueStatus.backgroundColor = [UIColor clearColor];
        valueStatus.font = [UIFont systemFontOfSize:14.0f];
        valueStatus.tag = 1003;
        valueStatus.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueStatus];
        [valueStatus release];
    }
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = [dataItem objectForKey:@"CallTime"];
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = [dataItem objectForKey:@"Name"];
    ((UILabel*)[cell.contentView viewWithTag:1003]).text = [dataItem objectForKey:@"Status"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self navigationTo:[[[RescueController alloc] init] autorelease]];
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    return nil;
}

@end
