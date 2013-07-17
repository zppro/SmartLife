//
//  CServiceLog.m
//  SmartLife
//
//  Created by zppro on 13-7-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CServiceLog.h"


@implementation CServiceLog

@dynamic callServiceId;
@dynamic checkInTime;
@dynamic belongFamilyMemberId;
@dynamic localSyncFlag;
@dynamic localSyncTime;
@dynamic logContent;
@dynamic logFile;
@dynamic logId;
@dynamic logType;
@dynamic belongMemberId;
@dynamic logFileType;


+ (NSString*) localEntityKey{
    return @"logId";
}
+ (NSString*) dataSourceKey{
    return @"LogId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"callServiceId", @"CallServiceId",
            @"checkInTime",@"CheckInTime",
            @"belongFamilyMemberId", @"belongFamilyMemberId",
            @"localSyncFlag", @"localSyncFlag",
            @"localSyncTime", @"localSyncTime", 
            @"logContent", @"LogContent",
            @"logFile", @"LogFile",
            @"logId", @"LogId",
            @"logType", @"LogType",
            @"belongMemberId", @"BelongMemberId",
            @"logFileType", @"LogFileType",
            nil];
}

+ (NSArray *)listByService:(NSString*) callServiceId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"callServiceId" equals:callServiceId];
    [builder where:@"logType" equals:NI(0)];
    return [CServiceLog fetchWithSortBy:@"checkInTime" ascending:YES predicateWithFormat:builder.compoundPredicate.predicateFormat];
}
+ (BOOL)updateWithData:(NSArray *)data ByService:(NSString*) callServiceId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"callServiceId" equals:callServiceId];
    return [CServiceLog updateWithData:data EntityKey:[CServiceLog localEntityKey] IEntityKey:[CServiceLog dataSourceKey] fethchFormat:builder.compoundPredicate.predicateFormat];
}
@end
