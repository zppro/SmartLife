//
//  RescueController.h
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@interface RescueController : AppBaseController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,DDPageControlDelegate>
@property (nonatomic, retain) NSArray                   *arrProcessActions;
@property (nonatomic, retain) NSArray                   *arrProcessResponses;
@end