//
//  LifeServiceAcceptOrderController.h
//  SmartLife
//
//  Created by zppro on 12-12-4.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@interface LifeServiceAcceptOrderController : AppBaseController<TableHeaderDelegate>
-(id)initWithOrderInfo:(NSDictionary*)orderInfo;
@end
