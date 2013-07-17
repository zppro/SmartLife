//
//  AppRequestBuilder.h
//  SmartLife
//
//  Created by zppro on 13-7-15.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRequestBuilder : NSObject

+(HttpAppRequest*)createWithHead:(NSDictionary*)head andBody:(NSDictionary*)body;

@end
