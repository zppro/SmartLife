//
//  RegisterController.m
//  SmartLife
//
//  Created by zppro on 13-3-21.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "RegisterController.h"
#import "SVSegmentedControl.h"

@interface RegisterController (){
        BOOL isEditing;
        UITextField *activeField;
}
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *cellPhoneField;
@property (nonatomic,retain) SVSegmentedControl *genderSC;
@property (nonatomic,retain) UITextField *mailField;
@property (nonatomic,retain) UITextField *passwordField;
@property (nonatomic,retain) UITextField *password2Field;
@property (nonatomic,retain) UITextField *codeField;
@property (nonatomic,retain) UIButton *registerButton;
@end

@implementation RegisterController
@synthesize nameField;
@synthesize cellPhoneField;
@synthesize genderSC;
@synthesize mailField;
@synthesize passwordField;
@synthesize password2Field;
@synthesize codeField;
@synthesize registerButton;

- (void)dealloc {
    self.nameField = nil;
    self.cellPhoneField = nil;
    self.mailField = nil;
    self.passwordField = nil;
    self.password2Field = nil;
    self.codeField = nil;
    self.registerButton = nil;
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
    self.headerView.headerLabel.text = @"注册账号";
    
    
    UILabel *nameLabel = makeLabel(40.0/2.f, 40.0/2.f, 180.0/2.f, 48.0/2.f);
    //valueName.textColor = MF_ColorFromRGB(140, 137, 111);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:18.0f];
    nameLabel.textAlignment = UITextAlignmentRight;
    nameLabel.text = @"姓名:";
    [self.containerView addSubview:nameLabel];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,40/2.f,300.f/2.f, 48.0/2)];
    nameField.font = [UIFont systemFontOfSize:18];
    nameField.keyboardType = UIKeyboardTypeDefault;
    nameField.keyboardAppearance = UIKeyboardAppearanceDefault;
    nameField.delegate = self;
    nameField.backgroundColor = [UIColor clearColor];
    nameField.borderStyle = UITextBorderStyleBezel;
    //userNameField.placeholder = NSLocalizedString(@"RegisterController_EntPhoneNo", nil);
    nameField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:nameField style:CInputAssistViewAll];
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.tag = 201;
    [self.containerView addSubview:nameField];
     
    UILabel *cellPhoneLabel = makeLabel(40.0/2.f, 128.0/2.f, 180.0/2.f, 48.0/2.f);
    cellPhoneLabel.backgroundColor = [UIColor clearColor];
    cellPhoneLabel.font = [UIFont systemFontOfSize:18.0f];
    cellPhoneLabel.textAlignment = UITextAlignmentRight;
    cellPhoneLabel.text = @"手机:";
    [self.containerView addSubview:cellPhoneLabel];
    
    cellPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,128.0/2.f,300.f/2.f, 48.0/2)];
    cellPhoneField.font = [UIFont systemFontOfSize:18];
    cellPhoneField.keyboardType = UIKeyboardTypeDefault;
    cellPhoneField.keyboardAppearance = UIKeyboardTypePhonePad;
    cellPhoneField.delegate = self;
    cellPhoneField.backgroundColor = [UIColor clearColor];
    cellPhoneField.borderStyle = UITextBorderStyleBezel; 
    cellPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cellPhoneField.returnKeyType = UIReturnKeyDone;
    cellPhoneField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:cellPhoneField style:CInputAssistViewAll];
    cellPhoneField.tag = 202;
    [self.containerView addSubview:cellPhoneField];

    UILabel *genderLabel = makeLabel(40.0/2.f, 226.0/2.f, 180.0/2.f, 48.0/2.f);
    genderLabel.backgroundColor = [UIColor clearColor];
    genderLabel.font = [UIFont systemFontOfSize:18.0f];
    genderLabel.textAlignment = UITextAlignmentRight;
    genderLabel.text = @"性别:";
    [self.containerView addSubview:genderLabel];
    
    genderSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:NSLocalizedString(@"男", nil), NSLocalizedString(@"女", nil), nil]];
    genderSC.thumb.tintColor = MF_ColorFromRGB(202, 88, 78);
    genderSC.height = 23;
    genderSC.font = [UIFont systemFontOfSize:18];
    genderSC.selectedIndex = 0;
    genderSC.selectedSegmentChangedHandler = ^(id sender) {
        //SVSegmentedControl *segmentedControl = (SVSegmentedControl *)sender;
    };
    [self.containerView addSubview:genderSC];
    [genderSC release];
    genderSC.center = CGPointMake(170, 125);
    
    UILabel *mailLabel = makeLabel(40.0/2.f, 324.0/2.f, 180.0/2.f, 48.0/2.f);
    mailLabel.backgroundColor = [UIColor clearColor];
    mailLabel.font = [UIFont systemFontOfSize:18.0f];
    mailLabel.textAlignment = UITextAlignmentRight;
    mailLabel.text = @"邮箱:";
    [self.containerView addSubview:mailLabel];
    
    mailField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,324.0/2.f,300.f/2.f, 48.0/2)];
    mailField.font = [UIFont systemFontOfSize:18];
    mailField.keyboardType = UIKeyboardTypeDefault; 
    mailField.keyboardAppearance = UIKeyboardTypeEmailAddress;
    mailField.delegate = self;
    mailField.backgroundColor = [UIColor clearColor];
    mailField.borderStyle = UITextBorderStyleBezel; 
    mailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    mailField.returnKeyType = UIReturnKeyDone;
    mailField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:mailField style:CInputAssistViewAll];
    mailField.tag = 203;
    [self.containerView addSubview:mailField];
    
    UILabel *passwordLabel = makeLabel(40.0/2.f, 442.0/2.f, 180.0/2.f, 48.0/2.f);
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.font = [UIFont systemFontOfSize:18.0f];
    passwordLabel.textAlignment = UITextAlignmentRight;
    passwordLabel.text = @"输入密码:";
    [self.containerView addSubview:passwordLabel];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,442.0/2.f,300.f/2.f, 48.0/2)];
    passwordField.font = [UIFont systemFontOfSize:18];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.secureTextEntry = YES;
    passwordField.keyboardAppearance = UIKeyboardAppearanceDefault;
    passwordField.delegate = self;
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.borderStyle = UITextBorderStyleBezel;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:passwordField style:CInputAssistViewAll];
    passwordField.tag = 204;
    [self.containerView addSubview:passwordField];
    
    UILabel *password2Label = makeLabel(40.0/2.f, 540.0/2.f, 180.0/2.f, 48.0/2.f);
    password2Label.backgroundColor = [UIColor clearColor];
    password2Label.font = [UIFont systemFontOfSize:18.0f];
    password2Label.textAlignment = UITextAlignmentRight;
    password2Label.text = @"确认密码:";
    [self.containerView addSubview:password2Label];
    
    password2Field = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,540.0/2.f,300.f/2.f, 48.0/2)];
    password2Field.font = [UIFont systemFontOfSize:18];
    password2Field.keyboardType = UIKeyboardTypeDefault;
    password2Field.secureTextEntry = YES;
    password2Field.keyboardAppearance = UIKeyboardAppearanceDefault;
    password2Field.delegate = self;
    password2Field.backgroundColor = [UIColor clearColor];
    password2Field.borderStyle = UITextBorderStyleBezel;
    password2Field.clearButtonMode = UITextFieldViewModeWhileEditing;
    password2Field.returnKeyType = UIReturnKeyDone;
    password2Field.inputAccessoryView = [CInputAssistView createWithDelegate:self target:password2Field style:CInputAssistViewAll];
    password2Field.tag = 205;
    [self.containerView addSubview:password2Field];
    
    UILabel *codeLabel = makeLabel(40.0/2.f, 638.0/2.f, 180.0/2.f, 48.0/2.f);
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.font = [UIFont systemFontOfSize:18.0f];
    codeLabel.textAlignment = UITextAlignmentRight;
    codeLabel.text = @"验证码:";
    [self.containerView addSubview:codeLabel];
    
    codeField = [[UITextField alloc] initWithFrame:CGRectMake(240.0/2,638.0/2.f,150.f/2.f, 48.0/2)];
    codeField.font = [UIFont systemFontOfSize:18];
    codeField.keyboardType = UIKeyboardTypeDefault;
    codeField.keyboardAppearance = UIKeyboardAppearanceDefault;
    codeField.delegate = self;
    codeField.backgroundColor = [UIColor clearColor];
    codeField.borderStyle = UITextBorderStyleBezel;
    codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeField.returnKeyType = UIReturnKeyDone;
    codeField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:codeField style:CInputAssistViewAll];
    codeField.tag = 206;
    [self.containerView addSubview:codeField];
    
    self.registerButton = makeButton((640-151)/4.f,720/2.f,151.f/2.f, 62.0/2);
    [registerButton setImage:MF_PngOfDefaultSkin(@"Index/register_01.png") forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:registerButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage*) getFooterBackgroundImage{
    return nil;
}

