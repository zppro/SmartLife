//
//  HomeController.m
//  SmartLife
//
//  Created by zppro on 12-11-20.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
#import "ProvideForTheAgedIndexController.h"


@interface HomeController ()

@end

@implementation HomeController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *mainMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
          
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([self class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainMenu addSubview:btn];
        }
    } 
    [self.view addSubview:mainMenu];
    [mainMenu release];
    
    BOOL isSignIn = FALSE;
    if(!isSignIn){ 
        LoginController *loginController = [[LoginController alloc] init];
        [self presentModalViewController:loginController animated: YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 子类重写方法
- (UIImage*) getHeaderBackgroundImage{
    return nil;
}
- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark 按钮事件
- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    [button scaleMe2D];
    
    switch (button.tag) {
        case 1:{
             break;
        }
        case 2: { 
            [self navigationTo:[[[ProvideForTheAgedIndexController alloc] init] autorelease]];
            break;
        }
        case 3: {
            break;
        }
        case 4:{
            break;
        }
        default:
            break;
    }

}
@end
