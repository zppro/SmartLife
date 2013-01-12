//
//  CUser.m
//  SmartLife
//
//  Created by zppro on 13-1-9.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CUser.h"


@implementation CUser

@dynamic userId;
@dynamic userName;
@dynamic password;
@dynamic lastLoginTime;

+ (NSString*) localEntityKey{
    return @"userId";
}
+ (NSString*) dataSourceKey{
    return @"UserId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"userId",@"UserId",
            @"userName", @"Name",
            @"password", @"Password",
            @"lastLoginTime", @"LastLoginTime",
            nil];
}


+ (CUser *)loadWithName:(NSString *)theUserName andPassword:(NSString*)thePassword{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"userName" equals:theUserName];
    [builder where:@"password" equals:thePassword]; 
    return [CUser fetchFirsWithPredicateFormat:builder.compoundPredicate.predicateFormat];
}



@end
