//
//  ProvideForTheAgedController.m
//  SmartLife
//
//  Created by zppro on 12-11-24.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "ProvideForTheAgedIndexController.h"
#import "CallListController.h"

@interface ProvideForTheAgedIndexController ()

@end

@implementation ProvideForTheAgedIndexController
 

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
    
    self.headerView.headerLabel.text = @"养老服务"; 
    UIView *indexMenu = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.height, self.view.bounds.size.width, self.view.bounds.size.height - self.headerView.height)];
    UIImageView *bgView = makeImageView(0, 0, indexMenu.width, indexMenu.height);
    bgView.image = MF_PngOfDefaultSkin(@"Index/bg.png");
    [indexMenu addSubview:bgView];
    
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([self class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [indexMenu addSubview:btn];
        }
    }
    [self.view addSubview:indexMenu];

    [indexMenu release];
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
    
    switch (button.tag) {
        case 1:{
            [self navigationTo:[[[CallListController alloc] init] autorelease]];
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
        default:
            break;
    }
}

@end
