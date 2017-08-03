//
//  TransferManager.m
//  TransferData
//
//  Created by William on 2017/7/15.
//  Copyright © 2017年 William. All rights reserved.
//

#import "TransferManager.h"

@implementation TransferManager

IMPLEMENTATION_SINGLETON(TransferManager)

#pragma mark class

+ (NSString *)jsonStringWithFile:(NSString *)path {
    return [[self sharedInstance] jsonStringWithFile:path];
}

#pragma mark - instance

- (NSString *)jsonStringWithURL:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [self jsonStringWithData:data];
}

- (NSString *)jsonStringWithFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self jsonStringWithData:data];
}

#pragma mark 

- (NSString *)jsonStringWithData:(NSData *)data {
    
    if (!data) {
        return nil;
    }
    
    id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    id transferObjc;
    if (objc) {
        if ([objc isKindOfClass: NSDictionary.class]) {
            
        }
        else if ([objc isKindOfClass: NSArray.class]) {
           transferObjc = [self wj_arrDictWithArrStr:objc split:@"||"];
        }
    }
    
    NSData *objcData = [NSJSONSerialization dataWithJSONObject:transferObjc options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:objcData encoding:NSUTF8StringEncoding];
}

// 一维数组元素 字符串 转 字典
- (NSArray *)wj_arrDictWithArrStr:(NSArray *)arr split:(NSString *)split {
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSArray *splitArr = [arr[i] componentsSeparatedByString:split];
        [self wj_mDictWithArray:splitArr mArray:mArray];
    }
    return mArray.copy;
}


// 一维数组 转 字典
- (NSDictionary *)wj_dictWithArray:(NSArray *)arr {
    if (arr && arr.count != 0) {
        NSInteger i = arr.count - 1;
        NSDictionary *dict = @{@"title" : arr[i--], @"items" : @[]};
        while (i >= 0) {
            dict = @{@"title" : arr[i--], @"items" : @[dict]};
        }
        return dict;
    }
    return nil;
}

// 一维数组 转 字典
- (void)wj_mDictWithArray:(NSArray *)arr mArray:(NSMutableArray *)mArray {
    if (arr && arr.count != 0) {
        NSInteger i = arr.count - 1;
        NSMutableDictionary *mDict = [self wj_mDictWithString:arr[i--] mDict:nil];
        while (i >= 0) {
            mDict = [self wj_mDictWithString:arr[i--] mDict:mDict];
        }
        
        if (mArray.count > 0) {
            BOOL flag = NO; // 默认都不相同
            for (int i = 0; i < mArray.count; i++) {
                if ([self dictCompareDict:mDict dictB:mArray[i]]) { // 有一个返回相同
                    flag = YES;
                    break;
                }
            }
            if (!flag) {
                [mArray addObject:mDict];   // 第一层不相同
            }
        } else { // 开始数组没有元素
            [mArray addObject:mDict];
        }
    }
}

// dictA 是新生成的数组中只有一个元素
- (BOOL)dictCompareDict:(NSDictionary *)dictA dictB:(NSDictionary *)dictB {
    if ([dictA[@"title"] isEqualToString:dictB[@"title"]]) {    // 第一层相同
        NSMutableArray *arrA = dictA[@"items"];
        NSMutableArray *arrB = dictB[@"items"];
        
        if (arrA.count == 0) {
            return YES;
        }
        NSDictionary *destDictA = arrA[0];
        
        if (arrB.count == 0) {
            [arrB addObject:destDictA];
            return YES;
        }
        
        BOOL flag = NO; // 默认相同
        for (int i = 0; i < arrB.count; i++) {
            NSDictionary *destDictB = arrB[i];
            if ([self dictCompareDict:destDictA dictB:destDictB]) {
                flag = YES;
                break;
            }
        }
        if (!flag) {
            [arrB addObject:destDictA];
        }

        return YES;
    } else {    // 第一层都不同
        return NO;
    }
}

// 根据数组的元素实例化可变字典
- (NSMutableDictionary *)wj_mDictWithString:(NSString *)str mDict:(NSMutableDictionary *)dict {
    NSMutableArray *mArray = nil;
    if (dict) {
        mArray = [NSMutableArray arrayWithObject:dict];
    } else {
        mArray = [NSMutableArray array];
    }
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithObjects:@[str,mArray] forKeys:@[@"title", @"items"]];
    return mDict;
}



@end
