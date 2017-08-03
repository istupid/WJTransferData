//
//  TransferDataTests.m
//  TransferDataTests
//
//  Created by William on 2017/7/17.
//  Copyright © 2017年 William. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TransferManager.h"

@interface TransferDataTests : XCTestCase

@end

@implementation TransferDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data.json" ofType:nil];
    NSString *jsonStr = [TransferManager jsonStringWithFile:path];
    NSLog(@"%@", jsonStr);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        
    }];
}

@end
