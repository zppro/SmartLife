//
//  CServiceLog.h
//  SmartLife
//
//  Created by zppro on 13-1-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CServiceLog : BaseModel

@property (nonatomic, retain) NSDate * localSyncTime;
@property (nonatomic, retain) NSNumber * localSyncFlag;

@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSString * logContent; 
@property (nonatomic, retain) NSString * callServiceId;
@property (nonatomic, retain) NSString * fetchByUserId;
@property (nonatomic, retain) NSString * serviceTracksLogId;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * logSoundFile;
@property (nonatomic, retain) NSString * logName;
@property (nonatomic, retain) NSString * serviceTracksId;



+ (NSArray *)listProcessActionByService:(NSString*) callServiceId;
+ (NSArray *)listProcessResponseByService:(NSString*) callServiceId;
+ (BOOL)updateWithData:(NSArray *)data ByService:(NSString*) callServiceId;

@end
