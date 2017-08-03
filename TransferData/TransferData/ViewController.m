//
//  ViewController.m
//  TransferData
//
//  Created by William on 2017/7/15.
//  Copyright © 2017年 William. All rights reserved.
//

#import "ViewController.h"
#import "TransferManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data.json" ofType:nil];
    NSString *jsonStr = [TransferManager jsonStringWithFile:path];
    
    NSLog(@"%@", jsonStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
