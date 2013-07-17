//
//  LoginController.m
//  SmartLife
//
//  Created by zppro on 12-11-24.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "LoginController.h"
#import "AppMacro.h"
#import "RegisterController.h"
#import "CMember.h"

@interface LoginController(){
    BOOL isEditing;
    MBProgressHUD *HUD;
}
@property (nonatomic,retain) UITextField *theIDNoField;
@property (nonatomic,retain) UITextField *passwordField;
@property (nonatomic,retain) UIButton *registerButton;
@property (nonatomic,retain) UIButton *loginButton;
@end

@implementation LoginController
@synthesize theIDNoField;
@synthesize passwordField;
@synthesize registerButton;
@synthesize loginButton;

- (void)dealloc {
    self.theIDNoField = nil;
    self.passwordField = nil;
    self.registerButton = nil;
    self.loginButton = nil;
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
     
    UIImageView *bgView = makeImageView(0, 0, 320, 480);
    bgView.image = MF_PngOfDefaultSkin(@"Index/sign_02.png");
    [self.view addSubview:bgView];
    
    UIImageView *boxView = makeImageView(13.f/2.f, 50.f/2.f, 614.0/2.f, 455.f/2.f);
    boxView.image = MF_PngOfDefaultSkin(@"Index/sign_07_04.png");
    [self.view addSubview:boxView];
    
    UIImageView *titleInBoxView = makeImageView(113.f/2.f, 100.f/2.f, 435/2.f, 49.f/2.f);
    titleInBoxView.image = MF_PngOfDefaultSkin(@"Index/sign_01.png");
    [self.view addSubview:titleInBoxView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(73.f/2.f,180/2.f,512.f/2.f,1.f/2.f)];
    lineView.backgroundColor = MF_ColorFromRGB(2, 94, 141);
    [self.view addSubview:lineView];
     
    UIImageView *theIDNoLabel = makeImageView(40.f/2.f, 240/2.f, 114.f/2.f, 33.f/2.f);
    theIDNoLabel.image = MF_PngOfDefaultSkin(@"Index/sign_03.png");
    [self.view addSubview:theIDNoLabel];
    
    UIImageView *passwordLabel = makeImageView(40.f/2.f, 320/2.f, 114.f/2.f, 33.f/2.f);
    passwordLabel.image = MF_PngOfDefaultSkin(@"Index/sign_04.png");
    [self.view addSubview:passwordLabel];
    
    theIDNoField = [[UITextField alloc] initWithFrame:CGRectMake(170.0/2,240/2.f,370.f/2.f, 38.0/2)];
    theIDNoField.font = [UIFont systemFontOfSize:18];
    theIDNoField.keyboardType = UIKeyboardTypeDefault;
    theIDNoField.keyboardAppearance = UIKeyboardAppearanceDefault;
    theIDNoField.delegate = self;
    theIDNoField.backgroundColor = [UIColor whiteColor];
    //userNameField.placeholder = NSLocalizedString(@"RegisterController_EntPhoneNo", nil);
    theIDNoField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:theIDNoField style:CInputAssistViewAll];
    theIDNoField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:theIDNoField];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(170.0/2,320/2.f,370.f/2.f, 38.0/2)];
    passwordField.font = [UIFont systemFontOfSize:18];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.secureTextEntry = YES;
    passwordField.keyboardAppearance = UIKeyboardTypeNumberPad;
    passwordField.delegate = self;
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:passwordField style:CInputAssistViewAll];
    [self.view addSubview:passwordField];
    
    registerButton = makeButton(175.0/2,400/2.f,121.f/2.f, 48.0/2);
    [registerButton setImage:MF_PngOfDefaultSkin(@"Index/sign_08.png") forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    loginButton = makeButton(328.0/2,400/2.f,121.f/2.f, 48.0/2);
    [loginButton setImage:MF_PngOfDefaultSkin(@"Index/sign_05.png") forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *forgetPasswordButton = makeButton(460.0/2,420/2.f,121.f/2.f, 22.0/2);
    [forgetPasswordButton setImage:MF_PngOfDefaultSkin(@"Index/sign_06.png") forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
    
    theIDNoField.text = @"330501983040201103";
    passwordField.text = @"123";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button click
- (void)registerButtonClick:(id)sender{
    RegisterController *regController = [[RegisterController alloc] init];
    [self navigationTo:regController];
    [regController release];
}
- (void)loginButtonClick:(id)sender{
    if(isEditing){ 
        [theIDNoField resignFirstResponder];
        [passwordField resignFirstResponder];
        isEditing = NO;
    }
    
    if([theIDNoField.text isEqualToString:@""]){
        showHUDInfo(self,self.view,@"身份证不能为空");
        return;
    }
    
    if([passwordField.text isEqualToString:@""]){
        showHUDInfo(self,self.view,@"密码不能为空");
        return;
    } 
    NSString *passwordHash = [passwordField.text stringFromMD5];
    if (appSession.networkStatus != ReachableViaWWAN && appSession.networkStatus != ReachableViaWiFi) {
        //本地登录
        CMember *instance = [CMember loadWithIDNo:theIDNoField.text andPasswordHash: passwordHash];
        
        if(instance == nil){
        }
        else{
            instance.lastCheckIn = [NSDate date];
            [moc save];
        }
    }
    else{
     
        NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:theIDNoField.text,@"IDNo",[passwordField.text MD5],@"PasswordHash",nil];
        HttpAppRequest *req = buildReq(body);
        
         
        [HttpAppAsynchronous httpPostWithUrl:authUrl(AIT_Member) req:req sucessBlock:^(id result) {
            DebugLog(@"ret:%@",((HttpAppResponse*)result).ret);
            NSDictionary *dict = ((HttpAppResponse*)result).ret;
            appSession.authId = [dict objectForKey:@"MemberId"];
            appSession.authToken = [dict objectForKey:@"Token"];
            appSession.authType = AOT_Member;
            appSession.authNodeInfos = [dict objectForKey:@"AuthNodeInfos"];
            
            //推送
            //[self registerDevice];
             
            /*
             [NSTimer scheduledTimerWithTimeInterval:10.f block:^(NSTimeInterval time) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
             CLLocation *currentLocation = soc.canLocation? soc.myLocation:soc.DebugMyLocation;
             DebugLog(@"登记对象位置信息 %@ ",currentLocation);
             
             NSDictionary *Data1 = [NSDictionary dictionaryWithObjectsAndKeys:userNameField.text,@"LoginId",passwordField.text,@"PassWord",nil];
             
             LeblueRequest* req1 =[LeblueRequest requestWithHead:nwCode(Login) WithPostData:Data];
             
             });
             
             
             } repeats:YES];
             */

            
            [self dismissModalViewControllerAnimated:YES];
            //
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            //
            CMember *instance = [CMember objectByEntityKey:appSession.authId];
            NSDictionary *dataItem = [NSDictionary dictionaryWithObjectsAndKeys:appSession.authId,@"MemberId",theIDNoField.text,@"IDNo", [passwordField.text MD5],@"PasswordHash",[appSession.authNodeInfos JSONRepresentation],@"AuthNodeInfos",[NSDate date],@"LastCheckIn",nil];
            
            if(instance == nil){
                [CMember createWithIEntity:dataItem];
            }
            else{
                [instance updateWithIEntity:dataItem]; 
            }
            [moc save];
        }];
    }
    /*
    UIButton *button = (UIButton*)sender;
    [button recordBehaviorForFunction1:FUNC_01 andFunction2:FUNC_0102 withAction:mdMethodName andEvent:UIControlEventTouchUpInside];
    
    NSString *error = nil;
    if(![mobileNo.text isValidPhoneNumber:&error]){
        [moMessageView show:error];
        return;
    }
    [self showWaitView];
    
    if(globalObject.memberInfo == nil){
        //正常登录
        NSMutableDictionary *sendData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         mobileNo.text,@"AccountCode",
                                         mobileNo.text,@"Mobile",
                                         [password.text MD5],@"PasswordHash",
                                         nil ];
        
        [loginService loginForMobile:sendData];
    }
    else{
        //先退出登录
        NSMutableDictionary *sendData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         globalObject.memberInfo.memberId,@"MemberId",
                                         nil ];
        
        [loginService loginOut:sendData];
    }
    */
    
    
}

- (void) registerDevice{
    NSString *longitude = soc.canLocation?[ND(soc.myLocation.coordinate.longitude) stringValue]:[ND(soc.DebugMyLocation.coordinate.longitude) stringValue];
    NSString *latitude = soc.canLocation?[ND(soc.myLocation.coordinate.latitude) stringValue]:[ND(soc.DebugMyLocation.coordinate.latitude) stringValue];
    DebugLog(@"longitude:%@",longitude);
    DebugLog(@"latitude:%@",latitude);
      
    NSDictionary *Data = [NSDictionary dictionaryWithObjectsAndKeys:soc.rom.model,@"deviceModel",soc.rom.deviceToken,@"deviceToken",soc.rom.osversion,@"iOSVersion",NI(1),@"isOnLine",longitude,@"longitude",latitude,@"latitude",soc.rom.applicationId,@"applicationId",appSession.authId,@"infoId",@"",@"comment",nil];
    
    LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(RegisterDevice) WithPostData:Data];
    
    
    [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
        DebugLog(@"message:%@",((LeblueResponse*)result).message);
        DebugLog(@"records:%@",((LeblueResponse*)result).records);
         
        //
    } failedBlock:^(NSError *error) {
        //
        DebugLog(@"%@",error);
    } completionBlock:^{
        //
    }];

}

- (void)forgetPasswordButtonClick:(id)sender{
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(isEditing){
        return;
    }
    //CGPoint upCenter = CGPointMake(self.bodyView.center.x, self.bodyView.center.y - 120);
    //[self.bodyView moveMeTo:upCenter];
    isEditing = YES;
}

// done button pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField ==  passwordField){
        [self performSelector:@selector(loginButtonClick:) withObject:textField];
    }
    return YES;
}

#pragma mark - CInputAssistViewDelgate Method
-(void)inputAssistViewPerviousTapped:(UITextField*)aTextFiled{
    if (aTextFiled == passwordField) {
        [theIDNoField becomeFirstResponder];
    }
}
-(void)inputAssistViewNextTapped:(UITextField*)aTextFiled{
    if (aTextFiled == theIDNoField) {
        [passwordField becomeFirstResponder];
    }
}

-(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled{ 
    [aTextFiled resignFirstResponder];
    isEditing = NO;
}

-(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled{
    if (aTextFiled == theIDNoField) {
        [passwordField becomeFirstResponder];
    } else {
        [self performSelector:@selector(loginButtonClick:) withObject:aTextFiled];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}



@end
