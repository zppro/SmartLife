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
    AOT_None,
    AOT_Member,
    AOT_Merchant
}AuthenticationObjectType;
 

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
}BizInterfaceType2;

typedef enum {
    AIT_Member,
    AIT_Merchant
}AuthenticationInterfaceType;

typedef enum {
    BIT_GetRelationNamesWithOldMan,
    BIT_GetEmergencyServices,
    BIT_GetServiceLogs,
    BIT_ResponseByFamilyMember,
    BIT_LogByFamilyMember,
    BIT_GetCallByOldMan
}BizInterfaceType;

typedef enum {
    ST_EmergencyService,//紧急救助
    ST_FamilyService,//亲人通话
    ST_InfotainmentService,//娱乐资讯
    ST_LifeService//生活服务
}ServiceType;
 

@class CCallService;

@interface AppSession : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AppSession);

@property (nonatomic) NetworkStatus networkStatus;


@property (nonatomic, retain) NSString *authId;
@property (nonatomic, retain) NSString *authName;
@property (nonatomic, retain) NSString *authToken;
@property (nonatomic) AuthenticationObjectType authType;
@property (nonatomic, retain) NSArray *authNodeInfos;


+ (BOOL)whetherIsDebug;

+ (AuthenticationInterfaceType) whichAuthenticationInterfaceType;

- (NSString*) getAuthUrl:(AuthenticationInterfaceType) aType;

- (NSString*) getBizUrl:(BizInterfaceType) aType withAccessPoint:(NSString*) accessPoint;

- (void) logText:(NSString*) logContent ToService:(CCallService*) callService  sucessBlock:(SuccessBlock)sucessBlock failedBlock:(FailedBlock)failedBlock completionBlock:(FinalBlock)completionBlock;

- (NSInteger)getNWCode:(BizInterfaceType2) biz;

- (void) abandon;

@end
