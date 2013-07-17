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
    AOT_Member
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
    AIT_Member
}AuthenticationInterfaceType;

typedef enum {
    BIT_GetEmergencyServices,
    BIT_GetServiceLogs,
    BIT_ResponseByFamilyMember
}BizInterfaceType;

typedef enum {
    ST_EmergencyService,//紧急救助
    ST_FamilyService,//亲人通话
    ST_InfotainmentService,//娱乐资讯
    ST_LifeService//生活服务
}ServiceType;

@interface AppSession : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AppSession);

@property (nonatomic) NetworkStatus networkStatus;


@property (nonatomic, retain) NSString *authId;
@property (nonatomic, retain) NSString *authName;
@property (nonatomic, retain) NSString *authToken;
@property (nonatomic) AuthenticationObjectType authType;
@property (nonatomic, retain) NSArray *authNodeInfos;

+ (BOOL)whetherIsDebug;

- (NSString*) getAuthUrl:(AuthenticationInterfaceType) aType;

- (NSString*) getBizUrl:(BizInterfaceType) aType withAccessPoint:(NSString*) accessPoint;

- (NSInteger)getNWCode:(BizInterfaceType2) biz;

- (void) abandon;

@end
