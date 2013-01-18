//
//  RescueController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "RescueController.h"
#import "CServiceRecord.h"
#import "CServiceLog.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define NOT_PROCESS 1

@interface RescueController (){
    BOOL pageControlUsed; 
    BOOL isInProcessActionView;
    BOOL reloading;
    ZPUIActionSheet *callSheet;
    UIView *maskView;
    CGPoint defaultFooterViewCenter;
    BOOL isEditing;
    MBProgressHUD *HUD;
    
    
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    BOOL isUploading;
    BOOL isPlaying;
}
@property (nonatomic, retain) CServiceRecord *servieRecord;
@property (nonatomic, retain) DDPageControl  *pageControl;
@property (nonatomic, retain) UILabel        *titleProcessLabel;
@property (nonatomic, retain) UIScrollView   *scrollProcess;
@property (nonatomic, retain) UITableView    *processActionTableView;
@property (nonatomic, retain) UITableView    *processResponseTableView;
@property (nonatomic, retain) EGORefreshTableHeaderView     *processActionTableHeaderView;
@property (nonatomic, retain) EGORefreshTableHeaderView     *processResponseTableHeaderView;
@property (nonatomic, retain) UIButton *voiceButton;
@property (nonatomic, retain) UITextField *messageField;
@property (nonatomic, retain) NSString *recordedFile;
@end

@implementation RescueController
@synthesize servieRecord;
@synthesize pageControl;
@synthesize titleProcessLabel;
@synthesize scrollProcess;
@synthesize processActionTableView;
@synthesize processResponseTableView;
@synthesize processActionTableHeaderView;
@synthesize processResponseTableHeaderView;
@synthesize arrProcessActions;
@synthesize arrProcessResponses;
@synthesize voiceButton;
@synthesize messageField;
@synthesize recordedFile;

- (void)dealloc {
    self.servieRecord = nil;
    self.pageControl = nil;
    self.titleProcessLabel = nil;
    self.processActionTableView = nil;
    self.processResponseTableView = nil;
    self.processActionTableHeaderView = nil;
    self.processResponseTableHeaderView = nil;
    self.scrollProcess = nil;
    self.arrProcessActions = nil;
    self.arrProcessResponses = nil;
    self.voiceButton = nil;
    self.messageField = nil;
    self.recordedFile = nil;
    [super dealloc];
}

