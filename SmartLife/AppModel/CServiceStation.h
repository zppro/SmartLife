//
//  CServiceStation.h
//  SmartLife
//
//  Created by zppro on 13-9-23.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CServiceStation : BaseModel

@property (nonatomic, retain) NSString * authNodeInfos;
@property (nonatomic, retain) NSString * passwordHash;
@property (nonatomic, retain) NSString * stationCode;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSDate * lastCheckIn;

+ (CServiceStation *)loadWithStationCode:(NSString *)theStationCode andPasswordHash:(NSString*)thePasswordHash;


@end
