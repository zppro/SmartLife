//
//  AddressBookController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AddressBookController.h"
#import "ContactDetailController.h"

@interface AddressBookController ()
@property (nonatomic, retain) NSArray  *arrAB;
@property (nonatomic, retain) UITableView  *myTableView;
@property (nonatomic,retain) UITextField *searchField;
@end

@implementation AddressBookController
@synthesize arrAB;
@synthesize myTableView;
@synthesize searchField;

- (void)dealloc {
    self.myTableView = nil;
    self.arrAB = nil;
    self.searchField = nil;
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
    self.arrAB = [NSMutableArray arrayWithObjects: 
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈昌达",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"董智勇",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方浩",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"范婷婷",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"丁鹏",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"方小雪",@"Name",nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"陈静",@"Name",nil],
                            nil];
    */
    self.headerView.headerLabel.text = @"通讯录";
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(50.0/2,(93/2.f - 48.0/2.f)/2.f,450.f/2.f, 48.0/2)];
    searchField.font = [UIFont systemFontOfSize:17.f];
    searchField.textAlignment = UITextAlignmentCenter;
    searchField.keyboardType = UIKeyboardTypeDefault;
    searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.clearButtonMode = UITextFieldViewModeAlways;
    [self.containerView addSubview:searchField];
     
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setFrame:CGRectMake(550/2.0,(93/2.f - 36.0/2.f)/2.f, 50/2.f, 36/2.f)];
    [deleteButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/delete.png") forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:deleteButton];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 93.f/2.f, self.containerView.width,self.containerView.height- 93.f/2.f)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.containerView addSubview:myTableView];
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        DebugLog(@"1");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreate(), ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
        DebugLog(@"2");
    }
    
    if (accessGranted) {
        // Do whatever you want here.
        [self fetchData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -数据操作
- (void) fetchData{
    [self showWaitViewWithTitle:@"读取本地通讯录"];
    DebugLog(@"people count:%d",[ab personCount]);
    self.arrAB = [[ABAddressBook sharedAddressBook] allPeopleSorted];
    [self closeWaitView];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrAB count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93/2.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    ABPerson *dataItem = (ABPerson*)[arrAB objectAtIndex:indexPath.row];
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
        [cell.contentView addSubview:landPhoneButton];
        
        UIButton *voipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [voipButton setFrame:CGRectMake(392/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [voipButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/VOIP.png") forState:UIControlStateNormal];
        [voipButton addTarget:self action:@selector(doVOIP:) forControlEvents:UIControlEventTouchUpInside];
        [voipButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:voipButton];
        
        UIButton *networkIntercomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [networkIntercomButton setFrame:CGRectMake(514/2.0,(cell.contentView.height - 38.f/2.f)/2.f, 107/2.f, 38/2.f)];
        [networkIntercomButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/NetworkIntercom.png") forState:UIControlStateNormal];
        [networkIntercomButton addTarget:self action:@selector(doNetworkIntercom:) forControlEvents:UIControlEventTouchUpInside];
        [networkIntercomButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:networkIntercomButton];
    }
    ((UILabel*)[cell.contentView viewWithTag:1001]).text =  JOINF(@" ", dataItem.lastName, dataItem.firstName);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dataItem = (NSDictionary*)[arrAB objectAtIndex:indexPath.row];
    [self navigationTo:[[[ContactDetailController alloc] initWithContactInfo:dataItem] autorelease]];
}

#pragma mark 按钮事件
- (void) doLandPhone:(id) sender{
    
}

- (void) doVOIP:(id) sender{
    
}

- (void) doNetworkIntercom:(id) sender{
    
}

- (void) doDelete:(id) sender{
    if(searchField.text.length == 0){
        return;
    }
    searchField.text = [searchField.text substringToIndex:searchField.text.length-1];
}
@end
