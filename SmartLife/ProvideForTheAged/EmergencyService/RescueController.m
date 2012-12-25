//
//  RescueController.m
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "RescueController.h"

@interface RescueController (){
    BOOL pageControlUsed;
}
@property (nonatomic, retain) NSDictionary  *oldManInfo;
@property (nonatomic, retain) DDPageControl  *pageControl;
@property (nonatomic, retain) UILabel        *titleProcessLabel;
@property (nonatomic, retain) UIScrollView   *scrollProcess;
@property (nonatomic, retain) UITableView    *processActionTableView;
@property (nonatomic, retain) UITableView    *processResponseTableView;
@end

@implementation RescueController
@synthesize oldManInfo;
@synthesize pageControl;
@synthesize titleProcessLabel;
@synthesize scrollProcess;
@synthesize processActionTableView;
@synthesize processResponseTableView;
@synthesize arrProcessActions;
@synthesize arrProcessResponses;

- (void)dealloc {
    self.oldManInfo = nil;
    self.pageControl = nil;
    self.titleProcessLabel = nil;
    self.processActionTableView = nil;
    self.processResponseTableView = nil;
    self.scrollProcess = nil;
    self.arrProcessActions = nil;
    self.arrProcessResponses = nil; 
    [super dealloc];
}

-(id)initWithOldManInfo:(NSDictionary*)aOldManInfo {
    self = [super init];
    if (self)
    {
        self.oldManInfo = aOldManInfo;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = MF_SWF(@"紧急服务－%@需要救助",[oldManInfo objectForKey:@"Name"]);
    
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
    NSDictionary *dataItem = (NSDictionary*)[arrData objectAtIndex:indexPath.row];
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
        valueName.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:valueName];
        [valueName release]; 
    }
    NSString *key1 = tableView==processActionTableView?@"ActionTime":@"ResponseTime";
    NSString *key2 = tableView==processActionTableView?@"Description":@"ResponseContent";
    
    ((UILabel*)[cell.contentView viewWithTag:1001]).text = [dataItem objectForKey:key1];
    ((UILabel*)[cell.contentView viewWithTag:1002]).text = [dataItem objectForKey:key2];
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

#pragma mark -DDPageControlDelegate
- (void)dDPageControl:(DDPageControl*)theDDPageControl currentPageChangedFrom:(NSUInteger)oldPage to:(NSUInteger)newPage{
    if(newPage==1){
        titleProcessLabel.text = @"处理结果";
    }
    else{
        titleProcessLabel.text = @"应急处理";
    }
}

#pragma mark -Button Click
- (void)doResponse:(id)sender {
    
}

- (void)doCall:(id)sender {
    UIImage *bg = MF_PngOfDefaultSkin(@"ProvideForTheAged/EmergencyService/99.png");
    ZPUIActionSheet *callSheet = [ZPUIActionSheet zSheetWithHeight:bg.size.height/2.f withSheetTitle:@""];
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
             
            break;
        }
        case 2: {
            
            break;
        }
        case 3: {
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
}
@end