-(id)initWithServiceRecord:(CServiceRecord*)aServiceRecord {
    self = [super init];
    if (self)
    {
        self.servieRecord = aServiceRecord;
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
    self.headerView.headerLabel.text = MF_SWF(@"紧急服务－%@需要救助",servieRecord.name);
    
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

    
    self.scrollProcess = makeScrollView(0.0f, cameraContainerView.top+cameraContainerView.height+40.f, self.containerView.width, 160.f);
    scrollProcess.backgroundColor = [UIColor clearColor];
    scrollProcess.showsVerticalScrollIndicator = false;
    scrollProcess.showsHorizontalScrollIndicator = false;
    scrollProcess.pagingEnabled = YES;
    scrollProcess.delegate = self;
    scrollProcess.scrollsToTop = NO;
    scrollProcess.contentSize = CGSizeMake(self.containerView.width*2, 160.f);
    //tileBlocksContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:scrollProcess];
    
    processActionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,scrollProcess.height)];
    processActionTableView.delegate = self;
    processActionTableView.dataSource = self;
    processActionTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [scrollProcess addSubview:processActionTableView];
    
    processResponseTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.containerView.width, 0, self.containerView.width,scrollProcess.height)];
    processResponseTableView.delegate = self;
    processResponseTableView.dataSource = self;
    processResponseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [scrollProcess addSubview:processResponseTableView];
    
    
    pageControl = [[DDPageControl alloc] init];
    [pageControl addTarget:self action:@selector(pageTo:) forControlEvents:UIControlEventValueChanged];
    [pageControl setOnColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]] ;
    [pageControl setOffColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]] ;
    pageControl.delegate = self;
    pageControl.numberOfPages = 2;
    [self.containerView addSubview:pageControl];
    pageControl.frame = CGRectMake(self.containerView.width-100.f, scrollProcess.top + scrollProcess.height-12.f, 100.f, 24);
    
    if ([servieRecord.doStatus intValue] == NOT_PROCESS) {
        UIButton *responseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [responseButton setFrame:CGRectMake((self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
        [responseButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/05.png") forState:UIControlStateNormal];
        [responseButton addTarget:self action:@selector(doResponse:) forControlEvents:UIControlEventTouchUpInside];
        [responseButton setBackgroundColor:[UIColor clearColor]];
        [self.footerView addSubview:responseButton];
        
        UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [callButton setFrame:CGRectMake(self.footerView.width/2.f+(self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
        [callButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/06.png") forState:UIControlStateNormal];
        [callButton addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
        [callButton setBackgroundColor:[UIColor clearColor]];
        [self.footerView addSubview:callButton];
    }
    else{
        self.footerView.backgroundColor = MF_ColorFromRGB(86, 96, 108);
        
        UIButton *keyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardButton setFrame:CGRectMake(107/2.f,(self.footerView.height - 46.f/2.f)/2.f, 46/2.f, 46/2.f)];
        [keyboardButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/IconKeyboard.png") forState:UIControlStateNormal];
        [keyboardButton addTarget:self action:@selector(doKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        [keyboardButton setBackgroundColor:[UIColor clearColor]];
        [self.footerView addSubview:keyboardButton];
        
        self.voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [voiceButton setFrame:CGRectMake(169/2.f,(self.footerView.height - 46.f/2.f)/2.f, 299/2.f, 46/2.f)];
        [voiceButton setTitle:@"按住说话" forState:UIControlStateNormal];
        voiceButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [voiceButton setTitleColor:MF_ColorFromRGB(154, 154, 154) forState:UIControlStateNormal];
        //[voiceButton addTarget:self action:@selector(doVoice:) forControlEvents:UIControlEventTouchUpInside];
        [voiceButton setBackgroundColor:[UIColor whiteColor]];
        [self.footerView addSubview:voiceButton];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = 0.2f;
        [voiceButton addGestureRecognizer:longPress];
        [longPress release];
        

        
        messageField = [[UITextField alloc] initWithFrame:voiceButton.frame];
        messageField.font = [UIFont systemFontOfSize:18];
        messageField.keyboardType = UIKeyboardTypeDefault;
        messageField.keyboardAppearance = UIKeyboardAppearanceDefault;
        messageField.delegate = self;
        messageField.returnKeyType = UIReturnKeyDone;
        messageField.backgroundColor = [UIColor whiteColor];
        //userNameField.placeholder = NSLocalizedString(@"RegisterController_EntPhoneNo", nil);
        //userNameField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:userNameField style:CInputAssistViewAll];
        messageField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.footerView addSubview:messageField];
        messageField.hidden = YES;
        
        UIButton *picButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [picButton setFrame:CGRectMake(486/2.f,(self.footerView.height - 46.f/2.f)/2.f, 46.f/2.f, 46.f/2.f)];
        [picButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/IconPic.png") forState:UIControlStateNormal];
        [picButton addTarget:self action:@selector(doPic:) forControlEvents:UIControlEventTouchUpInside];
        [picButton setBackgroundColor:[UIColor clearColor]];
        [self.footerView addSubview:picButton];
        
        defaultFooterViewCenter = self.footerView.center;
    }
     
    isInProcessActionView = YES;
    
    processActionTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - processActionTableView.height,self.containerView.width,processActionTableView.height)];
    processActionTableHeaderView.delegate = self;
    [processActionTableView addSubview:processActionTableHeaderView];
    
    processResponseTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - processResponseTableView.height,self.containerView.width,processResponseTableView.height)];
    processResponseTableHeaderView.delegate = self;
    [processResponseTableView addSubview:processResponseTableHeaderView];
    
	//  update the last update date
    if (isInProcessActionView) {
        [self.processActionTableHeaderView refreshLastUpdatedDate];
    }
    else{
        [self.processResponseTableHeaderView refreshLastUpdatedDate];
    }
    
    [self fetchData];
    
    isRecording = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    if ([servieRecord.doStatus intValue] == NOT_PROCESS) {
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
- (void)saveDataLocal:(BOOL)remoteSubmit WithPK:(NSString*) serviceTracksLogId withContent:(NSString*) content withSoundFile:(NSString*)soundFile {
    CServiceLog *log = [CServiceLog create];
    log.localSyncTime = [NSDate date];
    log.localSyncFlag = NB(remoteSubmit);
    
    log.callServiceId = self.servieRecord.callServiceId;
    log.checkInTime = [NSDate date];
    if(remoteSubmit){
        log.serviceTracksLogId = serviceTracksLogId;
    }
    
    log.logContent = content;
    if(soundFile){
        log.logSoundFile = soundFile;
    } 
    
    log.fetchByUserId = appSession.userId;
    log.serviceTracksId = self.servieRecord.serviceTracksId;
    log.type = NI(0);
    log.logName = appSession.userName;
    
    [moc save];
}

- (void)fetchDataLocal{
    self.arrProcessActions = [CServiceLog listProcessActionByService:servieRecord.callServiceId];
    self.arrProcessResponses = [CServiceLog listProcessResponseByService:servieRecord.callServiceId];
    [processActionTableView reloadData];
    [processResponseTableView reloadData];
}

- (void)fetchData{
    [self showWaitViewWithTitle:@"读取求助信息处理日志"];
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //本地登录
        [self fetchDataLocal];
        [self closeWaitView];
    }
    else{
        NSDictionary *postData = [NSDictionary dictionaryWithObjectsAndKeys:servieRecord.callServiceId,@"CallServiceId",nil];
        
        LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(ReadListOfProcessing) WithPostData:postData];
        
        
        [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
            //DebugLog(@"message:%@",((LeblueResponse*)result).message);
            //DebugLog(@"records:%@",((LeblueResponse*)result).records);
            NSArray *records = [((LeblueResponse*)result).records map:^(id obj){
                NSMutableDictionary *newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
                [newObj setValue:NI(1) forKey:@"LocalSyncFlag"];
                return newObj;
            }];
            [CServiceLog updateWithData:records ByService:servieRecord.callServiceId];
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            //
            [self fetchDataLocal];
            
            reloading = NO;
            UITableView *currentTableView  = isInProcessActionView?processActionTableView:processResponseTableView;
            [currentTableView reloadData]; 
            EGORefreshTableHeaderView *currentRefreshHeaderView = isInProcessActionView?processActionTableHeaderView:processResponseTableHeaderView;
            [currentRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:isInProcessActionView?processActionTableView:processResponseTableView];
            [self closeWaitView];
        }];
    } 
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView ==  processActionTableView){
        return [arrProcessActions count];
    }
    else{ 
        return [arrProcessResponses count];
    }
    
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78/2.f;
}
 
static NSString * cellKey1 = @"acell";
static NSString * cellKey2 = @"bcell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView == processActionTableView?cellKey1:cellKey2];
    NSArray *arrData = tableView == processActionTableView?arrProcessActions:arrProcessResponses;
    CServiceLog *dataItem = (CServiceLog*)[arrData objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:tableView == processActionTableView?cellKey1:cellKey2] autorelease];
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
    
    BOOL haveLogSoundFile = (dataItem.logSoundFile != nil&&![dataItem.logSoundFile isEqualToString:@""]);
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = !haveLogSoundFile?dataItem.logContent:@"";
    ((UIButton*)[cell.contentView viewWithTag:1003]).hidden = !haveLogSoundFile;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}


- (void) pageTo:(id) sender{
    float left = pageControl.currentPage==0? 0: scrollProcess.width;
    self.scrollProcess.contentOffset = CGPointMake(left,0);
    pageControlUsed = YES;
}
 

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    
    if(isInProcessActionView){
        [self.processActionTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    else{
        [self.processResponseTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(isInProcessActionView){
        [self.processActionTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    else{
        [self.processResponseTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -DDPageControlDelegate
- (void)dDPageControl:(DDPageControl*)theDDPageControl currentPageChangedFrom:(NSUInteger)oldPage to:(NSUInteger)newPage{
    if(newPage==1){
        titleProcessLabel.text = @"处理结果";
        isInProcessActionView = NO;
    }
    else{
        titleProcessLabel.text = @"应急处理";
        isInProcessActionView = YES;
    }
}

#pragma mark -Button Click
- (void)doResponse:(id)sender {
    NSDictionary *Data = [NSDictionary dictionaryWithObjectsAndKeys:servieRecord.serviceTracksId,@"ServiceTracksId",nil];
    
    LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(DoResponse) WithPostData:Data];
    
    
    [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
        DebugLog(@"message:%@",((LeblueResponse*)result).message);
        DebugLog(@"records:%@",((LeblueResponse*)result).records);
        
        [self navigationToPrevious];
    } failedBlock:^(NSError *error) {
        //
        DebugLog(@"%@",error);
    } completionBlock:^{
        //
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

- (void)doKeyboard:(id)sender {
    DebugLog(@"doKeyboard");
    
    if (!maskView){
        DebugLog(@"create maskView:%@-%f",maskView,self.footerView.height);
        maskView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        [self.containerView addSubview:maskView];
        [maskView release];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
        tap.cancelsTouchesInView = NO; // So that legit taps on the table bubble up to the tableview
        [maskView addGestureRecognizer:tap];
        [tap release];
        messageField.hidden = NO;
        [messageField becomeFirstResponder];
        voiceButton.hidden = YES;
        [self.footerView moveMeTo:CGPointMake(self.footerView.center.x, 195) withDuration:.25f];
        self.footerView.height = self.footerView.height+25.75;
        //[self.footerView setBounds:CGRectMake(0, 0, self.footerView.width, self.footerView.height+22)];
    }
}

- (void)doVoice:(id)sender {
    DebugLog(@"doVoice");
    
    
}

- (void)doPlayVoice:(id)sender{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.containerView addSubview:HUD];
    [HUD release];  
    [HUD showAnimated:YES whileExecutingBlock:^{
        UITableViewCell* cell = (UITableViewCell*)[[(UIButton*)sender superview] superview];
        UITableView *tableView = isInProcessActionView?processActionTableView:processResponseTableView;
        int row = [tableView indexPathForCell:cell].row;
        NSArray *arrData = isInProcessActionView?arrProcessActions:arrProcessResponses;
        CServiceLog *dataItem = (CServiceLog*)[arrData objectAtIndex:row];
         
        isPlaying = NO;
        NSString *path = JOINP2(localSoundDir,dataItem.logContent,dataItem.logSoundFile);
        if(!MF_FileExists(path)){
            //不存在，从网上下载
            HUD.mode = MBProgressHUDModeDeterminate;
            HUD.labelText = @"下载中...";
            sleep(1);

            
            NSString *urlAudio = JOINP2(baseURL3,dataItem.logContent,dataItem.logSoundFile);
            DebugLog(@"success:%@",urlAudio);
            [HttpSynchronous httpDownload:urlAudio destination:path delegate:self sucessBlock:^(id result) {
                
                [self playAudio:path];
            } failedBlock:^(NSError *error) {
                DebugLog(@"error:%@",error);
            } completionBlock:^{
                
            }];
        }
        else {
            //存在直接播放
            [self playAudio:path];
        }
        
        while (isPlaying) {
            //waiting
        }
    }];  
}

- (void)playAudio:(NSString *) path{
    HUD.customView = [[[UIImageView alloc] initWithImage:MF_PngOfDefaultSkin(@"Index/loud.png")] autorelease];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"  开始播放  ";
    
    //NSString *destDir = JOINP(localSoundDir,@"a24e60d4-be66-4493-a02d-f75a679791af/2991aeef-d6d8-47e0-922c-43d1cfb7dcb1");
    NSError *playerError;
    player = [[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&playerError] autorelease];
    
    if (player == nil)
    {
        DebugLog(@"ERror creating player: %@", [playerError description]);
        [HUD hide:YES];
    }
    player.delegate = self;
    [player play];
    isPlaying = YES;
}

- (void)doPic:(id)sender {
    DebugLog(@"doPic");
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

#pragma mark - 长按
-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        isRecording = NO; 
        [recorder stop];
        recorder = nil; 
        
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        
        
        HUD = [[MBProgressHUD alloc] initWithView:self.containerView];
        [self.containerView addSubview:HUD];
        [HUD release];
        HUD.customView = [[[UIImageView alloc] initWithImage:MF_PngOfDefaultSkin(@"Index/microphone.png")] autorelease];
        
        // Set custom view mode
        HUD.mode = MBProgressHUDModeCustomView;
        
        //HUD.delegate = self;
        HUD.labelText = @"  开始说话  "; 

        self.recordedFile = GUID; 
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if(session != nil){
            [session setActive:YES error:nil];
            if(!isRecording)
            {
                isRecording = YES;
                isUploading = NO;
                recorder = [[AVAudioRecorder alloc] initWithURL:NFURL(JOINP(NSTemporaryDirectory(),recordedFile)) settings:nil error:nil];
                [recorder prepareToRecord];
                recorder.meteringEnabled = YES;
                [recorder record];
                //player = nil;
                
                [HUD showAnimated:YES whileExecutingBlock:^{
                    double lowPassResults;
                    while (isRecording) {
                        //测试音量 
                        [recorder updateMeters];
                        
                        const double ALPHA = 0.05;
                        double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
                        lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
                        int levels = (int)(lowPassResults*100/20);
                        NSMutableString *s0 = [NSMutableString stringWithString:@"□□□□□"];
                        NSMutableString *s = [NSMutableString string];
                         
                        while (levels) {
                            [s appendString:@"■"];
                            levels--;
                        }
                        [s0 replaceCharactersInRange:NSMakeRange(0, s.length) withString:s];
                        HUD.labelText = s0;
                    }
                    
                    NSString *sourcePath = JOINP(NSTemporaryDirectory(),recordedFile);
                    NSString *dirCallServiceIdAndUserId = JOINP(servieRecord.callServiceId,appSession.userId);
                    NSString *destDir = JOINP(localSoundDir,dirCallServiceIdAndUserId);
                    
                    //move to Documents and save to local
                    isUploading = YES;
                    [PHResourceManager moveResourceFrom:sourcePath To:JOINP(destDir,recordedFile) sucessBlock:^(id result) {
                        if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
                            //保存到本地
                            
                            [self saveDataLocal:NO WithPK:nil withContent:destDir withSoundFile:recordedFile];
                            
                            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
                            HUD.mode = MBProgressHUDModeCustomView;
                            HUD.labelText = @"保存成功";
                            isUploading = YES;
                        }
                        else{
                            
                            //开始上传
                            HUD.mode = MBProgressHUDModeDeterminate;
                            HUD.labelText = @"上传中...";
                            sleep(1);
                            
                            id theServiceTracksId = servieRecord.serviceTracksId;
                            if(theServiceTracksId == nil){
                                theServiceTracksId = [NSNull null];
                            }
                            NSDictionary *Data = [NSDictionary dictionaryWithObjectsAndKeys: NI(0),@"Type",appSession.userId,@"UserId",appSession.userName,@"UserName", dirCallServiceIdAndUserId,@"LogContent",recordedFile,@"LogSoundFile",theServiceTracksId,@"ServiceTracksId",servieRecord.callServiceId,@"CallServiceId",nil];
                            
                            LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(SendServiceLog) WithPostData:Data];
                            
                            [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
                                
                                [self saveDataLocal:YES WithPK:[((LeblueResponse*)result).records objectAtIndex:0] withContent:destDir withSoundFile:recordedFile];
                                
                                NSDictionary *dataPost = [NSDictionary dictionaryWithObjectsAndKeys: recordedFile,@"LogSoundFile",appSession.userId,@"UserId",servieRecord.callServiceId,@"CallServiceId",nil];
                                
                                [HttpSynchronous httpUploadTo:baseURL2 file:JOINP(destDir,recordedFile) data:dataPost delegate:self sucessBlock:^(id result) {
                                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
                                    HUD.mode = MBProgressHUDModeCustomView;
                                    HUD.labelText = @"上传成功";
                                    DebugLog(@"%@",@"上传成功");
                                } failedBlock:^(NSError *error) {
                                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
                                    HUD.mode = MBProgressHUDModeCustomView;
                                    HUD.labelText = @"上传失败";
                                    DebugLog(@"%@",@"上传失败");
                                } completionBlock:^{
                                    sleep(1);
                                }];
 
                                
                            } failedBlock:^(NSError *error) {
                                //
                                DebugLog(@"%@",error);
                                //[self saveDataLocalAsSoundFile:NO WithPK:nil With:recordedFile];
                            } completionBlock:^{
                                DebugLog(@"record save end");
                                isUploading = NO;
                                
                            }];
                        }
                        
                    } failedBlock:^(NSError *error) {
                        DebugLog(@"record move error:%@",error);
                    } completionBlock:^{
                        DebugLog(@"record move end");
                    }];
                    
                    while (isUploading) {
                        usleep(100000);
                    }
                    DebugLog(@"HUD show block end");
                    [self fetchData];
                    
                }];//end show block
            }
        }
        else{
            DebugLog(@"Error creating session: %@", [sessionError description]);
            [HUD hide:YES];
        } 
    }
}

#pragma mark- ASIProgressDelegate
-(void)setProgress:(float)newProgress{
    DebugLog(@"setProgress:%f",newProgress);
    HUD.progress = newProgress;
    usleep(50000);
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    isPlaying = NO;
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
 
-(void)tapOut:(UIGestureRecognizer *)gestureRecognizer {
    [maskView removeFromSuperview];
    maskView = nil;
    [messageField resignFirstResponder];
    self.footerView.height = self.footerView.height-25.75;
    [self.footerView moveMeTo:defaultFooterViewCenter withDuration:.25f];
    messageField.hidden = YES;
    voiceButton.hidden = NO;
    //[self.footerView setBounds:CGRectMake(0, 0, self.footerView.width, self.footerView.height-22)];
    
}
 
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(isEditing){
        //[self.footerView moveMeTo:CGPointMake(self.footerView.center.x, 200) withDuration:.1f];
        return;
    }
    //CGPoint upCenter = CGPointMake(self.bodyView.center.x, self.bodyView.center.y - 120);
    //[self.bodyView moveMeTo:upCenter];
    isEditing = YES;
}

// done button pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField ==  messageField){

        [self showWaitViewWithTitle:@"提交应急处理"];
        if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
            [self saveDataLocal:NO WithPK:nil withContent:messageField.text withSoundFile:nil]; 
            [maskView removeFromSuperview];
            maskView = nil;
            [messageField resignFirstResponder];
            self.footerView.height = self.footerView.height-25.75;
            [self.footerView moveMeTo:defaultFooterViewCenter withDuration:.25f];
            messageField.hidden = YES;
            voiceButton.hidden = NO;
            [self closeWaitView];
        }
        else{
            id theServiceTracksId = servieRecord.serviceTracksId;
            if(theServiceTracksId == nil){
                theServiceTracksId = [NSNull null];
            }
            NSDictionary *Data = [NSDictionary dictionaryWithObjectsAndKeys: NI(0),@"Type",appSession.userId,@"UserId",appSession.userName,@"UserName", messageField.text,@"LogContent",[NSNull null],@"LogSoundFile",theServiceTracksId,@"ServiceTracksId",servieRecord.callServiceId,@"CallServiceId",nil];
            
            LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(SendServiceLog) WithPostData:Data];
            
            
            [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
                DebugLog(@"message:%@",((LeblueResponse*)result).message);
                DebugLog(@"records:%@",((LeblueResponse*)result).records);
                [self saveDataLocal:YES WithPK:[((LeblueResponse*)result).records objectAtIndex:0] withContent:messageField.text withSoundFile:nil]; 
            } failedBlock:^(NSError *error) {
                //
                DebugLog(@"%@",error);
            } completionBlock:^{
                //
                [maskView removeFromSuperview];
                maskView = nil;
                [messageField resignFirstResponder];
                self.footerView.height = self.footerView.height-25.75;
                [self.footerView moveMeTo:defaultFooterViewCenter withDuration:.25f];
                messageField.hidden = YES;
                voiceButton.hidden = NO;
                [self closeWaitView];
                
                [self fetchData];
            }];
        } 
    }
    isEditing = NO;
    return YES;
}

@end
