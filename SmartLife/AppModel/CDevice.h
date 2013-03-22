//
//  CDevice.h
//  SmartLife
//
//  Created by zppro on 13-3-22.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDevice : BaseModel

@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSString * deviceCode;
@property (nonatomic, retain) NSString * deviceName;
@property (nonatomic, retain) NSNumber * switchOnFlag;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSDate * localSyncTime;
@property (nonatomic, retain) NSNumber * localSyncFlag;
@property (nonatomic, retain) NSNumber * orderNo;

+ (NSArray *)listDevicesByUser:(NSString*) userId;

@end
