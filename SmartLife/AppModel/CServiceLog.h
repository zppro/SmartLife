//
//  CServiceLog.h
//  SmartLife
//
//  Created by zppro on 13-7-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CServiceLog : BaseModel

@property (nonatomic, retain) NSString * callServiceId;
@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSString * belongFamilyMemberId;
@property (nonatomic, retain) NSNumber * localSyncFlag;
@property (nonatomic, retain) NSDate * localSyncTime;
@property (nonatomic, retain) NSString * logContent;
@property (nonatomic, retain) NSString * logFile;
@property (nonatomic, retain) NSString * logId;
@property (nonatomic, retain) NSNumber * logType;
@property (nonatomic, retain) NSString * belongMemberId;
@property (nonatomic, retain) NSString * logFileType;

+ (NSArray *)listByService:(NSString*) callServiceId; 
+ (BOOL)updateWithData:(NSArray *)data ByService:(NSString*) callServiceId;

@end
