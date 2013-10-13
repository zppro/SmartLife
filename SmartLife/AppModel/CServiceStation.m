//
//  CServiceStation.m
//  SmartLife
//
//  Created by zppro on 13-9-23.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CServiceStation.h"


@implementation CServiceStation

@dynamic authNodeInfos;
@dynamic passwordHash;
@dynamic stationCode;
@dynamic stationName;
@dynamic token;
@dynamic lastCheckIn;

+ (NSString*) localEntityKey{
    return @"stationCode";
}
+ (NSString*) dataSourceKey{
    return @"StationCode";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"authNodeInfos", @"AuthNodeInfos",
            @"passwordHash", @"PasswordHash",
            @"stationCode",@"StationCode",
            @"stationName", @"StationName",
            @"token", @"Token",
            @"lastCheckIn", @"LastCheckIn",
            nil];
}


+ (CServiceStation *)loadWithStationCode:(NSString *)theStationCode andPasswordHash:(NSString*)thePasswordHash{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"stationCode" equals:theStationCode];
    [builder where:@"passwordHash" equals:thePasswordHash];
    return [CServiceStation fetchFirsWithPredicateFormat:builder.compoundPredicate.predicateFormat];
}

@end
