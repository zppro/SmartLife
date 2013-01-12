//
//  CommunityServiceCallingListController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CommunityServiceCallingListController.h"
#import "CommunityServiceAcceptOrderController.h"
#import "CommunityServiceAcceptOrderSuccessController.h"
#import "CommunityServiceAcceptOrderFailController.h"
#import "CServiceRecord.h"

@interface CommunityServiceCallingListController (){
    UIButton *currentSelectedButton;
    UITableView *currentTableView;
    BOOL isInReceivedView;
    BOOL reloading;
}

@property (nonatomic, retain) NSArray        *arrReceived;
@property (nonatomic, retain) NSArray        *arrNotReceived;
@property (nonatomic, retain) UITableView    *receivedTableView;
@property (nonatomic, retain) UITableView    *notReceivedTableView;
@property (nonatomic, retain) EGORefreshTableHeaderView     *receivedTableHeaderView;
@property (nonatomic, retain) EGORefreshTableHeaderView     *notReceivedTableHeaderView;

@end

@implementation CommunityServiceCallingListController 
@synthesize receivedTableView;
@synthesize notReceivedTableView;
@synthesize receivedTableHeaderView;
@synthesize notReceivedTableHeaderView;
@synthesize arrReceived;
@synthesize arrNotReceived;
- (void)dealloc { 
    self.receivedTableView = nil;
    self.notReceivedTableView = nil;
    self.receivedTableHeaderView = nil;
    self.notReceivedTableHeaderView = nil;
    self.arrReceived = nil;
    self.arrNotReceived = nil;
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
    self.arrReceived = [NSMutableArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 10:30:23",@"CallTime", @"李琴",@"Name",@"我要接单",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 08:30:23",@"CallTime", @"李四",@"Name",@"接单成功",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-31 08:30:23",@"CallTime", @"张三",@"Name",@"接单成功",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-30 18:30:23",@"CallTime", @"李三",@"Name",@"接单失败",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-29 08:30:23",@"CallTime", @"李琴",@"Name",@"接单成功",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-28 08:30:23",@"CallTime", @"张四",@"Name",@"接单成功",@"Status",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-27 08:30:23",@"CallTime", @"王二",@"Name",@"接单失败",@"Status",nil],
                              nil];
    
    self.arrNotReceived = [NSMutableArray arrayWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 10:30:23",@"CallTime", @"李琴",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-09-01 08:30:23",@"CallTime", @"李四",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-31 08:30:23",@"CallTime", @"张三",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-30 18:30:23",@"CallTime", @"李三",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-29 08:30:23",@"CallTime", @"李琴",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-28 08:30:23",@"CallTime", @"张四",@"Name",@"未接单",@"Status",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-08-27 08:30:23",@"CallTime", @"王二",@"Name",@"未接单",@"Status",nil],
                                nil];
    */
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = @"社区服务－呼叫列表";
    
    UIButton *receivedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [receivedButton setFrame:CGRectMake(0,0, 320/2.f, 77/2.f)];
    [receivedButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/1.png") forState:UIControlStateNormal];
    [receivedButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/1-01.png") forState:UIControlStateSelected];
    [receivedButton addTarget:self action:@selector(doToggle:) forControlEvents:UIControlEventTouchUpInside];
    [receivedButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:receivedButton];
    receivedButton.selected = NO;
    
    UIButton *notReceivedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [notReceivedButton setFrame:CGRectMake(320/2.0,0, 320/2.f, 77/2.f)];
    [notReceivedButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/2.png") forState:UIControlStateNormal];
    [notReceivedButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/2-01.png") forState:UIControlStateSelected];
    [notReceivedButton addTarget:self action:@selector(doToggle:) forControlEvents:UIControlEventTouchUpInside];
    [notReceivedButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:notReceivedButton];
    notReceivedButton.selected = NO;
    
    currentSelectedButton = receivedButton;
    currentSelectedButton.selected  = YES;
    
     
    receivedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 77/2.f, self.containerView.width,self.containerView.height-77.f/2.f)];
    receivedTableView.delegate = self;
    receivedTableView.dataSource = self;
    receivedTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:receivedTableView];
    
    notReceivedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 77/2.f, self.containerView.width,self.containerView.height-77.f/2.f)];
    notReceivedTableView.delegate = self;
    notReceivedTableView.dataSource = self;
    notReceivedTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:notReceivedTableView];
    
    currentTableView = receivedTableView;
    [currentTableView frontMe];
    
    isInReceivedView = YES;
     
    receivedTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - receivedTableView.height,self.containerView.width,receivedTableView.height)];
    receivedTableHeaderView.delegate = self;
    [receivedTableView addSubview:receivedTableHeaderView];
    
    notReceivedTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - notReceivedTableView.height,self.containerView.width,notReceivedTableView.height)];
    notReceivedTableHeaderView.delegate = self;
    [notReceivedTableView addSubview:notReceivedTableHeaderView];
    
	//  update the last update date
    if (isInReceivedView) {
        [self.receivedTableHeaderView refreshLastUpdatedDate];
    }
    else{
        [self.notReceivedTableHeaderView refreshLastUpdatedDate];
    }
    
    [self fetchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchDataLocal{
    self.arrNotReceived = [CServiceRecord listCommunityServiceNotReceivedWithUserId:appSession.userId];
    self.arrReceived = [CServiceRecord listCommunityServiceReceivedWithUserId:appSession.userId];
    [receivedTableView reloadData];
    [notReceivedTableView reloadData];
}

- (void)fetchData{
    [self showWaitViewWithTitle:@"读取社区服务"];
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //本地登录
        [self fetchDataLocal];
        [self closeWaitView];
    }
    else{
        NSDictionary *postData = [NSDictionary dictionaryWithObjectsAndKeys:appSession.userId,@"UserId",nil];
        
        LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(ReadListOfCommunityService) WithPostData:postData];
        
        
        [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
            DebugLog(@"message:%@",((LeblueResponse*)result).message);
            DebugLog(@"records:%@",((LeblueResponse*)result).records);
            
            NSArray *records = [((LeblueResponse*)result).records map:^(id obj){
                NSMutableDictionary *newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
                [newObj setValue:appSession.userId forKey:@"FetchByUserId"];
                [newObj setValue:[NSDate date] forKey:@"LocalSyncTime"];
                [newObj setValue:NI(CommunityService) forKey:@"ServiceType"];
                if([newObj objectForKey:@"AcceptStatus"]==nil){
                    [newObj setValue:NI(0) forKey:@"AcceptStatus"];
                }
                return newObj;
            }];
            [CServiceRecord updateWithData:records By:appSession.userId type:CommunityService];
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            //
            [self fetchDataLocal];
            
            reloading = NO;
            EGORefreshTableHeaderView *currentRefreshHeaderView = isInReceivedView?receivedTableHeaderView:notReceivedTableHeaderView;
            [currentRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:currentTableView];
            
            [self closeWaitView];
        }];
    } 
}

