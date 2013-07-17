//
//  CCallService.h
//  SmartLife
//
//  Created by zppro on 13-7-16.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CCallService : BaseModel

@property (nonatomic, retain) NSString * callServiceId;
@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * longitudeS;
@property (nonatomic, retain) NSString * latitudeS;
@property (nonatomic, retain) NSNumber * doStatus;
@property (nonatomic, retain) NSString * doResults;
@property (nonatomic, retain) NSString * oldManId;
@property (nonatomic, retain) NSString * belongMemberId;
@property (nonatomic, retain) NSString * belongFamilyMemberId;
@property (nonatomic, retain) NSNumber * serviceType;
@property (nonatomic, retain) NSString * areaId;
@property (nonatomic, retain) NSDate * localSyncTime;
@property (nonatomic, retain) NSNumber * responseFlag;
@property (nonatomic, retain) NSString * oldManName;
@property (nonatomic, retain) NSString * accessPoint;

+ (NSArray *)listEmergencyServiceWithMemberId:(NSString *)memberId;
+ (BOOL)updateWithData:(NSArray *)data By:(NSString*) memberId type:(ServiceType) type;
@end
