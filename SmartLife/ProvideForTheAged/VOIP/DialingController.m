//
//  DialingController.m
//  SmartLife
//
//  Created by zppro on 12-12-3.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "DialingController.h"

@interface DialingController ()
@property (nonatomic,retain) UITextField *searchField;
@end

@implementation DialingController
@synthesize searchField;
- (void)dealloc {
    self.searchField = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"拨号键盘";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.headerView.headerLabel.text = @"拨号键盘";
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(50.0/2,(93/2.f - 48.0/2.f)/2.f,450.f/2.f, 48.0/2)];
    searchField.font = [UIFont systemFontOfSize:17.f];
    searchField.textAlignment = UITextAlignmentCenter;
    searchField.keyboardType = UIKeyboardTypeDefault;
    searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.clearButtonMode = UITextFieldViewModeAlways;
    searchField.userInteractionEnabled = NO;
    searchField.text = @"";
    [self.containerView addSubview:searchField];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setFrame:CGRectMake(550/2.0,(93/2.f - 36.0/2.f)/2.f, 50/2.f, 36/2.f)];
    [deleteButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/delete.png") forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:deleteButton];
    
    UIView *bgDialView = makeView(0, 210/2.f, 320, (100+94+102+102)/2.f);
    [self.containerView addSubview:bgDialView];
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([DialingController class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgDialView addSubview:btn];
        }
    }

    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton setFrame:CGRectMake((160-266/2.f)/2.f,320.f, 266/2.f, 66/2.f)];
    [callButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/7.png") forState:UIControlStateNormal]; 
    [callButton addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:callButton]; 
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setFrame:CGRectMake(160+(160-266/2.f)/2.f,320.f, 266/2.f, 66/2.f)];
    [saveButton setImage:MF_PngOfDefaultSkin(@"ProvideForTheAged/VOIP/8.png") forState:UIControlStateNormal]; 
    [saveButton addTarget:self action:@selector(doSave:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:saveButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 按钮事件
- (void) doDelete:(id) sender{
    if(searchField.text.length == 0){
        return;
    }
    searchField.text = [searchField.text substringToIndex:searchField.text.length-1];
}


- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    
    switch (button.tag) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6: 
        case 7:
        case 8:
        case 9: {
            searchField.text =  MF_SWF(@"%@%d",searchField.text,button.tag);
            break; 
        }
        case 10: {
            searchField.text =  MF_SWF(@"%@*",searchField.text);
            break;
        }
        case 11:{
            searchField.text =  MF_SWF(@"%@0",searchField.text);
            break;
        }
        case 12:{
            searchField.text =  MF_SWF(@"%@#",searchField.text);
            break;
        }
        default:
            break;
    }
}

- (void) doCall:(id) sender{ 
}

- (void) doSave:(id) sender{ 
}
@end
