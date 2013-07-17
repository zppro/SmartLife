//
//  RescueController.h
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@class CCallService;

@interface RescueController : AppBaseController<UITableViewDelegate, UITableViewDataSource,EGORefreshTableHeaderDelegate>
@property (nonatomic, retain) NSArray                   *arrLogs; 

-(id)initWithCallService:(CCallService*)aCallService;

@end
