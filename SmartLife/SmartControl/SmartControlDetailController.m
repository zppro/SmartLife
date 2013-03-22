//
//  SmartControlDetailController.m
//  SmartLife
//
//  Created by zppro on 13-3-22.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "SmartControlDetailController.h"
#import "CDevice.h"

@interface SmartControlDetailController ()
@property (nonatomic, retain) CDevice  *device;
@end

@implementation SmartControlDetailController
@synthesize device;

- (void)dealloc {
    self.device = nil;
    [super dealloc];
}
-(id)initWithDevice:(CDevice*)aDevice{
    self = [super init];
    if (self)
    {
        self.device = aDevice;
    }
    return self;
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.headerView.headerLabel.text = JOIN(@"智能控制 - ", self.device.deviceName) ;
      
    SkinContainer *container = [[[SkinManager sharedInstance] currentSkin] getContainer:NSStringFromClass([self class])];
    for (SkinElement *skinElement in container.elements) {
        if ([skinElement.elementType isEqualToString:NSStringFromClass([UIButton class])]) {
            UIButton *btn = [skinElement generateObject];
            [btn addTarget:self action:@selector(moduleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.containerView addSubview:btn];
        }
    } 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) moduleClick:(id) sender{
    UIButton *button = (UIButton*) sender;
    [button scaleMe2D];
    
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
        default:
            break;
    }
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark -TableHeaderDelegate
- (void)backButtonOnClickWithPOPVC {
    [self dismissModalViewControllerAnimated:YES];
}

@end
