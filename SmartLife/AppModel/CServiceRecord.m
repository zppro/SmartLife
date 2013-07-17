//
//  CServiceRecord.m
//  SmartLife
//
//  Created by zppro on 13-1-9.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CServiceRecord.h"


@implementation CServiceRecord

@dynamic callServiceId;
@dynamic address;
@dynamic birthday;
@dynamic buttonGlobalPathName;
@dynamic checkInTime;
@dynamic content;
@dynamic doResults;
@dynamic doStatus;
@dynamic gender;
@dynamic latitude;
@dynamic longitude;
@dynamic mobileNumber;
@dynamic name;
@dynamic serviceLevel;
@dynamic serviceObjectId;
@dynamic tel;
@dynamic zipCode;
@dynamic serviceTracksId;
@dynamic fetchByUserId;
@dynamic localSyncTime;
@dynamic serviceType;
@dynamic acceptStatus;

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
            @"address", @"Address",
            @"birthday", @"Birthday",
            @"buttonGlobalPathName", @"ButtonGlobalPathName",
            @"checkInTime", @"CheckInTime",
            @"content", @"Content",
            @"doResults", @"DoResults",
            @"doStatus", @"DoStatus",
            @"gender", @"Gender",
            @"latitude", @"Latitude",
            @"longitude", @"Longitude",
            @"mobileNumber", @"MobileNumber",
            @"name", @"Name",
            @"serviceLevel", @"ServiceLevel",
            @"serviceObjectId", @"ServiceObjectId",
            @"tel", @"Tel",
            @"zipCode", @"ZipCode",
            @"serviceTracksId", @"ServiceTracksId",
            @"fetchByUserId", @"FetchByUserId",
            @"localSyncTime", @"LocalSyncTime",
            @"serviceType", @"ServiceType",
            @"acceptStatus", @"AcceptStatus",
            nil];
}

+ (NSArray *)listEmergencyServiceWithUserId:(NSString *)userId{ 
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(ST_EmergencyService)];
    return [CServiceRecord fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}
+ (NSArray *)listCommunityServiceNotReceivedWithUserId:(NSString *)userId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(ST_InfotainmentService)];
    [builder where:@"acceptStatus" equals:NI(0)];
    return [CServiceRecord fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}
+ (NSArray *)listCommunityServiceReceivedWithUserId:(NSString *)userId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(ST_InfotainmentService)];
    [builder where:@"acceptStatus" greaterThan:NI(0)];
    return [CServiceRecord fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat];
}
+ (NSArray *)listLifeServiceNotReceivedWithUserId:(NSString *)userId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(ST_LifeService)];
    [builder where:@"acceptStatus" equals:NI(0)];
    return [CServiceRecord fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat]; 
}

+ (NSArray *)listLifeServiceReceivedWithUserId:(NSString *)userId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(ST_LifeService)];
    [builder where:@"acceptStatus" greaterThan:NI(0)];
    return [CServiceRecord fetchWithSortBy:@"checkInTime" ascending:NO predicateWithFormat:builder.compoundPredicate.predicateFormat]; 
}

+ (BOOL)updateWithData:(NSArray *)data By:(NSString*) userId type:(ServiceType) type{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"fetchByUserId" equals:userId];
    [builder where:@"serviceType" equals:NI(type)];
    return [CServiceRecord updateWithData:data EntityKey:[CServiceRecord localEntityKey] IEntityKey:[CServiceRecord dataSourceKey] fethchFormat:builder.compoundPredicate.predicateFormat];
}

@end
