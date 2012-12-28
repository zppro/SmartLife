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
    ReadListOfProcessing
}BizInterfaceType;

@interface AppSession : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AppSession);

@property (nonatomic, retain) NSString *userId;
@property (nonatomic) UserType userType;

- (NSInteger)getNWCode:(BizInterfaceType) biz;

@end
