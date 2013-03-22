//
//  AppSession.h
//  SmartLife
//
//  Created by zppro on 12-12-18.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#define appSession [AppSession sharedInstance]

typedef enum {
    None,
    Child,
    Company,
    Employee,
    Gov,
    OldMan
}UserType;
 

typedef enum {
    Login,
    ReadListOfEmergencyService,
    ReadListOfCommunityService,
    ReadListOfLifeService,
    ReadListOfProcessing,
    ReadListOfCamera,
    DoResponse,
    RegisterDevice,
    SendServiceLog
}BizInterfaceType;

@interface AppSession : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AppSession);
@property (nonatomic) NetworkStatus networkStatus;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic) UserType userType;



- (NSInteger)getNWCode:(BizInterfaceType) biz;

- (void) abandon;

@end
