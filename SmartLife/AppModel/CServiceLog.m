//
//  CServiceLog.m
//  SmartLife
//
//  Created by zppro on 13-1-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CServiceLog.h"


@implementation CServiceLog
@dynamic localSyncTime;
@dynamic localSyncFlag;

@dynamic checkInTime;
@dynamic logContent; 
@dynamic callServiceId;
@dynamic fetchByUserId;
@dynamic serviceTracksLogId;
@dynamic type;
@dynamic logSoundFile;
@dynamic logName;
@dynamic serviceTracksId;

+ (NSString*) localEntityKey{
    return @"serviceTracksLogId";
}
+ (NSString*) dataSourceKey{
    return @"ServiceTracksLogId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"localSyncFlag", @"LocalSyncFlag",
            @"checkInTime",@"CheckInTime",
            @"logContent", @"LogContent",
            @"callServiceId", @"CallServiceId",
            @"fetchByUserId", @"LogPersonId",
            @"serviceTracksLogId", @"ServiceTracksLogId",
            @"type", @"Type",
            @"logSoundFile", @"LogSoundFile",
            @"logName", @"LogName",
            @"serviceTracksId", @"ServiceTracksId",
            nil];
}

+ (NSArray *)listProcessActionByService:(NSString*) callServiceId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease]; 
    [builder where:@"callServiceId" equals:callServiceId];
    [builder where:@"type" equals:NI(0)];
    return [CServiceLog fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}

+ (NSArray *)listProcessResponseByService:(NSString*) callServiceId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"callServiceId" equals:callServiceId];
    [builder where:@"type" equals:NI(1)];
    return [CServiceLog fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}

+ (BOOL)updateWithData:(NSArray *)data ByService:(NSString*) callServiceId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"callServiceId" equals:callServiceId]; 
    return [CServiceLog updateWithData:data EntityKey:[CServiceLog localEntityKey] IEntityKey:[CServiceLog dataSourceKey] fethchFormat:builder.compoundPredicate.predicateFormat];
}

@end