- (void)tapContainerView:(UIGestureRecognizer *)gestureRecognizer{
    
    if(isEditing){
        [self.containerView moveMeTo:self.containerDefaultCenter];
        [activeField resignFirstResponder];
        isEditing =  NO;
        //gestureRecognizer.cancelsTouchesInView = NO;
    }
}


#pragma mark - button click
- (void)registerButtonClick:(id)sender{
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    activeField = textField;
      
    if(activeField.center.y - nameField.center.y > 0){
        int span = activeField.center.y - cellPhoneField.center.y>0?1:0;
        int yDelta = (span+activeField.tag - nameField.tag)*88.0/2.f;
        DebugLog(@"%d",yDelta);
        [self.containerView moveMeTo:CGPointMake(self.containerDefaultCenter.x, self.containerDefaultCenter.y-yDelta)];
    }
    else{
        [self.containerView moveMeTo:self.containerDefaultCenter];
    }
    if(isEditing){
        return;
    }
    //CGPoint upCenter = CGPointMake(self.bodyView.center.x, self.bodyView.center.y - 120);
    //[self.bodyView moveMeTo:upCenter];
    isEditing = YES;
    
}

// done button pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < codeField.tag) {
        [self.containerView moveMeTo:self.containerDefaultCenter];
        [self performSelector:@selector(registerButtonClick:) withObject:textField];
        isEditing = NO;
    }
    
    return YES;
}

#pragma mark - CInputAssistViewDelgate Method
-(void)inputAssistViewPerviousTapped:(UITextField*)aTextFiled{
    if (aTextFiled.tag > nameField.tag) {
        [[self.containerView viewWithTag:(aTextFiled.tag - 1)] becomeFirstResponder];
    }
}
-(void)inputAssistViewNextTapped:(UITextField*)aTextFiled{
    if (aTextFiled.tag < codeField.tag) {
        [[self.containerView viewWithTag:(aTextFiled.tag + 1)] becomeFirstResponder];
    }
}

-(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled{
    [aTextFiled resignFirstResponder];
    [self.containerView moveMeTo:self.containerDefaultCenter];
    isEditing = NO;
}

-(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled{
    if (aTextFiled.tag < codeField.tag) {
        [[self.containerView viewWithTag:(aTextFiled.tag + 1)] becomeFirstResponder];
    } else {
        [self.containerView moveMeTo:self.containerDefaultCenter];
        [self performSelector:@selector(registerButtonClick:) withObject:aTextFiled];
        isEditing = NO;
    }
}

@end
