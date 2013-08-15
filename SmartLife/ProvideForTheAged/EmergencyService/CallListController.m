//
//  CallListController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CallListController.h"
#import "RescueController.h"
#import "CCallService.h"


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
     
    self.headerView.headerLabel.text = @"紧急服务－呼叫列表";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,self.containerView.height)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:myTableView];
    [myTableView release];
     
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
    self.arrCalls = [CCallService listEmergencyServiceWithMemberId:appSession.authId];
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
        int count  = [appSession.authNodeInfos count];
        __block int currentIndex = 1;
        [appSession.authNodeInfos each:^(id sender) {
            NSString *params = MF_SWF(@"/%d,%d",1,20);
            NSString *accessPoint = [((NSDictionary*)sender) objectForKey:@"AccessPoint"];
            NSString *url = JOIN(bizUrl(BIT_GetEmergencyServices,accessPoint), params);
            
            NSString *familyMemberId = [((NSDictionary*)sender) objectForKey:@"FamilyMemberId"];
            NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:familyMemberId,@"FamilyMemberId",nil];
            HttpAppRequest *req = buildReq2(head);
            [HttpAppAsynchronous httpGetWithUrl:url req:req sucessBlock:^(id result) {

                NSArray *records = [((HttpAppResponse*)result).rows map:^(id obj){
                    NSMutableDictionary *newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
                    [newObj setValue:appSession.authId forKey:@"BelongMemberId"];
                    [newObj setValue:familyMemberId forKey:@"BelongFamilyMemberId"];
                    [newObj setValue:[NSDate date] forKey:@"LocalSyncTime"];
                    [newObj setValue:NI(ST_EmergencyService) forKey:@"ServiceType"];
                    [newObj setValue:accessPoint forKey:@"AccessPoint"];
                    return newObj;
                }];
                [CCallService updateWithData:records By:appSession.authId type:ST_EmergencyService];
            } failedBlock:^(NSError *error) {
                DebugLog(@"%@",error);
            } completionBlock:^{
                if(count == currentIndex){
                    [self fetchDataLocal];
                    reloading = NO;
                    [refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
                    [self closeWaitView];
                }
                else{
                    currentIndex++;
                }
            }];
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
static NSString *aCell=@"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    CCallService *dataItem = (CCallService*)[arrCalls objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:aCell] autorelease];
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
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = dataItem.oldManName;
    ((UILabel*)[cell.contentView viewWithTag:1003]).text = [self getDescriptionFromDoStatus:dataItem.doStatus];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"didSelect %d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCallService *dataItem = (CCallService*)[arrCalls objectAtIndex:indexPath.row];
    [self navigationTo:[[[RescueController alloc] initWithCallService:dataItem] autorelease]];
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
