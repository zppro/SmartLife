//
//  CallListController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CallListController.h"
#import "RescueController.h"
#import "CServiceRecord.h"


@interface CallListController (){
    BOOL reloading;
}
@property (nonatomic, retain) NSArray      *arrCalls;
@property (nonatomic, retain) UITableView  *myTableView;
@property (nonatomic, retain) EGORefreshTableHeaderView  *refreshTableHeaderView;
@end

@implementation CallListController
@synthesize myTableView;
@synthesize refreshTableHeaderView;
@synthesize arrCalls;
- (void)dealloc {
    self.myTableView = nil;
    self.refreshTableHeaderView = nil;
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
    /*
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
    */
    
    self.headerView.headerLabel.text = @"紧急服务－呼叫列表";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,self.containerView.height)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:myTableView];
     
    refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - myTableView.height,self.containerView.width,myTableView.height)];
    refreshTableHeaderView.delegate = self;
    [myTableView addSubview:refreshTableHeaderView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self fetchData];
}

- (void)fetchDataLocal{
    self.arrCalls = [CServiceRecord listEmergencyServiceWithUserId:appSession.userId];
    [myTableView reloadData];
}

- (void)fetchData{
    [self showWaitViewWithTitle:@"读取紧急服务"];
    
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //本地登录
        [self fetchDataLocal];
        [self closeWaitView];
    }
    else{
        NSDictionary *postData = [NSDictionary dictionaryWithObjectsAndKeys:appSession.userId,@"UserId",nil];
        
        LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(ReadListOfEmergencyService) WithPostData:postData];
        
        
        [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
            DebugLog(@"message:%@",((LeblueResponse*)result).message);
            DebugLog(@"records:%@",((LeblueResponse*)result).records);
             
            NSArray *records = [((LeblueResponse*)result).records map:^(id obj){
                NSMutableDictionary *newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
                [newObj setValue:appSession.userId forKey:@"FetchByUserId"];
                [newObj setValue:[NSDate date] forKey:@"LocalSyncTime"];
                [newObj setValue:NI(EmergencyService) forKey:@"ServiceType"];
                 
                if([newObj objectForKey:@"AcceptStatus"]==nil){
                    [newObj setValue:NI(0) forKey:@"AcceptStatus"];
                }
                return newObj;
            }]; 
            [CServiceRecord updateWithData:records By:appSession.userId type:EmergencyService];
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            //
            [self fetchDataLocal]; 
            
            reloading = NO;
            [refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
            [self closeWaitView];
        }];
    }
}



- (NSString*) getDescriptionFromDoStatus:(id) doStatus{
    switch ([doStatus intValue]) {
        case 0:
            return @"未处理";
            break;
        case 1:
            return @"处理中";
            break;
        case 2:
            return @"处理完成";
            break;
        default:
            break;
    }
    
    return @"";
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
    CServiceRecord *dataItem = (CServiceRecord*)[arrCalls objectAtIndex:indexPath.row];
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
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = GetDateString(dataItem.checkInTime,@"yyyy-MM-dd HH:mm:ss");
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = dataItem.name;
    ((UILabel*)[cell.contentView viewWithTag:1003]).text = [self getDescriptionFromDoStatus:dataItem.doStatus];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CServiceRecord *dataItem = (CServiceRecord*)[arrCalls objectAtIndex:indexPath.row]; 
    [self navigationTo:[[[RescueController alloc] initWithServiceRecord:dataItem] autorelease]];
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    return nil;
}



#pragma mark - EGORefreshTableHeaderDelegate Methods
//开始刷新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    reloading = YES;
    [self fetchData];
}


- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
	return reloading; // should return if data source model is reloading
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

@end
