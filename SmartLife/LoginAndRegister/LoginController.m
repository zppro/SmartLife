//
//  LoginController.m
//  SmartLife
//
//  Created by zppro on 12-11-24.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "LoginController.h"
#import "AppMacro.h"


@interface LoginController(){
    BOOL isEditing;
    MBProgressHUD *HUD;
}
@property (nonatomic,retain) UITextField *userNameField;
@property (nonatomic,retain) UITextField *passwordField;
@property (nonatomic,retain) UIButton *loginButton;
@end

@implementation LoginController
@synthesize userNameField;
@synthesize passwordField;
@synthesize loginButton;

- (void)dealloc {
    self.userNameField = nil;
    self.passwordField = nil;
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
     
    UIImageView *userNameLabel = makeImageView(100.f/2.f, 240/2.f, 114.f/2.f, 33.f/2.f);
    userNameLabel.image = MF_PngOfDefaultSkin(@"Index/sign_03.png");
    [self.view addSubview:userNameLabel];
    
    UIImageView *passwordLabel = makeImageView(100.f/2.f, 320/2.f, 114.f/2.f, 33.f/2.f);
    passwordLabel.image = MF_PngOfDefaultSkin(@"Index/sign_04.png");
    [self.view addSubview:passwordLabel];
    
    userNameField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,240/2.f,300.f/2.f, 38.0/2)];
    userNameField.font = [UIFont systemFontOfSize:18];
    userNameField.keyboardType = UIKeyboardTypePhonePad;
    userNameField.keyboardAppearance = UIKeyboardAppearanceDefault;
    userNameField.delegate = self;
    userNameField.backgroundColor = [UIColor whiteColor];
    //userNameField.placeholder = NSLocalizedString(@"RegisterController_EntPhoneNo", nil);
    userNameField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:userNameField style:CInputAssistViewAll];
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:userNameField];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,320/2.f,300.f/2.f, 38.0/2)];
    passwordField.font = [UIFont systemFontOfSize:18];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.secureTextEntry = YES;
    passwordField.keyboardAppearance = UIKeyboardAppearanceDefault;
    passwordField.delegate = self;
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:passwordField style:CInputAssistViewAll];
    [self.view addSubview:passwordField];
    
    
    loginButton = makeButton(240.0/2,400/2.f,161.f/2.f, 48.0/2);
    [loginButton setImage:MF_PngOfDefaultSkin(@"Index/sign_05.png") forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *forgetPasswordButton = makeButton(420.0/2,413/2.f,121.f/2.f, 22.0/2);
    [forgetPasswordButton setImage:MF_PngOfDefaultSkin(@"Index/sign_06.png") forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
    
    userNameField.text = @"57188976666";//@"13685756227/0";//@"蒋美华";@"爱源汽车服务";//'57188976666'
    passwordField.text = @"1234";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button click
- (void)loginButtonClick:(id)sender{
    if(isEditing){ 
        [userNameField resignFirstResponder];
        [passwordField resignFirstResponder];
        isEditing = NO;
    }
    
    if([userNameField.text isEqualToString:@""]){
        showHUDInfo(self,self.view,@"用户姓名不能为空");
        return;
    }
    
    if([passwordField.text isEqualToString:@""]){
        showHUDInfo(self,self.view,@"密码不能为空");
        return;
    }
    
    //[passwordField.text stringFromMD5]
    NSDictionary *Data = [NSDictionary dictionaryWithObjectsAndKeys:userNameField.text,@"LoginId",passwordField.text,@"PassWord",nil];
    
    LeblueRequest* req =[LeblueRequest requestWithHead:nwCode(Login) WithPostData:Data];
     
    
    [HttpAsynchronous httpPostWithRequestInfo:baseURL req:req sucessBlock:^(id result) {
        DebugLog(@"message:%@",((LeblueResponse*)result).message);
        DebugLog(@"records:%@",((LeblueResponse*)result).records);
        NSDictionary *dict = [((LeblueResponse*)result).records objectAtIndex:0];
        if([[dict objectForKey:@"UserId"] isEqualToString:@""]){
           appSession.userId = @"C96FC381-E587-494C-91C9-F84B6D9B90A3";
        }
        else{
            appSession.userId = [dict objectForKey:@"UserId"];
            if([[dict objectForKey:@"IsChild"] intValue]==1){
                appSession.userType = Child;
            }
            else if([[dict objectForKey:@"IsCompany"] intValue]==1){
                appSession.userType = Company;
                
            }
            else if([[dict objectForKey:@"IsEmployee"] intValue]==1){
                appSession.userType = Employee;
            }
            else if([[dict objectForKey:@"IsGov"] intValue]==1){
                appSession.userType = Gov;
            }
            else if([[dict objectForKey:@"IsOldMan"] intValue]==1){
                appSession.userType = OldMan; 
            }
            
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
        }
     
        [self dismissModalViewControllerAnimated:YES];
        // 
    } failedBlock:^(NSError *error) {
        // 
        DebugLog(@"%@",error);
    } completionBlock:^{
        //
    }];
    
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
        [userNameField becomeFirstResponder];
    }
}
-(void)inputAssistViewNextTapped:(UITextField*)aTextFiled{
    if (aTextFiled == userNameField) {
        [passwordField becomeFirstResponder];
    }
}

-(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled{ 
    [aTextFiled resignFirstResponder];
    isEditing = NO;
}

-(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled{
    if (aTextFiled == userNameField) {
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
