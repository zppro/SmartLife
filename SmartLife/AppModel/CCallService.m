//
//  CCallService.m
//  SmartLife
//
//  Created by zppro on 13-7-16.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CCallService.h"


@implementation CCallService

@dynamic callServiceId;
@dynamic checkInTime;
@dynamic content;
@dynamic longitudeS;
@dynamic latitudeS;
@dynamic doStatus;
@dynamic doResults;
@dynamic oldManId;
@dynamic belongMemberId;
@dynamic belongFamilyMemberId;
@dynamic serviceType;
@dynamic areaId;
@dynamic localSyncTime;
@dynamic responseFlag;
@dynamic oldManName;
@dynamic accessPoint;

+ (NSString*) localEntityKey{
    return @"callServiceId";
}
+ (NSString*) dataSourceKey{
    return @"CallServiceId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"callServiceId",@"CallServiceId",
            @"checkInTime", @"CheckInTime",
            @"content", @"Content",
            @"longitudeS", @"LongitudeS",
            @"latitudeS", @"latitudeS",
            @"doStatus", @"DoStatus",
            @"doResults", @"DoResults",
            @"oldManId", @"OldManId",
            @"belongMemberId", @"BelongMemberId",
            @"belongFamilyMemberId", @"BelongFamilyMemberId",
            @"serviceType", @"ServiceType",
            @"areaId", @"AreaId",
            @"localSyncTime", @"LocalSyncTime",
            @"responseFlag", @"ResponseFlag",
            @"oldManName", @"OldManName",
            @"accessPoint", @"AccessPoint",
            nil];
}

+ (NSArray *)listEmergencyServiceWithMemberId:(NSString *)memberId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"belongMemberId" equals:memberId];
    [builder where:@"serviceType" equals:NI(ST_EmergencyService)];
    return [CCallService fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}

+ (BOOL)updateWithData:(NSArray *)data By:(NSString*) memberId type:(ServiceType) type{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"belongMemberId" equals:memberId];
    [builder where:@"serviceType" equals:NI(type)];
    return [CCallService updateWithData:data EntityKey:[CCallService localEntityKey] IEntityKey:[CCallService dataSourceKey] fethchFormat:builder.compoundPredicate.predicateFormat];
}

@end
