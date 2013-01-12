//
//  LifeServiceAcceptOrderSuccessController.h
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@class CServiceRecord;

@interface LifeServiceAcceptOrderSuccessController : AppBaseController<TableHeaderDelegate>
-(id)initWithServiceRecord:(CServiceRecord*)aServiceRecord;
@end
