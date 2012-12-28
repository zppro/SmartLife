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
@synthesize userId;
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
        default:
            break;
    }
    
    return NWCode;
}

@end