- (NSString*) getDescriptionFromAcceptStatus:(id) acceptStatus andDoStatus:(id) doStatus{
    if([acceptStatus intValue]==0){
        return @"我要接单";
    }
    else if([acceptStatus intValue]==2){
        return @"接单成功";
    }
    else{
        switch ([doStatus intValue]) {
            case 0:
                return @"未处理";
                break;
            case 1:
                return @"处理中";
                break;
            case 2:
                return @"接单失败";
                break;
            default:
                break;
        }
    }
    
    return @"";
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
    if(tableView ==  receivedTableView){
        return [arrReceived count];
    }
    else{
        return [arrNotReceived count];
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.size.width, 42)] autorelease];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    tableHeaderView.tag = section + 3200;
    
    
    UILabel *headerCallTime = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 150, 42)];
    headerCallTime.textColor = MF_ColorFromRGB(58, 58, 57);
    headerCallTime.backgroundColor = [UIColor clearColor];
    headerCallTime.text = @"呼叫时间";
    headerCallTime.textAlignment = UITextAlignmentCenter;
    headerCallTime.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerCallTime];
    [headerCallTime release];
    
    UILabel *headerName = [[UILabel alloc] initWithFrame:CGRectMake(164, 0, 86, 42)];
    headerName.textColor = MF_ColorFromRGB(58, 58, 57);
    headerName.backgroundColor = [UIColor clearColor];
    headerName.text = @"老人姓名";
    headerName.textAlignment = UITextAlignmentCenter;
    headerName.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerName];
    [headerName release];
    
    UILabel *headerStatus = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 42)];
    headerStatus.textColor = MF_ColorFromRGB(58, 58, 57);
    headerStatus.backgroundColor = [UIColor clearColor];
    headerStatus.text = @"状态";
    headerStatus.textAlignment = UITextAlignmentCenter;
    headerStatus.font = [UIFont systemFontOfSize:14.0f];
    [tableHeaderView addSubview:headerStatus];
    [headerStatus release];
    
    
    return tableHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95/2.f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 84/2.f;
}

