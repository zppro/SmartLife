//
//  HomeController.m
//  SmartLife
//
//  Created by zppro on 12-11-20.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "HomeController.h"


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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    
    [button retain];
    [button scaleMe2D];
    
    
}
@end
