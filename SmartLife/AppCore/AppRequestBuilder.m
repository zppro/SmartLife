//
//  AppRequestBuilder.m
//  SmartLife
//
//  Created by zppro on 13-7-15.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "AppRequestBuilder.h"

@implementation AppRequestBuilder

+(HttpAppRequest*)createWithHead:(NSDictionary*)head andBody:(NSDictionary*)body{
    
    HttpAppRequest *request = [HttpAppRequest requestWithHead:head andBody:body];
    [request.headData setValue:appId forKey:@"ApplicationId"];
    return request;
}
 
@end
