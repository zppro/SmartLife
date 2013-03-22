//
//  AppSession.m
//  SmartLife
//
//  Created by zppro on 12-12-18.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppSession.h"

@implementation AppSession
SYNTHESIZE_LESSER_SINGLETON_FOR_CLASS(AppSession);
@synthesize networkStatus;
@synthesize userId;
@synthesize userName;
@synthesize userType;

- (NSInteger)getNWCode:(BizInterfaceType) biz {
    NSInteger NWCode = -1;
    switch (biz) {
        case Login:{
            NWCode = 1;
            break;
        }
        case ReadListOfEmergencyService:
        {
            switch (userType) {
                case Child:
                {
                    NWCode = 2;
                    break;
                }
                case Company:
                {
                    NWCode = 9;
                    break;
                }
                case Employee:
                { 
                    break;
                }
                case Gov:
                {
                    NWCode = 6;
                    break;
                }
                case OldMan:
                { 
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfCommunityService:
        {
            switch (userType) {
                case Child:
                {
                    NWCode = 4;
                    break;
                }
                case Company:
                {
                    NWCode = 11;
                    break;
                }
                case Employee:
                { 
                    break;
                }
                case Gov:
                {
                    NWCode = 8;
                    break;
                }
                case OldMan:
                { 
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfLifeService:
        {
            switch (userType) {
                case Child:
                {
                    NWCode = 3;
                    break;
                }
                case Company:
                {
                    NWCode = 10;
                    break;
                }
                case Employee:
                { 
                    break;
                }
                case Gov:
                {
                    NWCode = 7;
                    break;
                }
                case OldMan:
                { 
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfProcessing:
        {
            NWCode = 12;
            break;
        }
        case ReadListOfCamera:
        {
            NWCode = 5;
            break;
        }
        case DoResponse:
        {
            NWCode = 108;
            break;
        }
        case RegisterDevice:{
            NWCode = 101;
            break;
        }
        case SendServiceLog:{
            NWCode = 106;
            break;
        }
        default:
            break;
    }
    
    return NWCode;
}

- (void) abandon{
    self.userId = nil;
    self.userName = nil;
    self.userType = None;
}

@end
