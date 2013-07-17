//
//  CMember.m
//  SmartLife
//
//  Created by zppro on 13-7-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CMember.h"


@implementation CMember

@dynamic memberId;
@dynamic token;
@dynamic authNodeInfos;
@dynamic memberName;
@dynamic theIDNo;
@dynamic mobile;
@dynamic email;
@dynamic gender;
@dynamic lastCheckIn;
@dynamic checkInCount;
@dynamic registerTime;
@dynamic passwordHash;


+ (NSString*) localEntityKey{
    return @"memberId";
}
+ (NSString*) dataSourceKey{
    return @"MemberId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"memberId",@"MemberId",
            @"token", @"Token",
            @"authNodeInfos", @"AuthNodeInfos",
            @"memberName", @"Name",
            @"theIDNo", @"IDNo",
            @"mobile", @"Mobile",
            @"email", @"Email",
            @"gender", @"Gender",
            @"lastCheckIn", @"LastCheckIn",
            @"checkInCount", @"CheckInCount",
            @"registerTime", @"RegisterTime",
            @"passwordHash", @"PasswordHash",
            nil];
}


+ (CMember *)loadWithIDNo:(NSString *)theIDNo andPasswordHash:(NSString*)thePasswordHash{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"theIDNo" equals:theIDNo];
    [builder where:@"passwordHash" equals:thePasswordHash];
    return [CMember fetchFirsWithPredicateFormat:builder.compoundPredicate.predicateFormat];
}
@end