static NSString * cellKey1 = @"acell";
static NSString * cellKey2 = @"bcell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView == receivedTableView?cellKey1:cellKey2];
    NSArray *arrData = tableView == receivedTableView?arrReceived:arrNotReceived;
    CServiceRecord *dataItem = (CServiceRecord*)[arrData objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:tableView == receivedTableView?cellKey1:cellKey2] autorelease];
        UILabel *valueCallTime = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 150, 95/2.f)];
        //valueCallTime.textColor = MF_ColorFromRGB(140, 137, 111);
        valueCallTime.backgroundColor = [UIColor clearColor];
        valueCallTime.font = [UIFont systemFontOfSize:14.0f];
        valueCallTime.tag = 1001;
        valueCallTime.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueCallTime];
        [valueCallTime release];
        
        UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(164, 0, 86, 95/2.f)];
        //valueName.textColor = MF_ColorFromRGB(140, 137, 111);
        valueName.backgroundColor = [UIColor clearColor];
        valueName.font = [UIFont systemFontOfSize:14.0f];
        valueName.tag = 1002;
        valueName.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueName];
        [valueName release];
        
        UILabel *valueStatus = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 95/2.f)];
        //valueStatus.textColor = MF_ColorFromRGB(140, 137, 111);
        valueStatus.backgroundColor = [UIColor clearColor];
        valueStatus.font = [UIFont systemFontOfSize:14.0f];
        valueStatus.tag = 1003;
        valueStatus.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueStatus];
        [valueStatus release];

        UIButton *acceptOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        acceptOrder.tag = 1004;
        acceptOrder.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [acceptOrder setFrame:CGRectMake(250,(95/2.f - 48/2.f)/2.f,66, 48/2.f)];
        [acceptOrder setBackgroundColor:MF_ColorFromRGB(251, 149, 18)];
        [acceptOrder setTitle:@"我要接单" forState:UIControlStateNormal];
        [acceptOrder addTarget:self action:@selector(doAcceptOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:acceptOrder];
        acceptOrder.hidden = YES;
    } 
     
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = GetDateString(dataItem.checkInTime,@"yyyy-MM-dd HH:mm:ss");
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = dataItem.name;
    ((UILabel*)[cell.contentView viewWithTag:1003]).text = [self getDescriptionFromAcceptStatus:dataItem.acceptStatus andDoStatus:dataItem.doStatus];
    ((UIButton*)[cell.contentView viewWithTag:1004]).hidden = ![((UILabel*)[cell.contentView viewWithTag:1003]).text isEqualToString:@"我要接单"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arrData = tableView == receivedTableView?arrReceived:arrNotReceived;
    CServiceRecord *dataItem = (CServiceRecord*)[arrData objectAtIndex:indexPath.row];
    NSString *statusString = [self getDescriptionFromAcceptStatus:dataItem.acceptStatus andDoStatus:dataItem.doStatus];
    if([statusString isEqualToString:@"我要接单"]){ 
        return;
    }
    else if([statusString isEqualToString:@"接单成功"]){ 
        CommunityServiceAcceptOrderSuccessController *communityServiceAcceptOrderSuccessVC = [[CommunityServiceAcceptOrderSuccessController alloc] initWithServiceRecord:dataItem];
        [self presentModalViewController:communityServiceAcceptOrderSuccessVC animated: YES];
    }
    else if([statusString isEqualToString:@"接单失败"]){
        CommunityServiceAcceptOrderFailController *communityServiceAcceptOrderFailVC = [[CommunityServiceAcceptOrderFailController alloc] init];
        [self presentModalViewController:communityServiceAcceptOrderFailVC animated: YES]; 
    }
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
    if(isInReceivedView){
        [self.receivedTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    else{
        [self.notReceivedTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(isInReceivedView){
        [self.receivedTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    else{
        [self.notReceivedTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -Button Click
- (void)doAcceptOrder:(id)sender{
    //DebugLog(@"doAcceptOrder 接单");
    //结单必定在未结单列表里
    UITableViewCell* cell = (UITableViewCell*)[[(UIButton*)sender superview] superview];
    int row = [notReceivedTableView indexPathForCell:cell].row;
    NSArray *arrData = arrNotReceived;
    CServiceRecord *dataItem = (CServiceRecord*)[arrData objectAtIndex:row];
    
    CommunityServiceAcceptOrderController *communityServiceAcceptOrderVC = [[CommunityServiceAcceptOrderController alloc] initWithServiceRecord:dataItem];
    [self presentModalViewController:communityServiceAcceptOrderVC animated: YES];
}
- (void)doToggle:(id)sender {
    if(currentSelectedButton == sender){
        return;
    }
    currentSelectedButton.selected = !currentSelectedButton.selected;
    currentSelectedButton = sender;
    currentSelectedButton.selected = !currentSelectedButton.selected;
    isInReceivedView = !isInReceivedView;

    if (isInReceivedView) {
        currentTableView = receivedTableView;
    }
    else{
        currentTableView = notReceivedTableView;
    }
    [currentTableView frontMe];
} 
@end
