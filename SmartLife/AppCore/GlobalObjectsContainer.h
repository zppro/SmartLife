//
//  GlobalObjectsContainer.h
//  iWedding
//
//  Created by 钟 平 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define goc [GlobalObjectsContainer sharedInstance] 

@interface GlobalObjectsContainer : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(GlobalObjectsContainer);

@property (nonatomic, retain) NSString* skinName;

@end
