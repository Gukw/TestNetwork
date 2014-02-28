//
//  MyCell.m
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setTime:(NSInteger)time{
    _time = time;
    [_buttonTime setTitle:[NSString stringWithFormat:@"%d", _time] forState:UIControlStateNormal];
}
-(void)setName:(NSString *)name{
    _name = name;
    [_buttonName setTitle:_name forState:UIControlStateNormal];
}
-(void)setStatus:(NSString *)status{
    _status = status;
    if([_status isEqualToString:@"200"]){
        [_buttonStatus setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]];
    }else{
        [_buttonDuration setBackgroundColor:[UIColor colorWithRed:255/255.0 green:103/255.0 blue:153/255.0 alpha:1]];

    }
    [_buttonStatus setTitle:_status forState:UIControlStateNormal];
}
-(void)setDuration:(NSInteger)duration{
    _duration= duration;
    if(_duration > 1000){
        [_buttonDuration setBackgroundColor:[UIColor colorWithRed:255/255.0 green:103/255.0 blue:153/255.0 alpha:1]];
    }else{
        [_buttonDuration setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1]];
    }
    [_buttonDuration setTitle:[NSString stringWithFormat:@"%d", _duration] forState:UIControlStateNormal];
}
-(void)setDate:(NSDate *)date{
    _date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"hh:mm:ss"]
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:_date];
    [_buttonDate setTitle:time forState:UIControlStateNormal];
}
@end
