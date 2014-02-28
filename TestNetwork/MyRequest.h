//
//  MyRequest.h
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"


@interface MyRequest : NSObject{
    AFHTTPRequestOperation *_operation;
    NSTimeInterval _begin;
    NSTimeInterval _end;
}
@property (nonatomic) NSTimeInterval begin;
@property (nonatomic) NSInteger time;//第几次请求
@property (nonatomic) NSInteger index; //在数组种的索引
@property (nonatomic) NSString *url;


@property (nonatomic) NSString *name;
@property (nonatomic) NSString *status;
@property (nonatomic) NSTimeInterval duration;

-(void)send;
@end
