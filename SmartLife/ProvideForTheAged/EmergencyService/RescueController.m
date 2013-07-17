//
//  RescueController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "RescueController.h"
#import "CCallService.h"
#import "CServiceLog.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
 

@interface RescueController (){
    BOOL reloading;
    ZPUIActionSheet *callSheet;
    UIView *maskView;
    CGPoint defaultFooterViewCenter;
    MBProgressHUD *HUD;
    
    
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    BOOL isUploading;
    BOOL isPlaying;
    BOOL isResponsed;
}
@property (nonatomic, retain) CCallService *callService;  
@property (nonatomic, retain) UILabel        *titleProcessLabel;
@property (nonatomic, retain) UITableView    *logTableView;
@property (nonatomic, retain) EGORefreshTableHeaderView     *logTableHeaderView;
@property (nonatomic, retain) UIButton *responseButton;
@property (nonatomic, retain) UIButton *callButton;
@end

@implementation RescueController
@synthesize callService;  
@synthesize titleProcessLabel;
@synthesize logTableView; 
@synthesize logTableHeaderView;
@synthesize responseButton;
@synthesize callButton;
@synthesize arrLogs;  

- (void)dealloc {
    self.callService = nil;  
    self.titleProcessLabel = nil;
    self.logTableView = nil; 
    self.logTableHeaderView = nil;
    self.responseButton = nil;
    self.callButton = nil;
    self.arrLogs = nil;

    [super dealloc];
}

-(id)initWithCallService:(CCallService*)aCallService{
    self = [super init];
    if (self)
    {
        self.callService = aCallService;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    self.arrProcessActions = [NSMutableArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:30:01",@"ActionTime", @"120已接通",@"Description",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"社区医生已接通",@"Description",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"老人大儿子已接通",@"Description",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"老人小儿子已接通",@"Description",nil],
                     nil];

    self.arrProcessResponses = [NSMutableArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:33:20",@"ResponseTime", @"社区医生预计5分钟后到",@"ResponseContent",@"text",@"ResponseType",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:34:01",@"ResponseTime", @"老人小女儿已响应",@"ResponseContent",@"text",@"ResponseType",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:35:01",@"ResponseTime", @"01.mp3",@"ResponseContent",@"audio",@"ResponseType",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:35:10",@"ResponseTime", @"02.mp3",@"ResponseContent",@"audio",@"ResponseType",nil],
                              nil];
    */
    
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = callService.content;
    
    UIView *cameraContainerView = [[UIView alloc] initWithFrame:CGRectMake(60.f, 3.5f, 200.f, 150.f)];
    cameraContainerView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:cameraContainerView];
    [cameraContainerView release];
    
    UIImageView *cameraView = makeImageView(0, 0, cameraContainerView.width, cameraContainerView.height);
    cameraView.image = MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/01.png");
    [cameraContainerView addSubview:cameraView];
    
    titleProcessLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, cameraContainerView.top+cameraContainerView.height+10.f, 200.f, 30.f)];
    titleProcessLabel.backgroundColor = [UIColor clearColor];
    titleProcessLabel.textAlignment = UITextAlignmentLeft;
    titleProcessLabel.text = @"应急处理";
    titleProcessLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];//[UIFont systemFontOfSize:16];//
    [self.containerView addSubview:titleProcessLabel];
    [titleProcessLabel release];
     
    logTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, cameraContainerView.top+cameraContainerView.height+40.f, self.containerView.width, 160.f)];
    logTableView.delegate = self;
    logTableView.dataSource = self;
    logTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:logTableView]; 
    [logTableView release];
    
    isResponsed = [callService.responseFlag boolValue];
    
    responseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [responseButton setFrame:CGRectMake((self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
    [responseButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/05.png") forState:UIControlStateNormal];
    [responseButton addTarget:self action:@selector(doResponse:) forControlEvents:UIControlEventTouchUpInside];
    [responseButton setBackgroundColor:[UIColor clearColor]];
    [responseButton setEnabled: (([callService.doStatus intValue] != 2) && !isResponsed)];
    [self.footerView addSubview:responseButton];
    
    callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton setFrame:CGRectMake(self.footerView.width/2.f+(self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
    [callButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/06.png") forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setBackgroundColor:[UIColor clearColor]];
    [callButton setEnabled:(([callService.doStatus intValue] != 2) && isResponsed)];
    [self.footerView addSubview:callButton];
      
    logTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - logTableView.height,self.containerView.width,logTableView.height)];
    logTableHeaderView.delegate = self;
    [logTableView addSubview:logTableHeaderView];
    [logTableHeaderView release];
    [self.logTableHeaderView refreshLastUpdatedDate];
	//  update the last update date
         
    [self fetchData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fetchCamera];
    });
    
    isRecording = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    if (!isResponsed) {
        return [super getFooterBackgroundImage];
    }
    else{
        CGSize size = CGSizeMake(320,89.f/2.f);
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        //CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // image drawing code here
        
        UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return coloredImage;
    }
}

#pragma mark - 数据处理 
- (void) fetchCamera{
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //无网络
    }
    else{
        
    }
} 

- (void)fetchDataLocal{
    self.arrLogs = [CServiceLog listByService:callService.callServiceId];
    [logTableView reloadData];
}

- (void)fetchData{
    [self showWaitViewWithTitle:@"读取求助信息处理日志"];
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //本地登录
        [self fetchDataLocal];
        [self closeWaitView];
    }
    else{
        
        NSString *url = JOIN2(bizUrl(BIT_GetServiceLogs,callService.accessPoint),@"/",callService.callServiceId);
        NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:callService.belongFamilyMemberId,@"FamilyMemberId",nil];
        HttpAppRequest *req = buildReq2(head);
        [HttpAppAsynchronous httpGetWithUrl:url req:req sucessBlock:^(id result) {
            
            NSArray *records = [((HttpAppResponse*)result).rows map:^(id obj){
                NSMutableDictionary *newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
                [newObj setValue:appSession.authId forKey:@"BelongMemberId"];
                [newObj setValue:appSession.authId forKey:@"BelongFamilyMemberId"];
                [newObj setValue:[NSDate date] forKey:@"LocalSyncTime"];
                [newObj setValue:NI(1) forKey:@"LocalSyncFlag"]; 
                
                return newObj;
            }];
            [CServiceLog updateWithData:records ByService:callService.callServiceId];
        } failedBlock:^(NSError *error) {
            DebugLog(@"%@",error);
        } completionBlock:^{
            [self fetchDataLocal];
            
            reloading = NO;
            
            [logTableView reloadData];
            [logTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:logTableView];
            [self closeWaitView];
        }]; 
    } 
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrLogs count];
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78/2.f;
}
 
