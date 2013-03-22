//
//  CDevice.m
//  SmartLife
//
//  Created by zppro on 13-3-22.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CDevice.h"


@implementation CDevice

@dynamic deviceId;
@dynamic deviceCode;
@dynamic deviceName;
@dynamic switchOnFlag;
@dynamic userId;
@dynamic localSyncTime;
@dynamic localSyncFlag;
@dynamic orderNo;

+ (NSString*) localEntityKey{
    return @"deviceId";
}
+ (NSString*) dataSourceKey{
    return @"DeviceId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"deviceId", @"DeviceId",
            @"deviceCode",@"DeviceCode",
            @"deviceName", @"DeviceName",
            @"switchOnFlag", @"SwitchOnFlag",
            @"userId", @"UserId",
            @"localSyncFlag", @"LocalSyncFlag",
            @"localSyncTime", @"LocalSyncTime",
            @"orderNo", @"OrderNo",
            nil];
}

+ (NSArray *)listDevicesByUser:(NSString*) userId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"userId" equals:userId];
    return [CDevice fetchWithSortBy:@"orderNo" ascending:YES predicateWithFormat:builder.compoundPredicate.predicateFormat];
}

@end
