//
//  CMember.h
//  SmartLife
//
//  Created by zppro on 13-7-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CMember : BaseModel

@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * authNodeInfos;
@property (nonatomic, retain) NSString * memberName;
@property (nonatomic, retain) NSString * theIDNo;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSDate * lastCheckIn;
@property (nonatomic, retain) NSNumber * checkInCount;
@property (nonatomic, retain) NSDate * registerTime;
@property (nonatomic, retain) NSString * passwordHash;


+ (CMember *)loadWithIDNo:(NSString *)theIDNo andPasswordHash:(NSString*)thePasswordHash;


@end
