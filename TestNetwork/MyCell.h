//
//  MyCell.h
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UIView{
    IBOutlet UIButton *_buttonTime;
    IBOutlet UIButton *_buttonName;
    IBOutlet UIButton *_buttonStatus;
    IBOutlet UIButton *_buttonDuration;
    IBOutlet UIButton *_buttonDate;
}
@property (nonatomic) NSInteger time;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *status;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSDate *date;

@end
