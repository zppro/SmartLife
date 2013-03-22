//
//  AppBaseController.h
//  iWedding
//
//  Created by 钟 平 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppBaseController : BaseController<TableHeaderDelegate>
@property (nonatomic, retain) UIView* containerView;
@property(nonatomic,retain) TableHeaderView *headerView;
@property (nonatomic,retain) UIView *footerView;
@property (nonatomic, readonly,assign) CGPoint containerDefaultCenter;
- (UIImage*) getFooterBackgroundImage;

@end
