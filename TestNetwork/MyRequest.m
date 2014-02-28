//
//  MyRequest.m
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import "MyRequest.h"

@implementation MyRequest


-(void)send{
    _begin = [[NSDate date] timeIntervalSince1970];

    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    __weak MyRequest *sself = self;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [sself countDate];
        sself.status = @"200";
        [sself countDate];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        sself.status = [NSString stringWithFormat:@"%d",error.code];
        [sself countDate];
    }];
    [_operation start];
    
}
-(void)countDate{
    _end = [[NSDate date] timeIntervalSince1970];
    _duration = (int)((_end - _begin)*1000);
    _operation = nil;
}
@end