static NSString * cellKey = @"acell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellKey];

    CServiceLog *dataItem = (CServiceLog*)[arrLogs objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellKey] autorelease];
        UILabel *valueTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 78/2.f)];
        //valueCallTime.textColor = MF_ColorFromRGB(140, 137, 111);
        valueTime.backgroundColor = [UIColor clearColor];
        valueTime.font = [UIFont systemFontOfSize:14.0f];
        valueTime.tag = 1001;
        valueTime.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueTime];
        [valueTime release];
        
        UILabel *valueName = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, 78/2.f)];
        //valueName.textColor = MF_ColorFromRGB(140, 137, 111);
        valueName.backgroundColor = [UIColor clearColor];
        valueName.font = [UIFont systemFontOfSize:14.0f];
        valueName.tag = 1002;
        valueName.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:valueName];
        [valueName release];
        
        UIButton *playVoice = [UIButton buttonWithType:UIButtonTypeCustom];
        playVoice.tag = 1003;
        [playVoice setFrame:CGRectMake(160,(78/2.f - 43/2.f)/2.f,102/2.f, 43/2.f)];
        [playVoice setBackgroundImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/02.png") forState:UIControlStateNormal];
        //[playVoice setTitle:@"我要接单" forState:UIControlStateNormal];
        [playVoice addTarget:self action:@selector(doPlayVoice:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:playVoice];
        playVoice.hidden = YES;
    } 
    
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = GetDateString(dataItem.checkInTime,@"yyyy-MM-dd HH:mm:ss");
    
    BOOL haveLogFile = (dataItem.logFile != nil&&![dataItem.logFile isEqualToString:@""]);
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = !haveLogFile?dataItem.logContent:@"";
    ((UIButton*)[cell.contentView viewWithTag:1003]).hidden = !haveLogFile;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

 

#pragma mark -Button Click
- (void)doResponse:(id)sender {
    [self showWaitViewWithTitle:@"正在响应..."];
    
    NSString *url = JOIN2(bizUrl(BIT_ResponseByFamilyMember,callService.accessPoint),@"/",callService.callServiceId);
    NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:callService.belongFamilyMemberId,@"FamilyMemberId",nil];
    HttpAppRequest *req = buildReq2(head);
    
    
    [HttpAppAsynchronous httpPostWithUrl:url req:req sucessBlock:^(id result) {
        DebugLog(@"ret:%@",((HttpAppResponse*)result).ret);
        callService.responseFlag = NB(1);  
        [moc save];
        isResponsed = [callService.responseFlag boolValue];
        //
    } failedBlock:^(NSError *error) {
        //
        DebugLog(@"%@",error);
        ShowError(error.localizedDescription);
    } completionBlock:^{
        //
        [responseButton setEnabled: (([callService.doStatus intValue] != 2) && ![callService.responseFlag boolValue])];
        [callButton setEnabled: (([callService.doStatus intValue] != 2) && [callService.responseFlag boolValue])];
        
        [self closeWaitView];
    }];

}

- (void)doCall:(id)sender {
    UIImage *bg = MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/99.png");
    callSheet = [ZPUIActionSheet zSheetWithHeight:bg.size.height/2.f withSheetTitle:@""];
    UIImageView *bgView = makeImageViewByFrame(callSheet.contentView.bounds);
    bgView.image = bg;
    [callSheet.contentView addSubview:bgView];
    
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([ZPUIActionSheet class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [callSheet.contentView addSubview:btn];
        }
    }
    
    [callSheet showInView:self.view];

}
 
 
- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    
    switch (button.tag) {
        case 1:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://110"]];
            break;
        }
        case 2: {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://120"]];
            break;
        }
        case 3: {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://119"]];
            break;
        }
        case 4:{
            break;
        }
        case 5:{
            
            break;
        }
        case 6: {
            
            break;
        }
        case 7: {
            break;
        }
        case 8:{
            break;
        }
        default:
            break;
    }
    
    [callSheet docancel];
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
  

@end
