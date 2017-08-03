//
//  TransferManager.h
//  TransferData
//
//  Created by William on 2017/7/15.
//  Copyright © 2017年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJSingleton.h"

@interface TransferManager : NSObject

INTERFACE_SINGLETON(TransferManager)

- (NSString *)jsonStringWithFile:(NSString *)path;

- (NSString *)jsonStringWithURL:(NSURL *)url;

+ (NSString *)jsonStringWithFile:(NSString *)path;

@end
