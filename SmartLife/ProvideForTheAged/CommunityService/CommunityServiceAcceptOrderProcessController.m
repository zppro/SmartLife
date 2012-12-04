//
//  CommunityServiceAcceptOrderProcessController.m
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "CommunityServiceAcceptOrderProcessController.h"

@interface CommunityServiceAcceptOrderProcessController (){
    BOOL pageControlUsed;
}
@property (nonatomic, retain) DDPageControl  *pageControl;
@property (nonatomic, retain) UILabel        *titleLabel;
@property (nonatomic, retain) UIScrollView   *scrollProcess;
@property (nonatomic, retain) UITableView    *acceptOrderInfoTableView;
@property (nonatomic, retain) UITableView    *processActionTableView;
@property (nonatomic, retain) NSArray        *arrAcceptOrderInfos;
@property (nonatomic, retain) NSArray        *arrProcessActions;
@end

@implementation CommunityServiceAcceptOrderProcessController
@synthesize pageControl;
@synthesize titleLabel;
@synthesize scrollProcess;
@synthesize acceptOrderInfoTableView;
@synthesize processActionTableView;
@synthesize arrAcceptOrderInfos;
@synthesize arrProcessActions;

- (void)dealloc {
    self.pageControl = nil;
    self.titleLabel = nil;
    self.acceptOrderInfoTableView = nil;
    self.processActionTableView = nil;
    self.scrollProcess = nil;
    self.arrAcceptOrderInfos = nil;
    self.arrProcessActions = nil;
    
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
    self.arrAcceptOrderInfos = [NSMutableArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:30:01",@"ActionTime", @"120已接通",@"Description",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"社区医生已接通",@"Description",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"老人大儿子已接通",@"Description",nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:32:01",@"ActionTime", @"老人小儿子已接通",@"Description",nil],
                              nil];
    
    self.arrProcessActions = [NSMutableArray arrayWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:33:20",@"ResponseTime", @"社区医生预计5分钟后到",@"ResponseContent",@"text",@"ResponseType",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:34:01",@"ResponseTime", @"老人小女儿已响应",@"ResponseContent",@"text",@"ResponseType",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:35:01",@"ResponseTime", @"01.mp3",@"ResponseContent",@"audio",@"ResponseType",nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:@"2012-11-11 15:35:10",@"ResponseTime", @"02.mp3",@"ResponseContent",@"audio",@"ResponseType",nil],
                                nil];
    
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = @"社区服务－接单处理";
    
    UIView *mapContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.f, 313/2.f)];
    mapContainerView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:mapContainerView];
    [mapContainerView release];
    
    UIImageView *mapView = makeImageView(0, 0, mapContainerView.width, mapContainerView.height);
    mapView.image = MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/16.png");
    [mapContainerView addSubview:mapView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, mapContainerView.top+mapContainerView.height+10.f, 200.f, 30.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.text = @"接单情况";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];//[UIFont systemFontOfSize:16];//
    [self.containerView addSubview:titleLabel];
    
    
    scrollProcess = makeScrollView(0.0f, mapContainerView.top+mapContainerView.height+40.f, self.containerView.width, 160.f);
    scrollProcess.backgroundColor = [UIColor clearColor];
    scrollProcess.showsVerticalScrollIndicator = false;
    scrollProcess.showsHorizontalScrollIndicator = false;
    scrollProcess.pagingEnabled = YES;
    scrollProcess.delegate = self;
    scrollProcess.scrollsToTop = NO;
    scrollProcess.contentSize = CGSizeMake(self.containerView.width*2, 160.f);
    //tileBlocksContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:scrollProcess];
    
    acceptOrderInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.width,scrollProcess.height)];
    acceptOrderInfoTableView.delegate = self;
    acceptOrderInfoTableView.dataSource = self;
    acceptOrderInfoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [scrollProcess addSubview:acceptOrderInfoTableView];
    
    processActionTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.containerView.width, 0, self.containerView.width,scrollProcess.height)];
    processActionTableView.delegate = self;
    processActionTableView.dataSource = self;
    processActionTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [scrollProcess addSubview:processActionTableView];
    
    
    pageControl = [[DDPageControl alloc] init];
    [pageControl addTarget:self action:@selector(pageTo:) forControlEvents:UIControlEventValueChanged];
    [pageControl setOnColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]] ;
    [pageControl setOffColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]] ;
    pageControl.delegate = self;
    pageControl.numberOfPages = 2;
    [self.containerView addSubview:pageControl];
    pageControl.frame = CGRectMake(self.containerView.width-100.f, scrollProcess.top + scrollProcess.height-12.f, 100.f, 24);
    
    UIButton *arriveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [arriveButton setFrame:CGRectMake((self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
    [arriveButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/01.png") forState:UIControlStateNormal];
    [arriveButton addTarget:self action:@selector(doArrive:) forControlEvents:UIControlEventTouchUpInside];
    [arriveButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:arriveButton];
    
    UIButton *leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaveButton setFrame:CGRectMake(self.footerView.width/2.f+(self.footerView.width/2.f-308/2.f)/2.0,(self.footerView.height - 61.f/2.f)/2.f, 308/2.f, 61/2.f)];
    [leaveButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/CommunityService/02.png") forState:UIControlStateNormal];
    [leaveButton addTarget:self action:@selector(doLeave:) forControlEvents:UIControlEventTouchUpInside];
    [leaveButton setBackgroundColor:[UIColor clearColor]];
    [self.footerView addSubview:leaveButton];
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
        return [arrAcceptOrderInfos count];
    }
    else{
        return [arrProcessActions count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78/2.f;
}

static NSString * cellKey1 = @"acell";
static NSString * cellKey2 = @"bcell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView == processActionTableView?cellKey1:cellKey2];
    NSArray *arrData = tableView == acceptOrderInfoTableView?arrAcceptOrderInfos:arrProcessActions;
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
    NSString *key1 = tableView==acceptOrderInfoTableView?@"ActionTime":@"ResponseTime";
    NSString *key2 = tableView==acceptOrderInfoTableView?@"Description":@"ResponseContent";
    
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
        titleLabel.text = @"服务过程";
    }
    else{
        titleLabel.text = @"接单情况";
    }
}

#pragma mark -Button Click
- (void)doArrive:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)doLeave:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
 

#pragma mark -TableHeaderDelegate
- (void)backButtonOnClickWithPOPVC {
    [self dismissModalViewControllerAnimated:YES];
}
@end
