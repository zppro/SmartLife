//
//  RescueController.h
//  SmartLife
//
//  Created by zppro on 12-11-27.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppBaseController.h"

@class CServiceRecord;

@interface RescueController : AppBaseController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,DDPageControlDelegate,EGORefreshTableHeaderDelegate,UITextFieldDelegate,AVAudioPlayerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate>
@property (nonatomic, retain) NSArray                   *arrProcessActions;
@property (nonatomic, retain) NSArray                   *arrProcessResponses;

-(id)initWithServiceRecord:(CServiceRecord*)aServiceRecord;
@end
