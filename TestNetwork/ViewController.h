//
//  ViewController.h
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRequest.h"
#import "MyCell.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSTimer *_timer;
    IBOutlet UIButton *_buttonStart;
    IBOutlet UIButton *_buttonPasue;
    IBOutlet UIButton *_buttonTotal;
    IBOutlet UIButton *_buttonReset;
    IBOutlet UITableView *_tableView;
    NSArray *_arrayData;
    NSMutableArray *_arrayResult;
}

@end
