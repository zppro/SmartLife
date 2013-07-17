//
//  CServiceRecord.h
//  SmartLife
//
//  Created by zppro on 13-1-9.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CServiceRecord : BaseModel

@property (nonatomic, retain) NSString * callServiceId;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * buttonGlobalPathName;
@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * doResults;
@property (nonatomic, retain) NSNumber * doStatus;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * mobileNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * serviceLevel;
@property (nonatomic, retain) NSString * serviceObjectId;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * serviceTracksId;
@property (nonatomic, retain) NSString * fetchByUserId;
@property (nonatomic, retain) NSString * localSyncTime;
@property (nonatomic, retain) NSNumber * serviceType;
@property (nonatomic, retain) NSNumber * acceptStatus;

+ (NSArray *)listEmergencyServiceWithUserId:(NSString *)userId;
+ (NSArray *)listCommunityServiceNotReceivedWithUserId:(NSString *)userId;
+ (NSArray *)listCommunityServiceReceivedWithUserId:(NSString *)userId;
+ (NSArray *)listLifeServiceNotReceivedWithUserId:(NSString *)userId;
+ (NSArray *)listLifeServiceReceivedWithUserId:(NSString *)userId;
+ (BOOL)updateWithData:(NSArray *)data By:(NSString*) userId type:(ServiceType) type;
@end
