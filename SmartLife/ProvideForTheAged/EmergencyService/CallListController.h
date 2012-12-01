//
//  CallListController.h
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@interface CallListController : AppBaseController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) NSArray                   *arrCalls;

@end
