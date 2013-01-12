//
//  CUser.h
//  SmartLife
//
//  Created by zppro on 13-1-9.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CUser : BaseModel

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * lastLoginTime;
 
+ (CUser *)loadWithName:(NSString *)theUserName andPassword:(NSString*)thePassword;

@end
