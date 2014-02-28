//
//  ViewController.m
//  TestNetwork
//
//  Created by kewei on 2/27/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _buttonPasue.enabled = NO;
    NSArray *array = @[
        @{
            @"name" : @"蘑菇街",
//            @"url" : @"http://baidu.com"
            @"url" : @"http://www.mogujie.com/app_mgj_v540_welcome/index?_swidth=720&timestamp=1393485889&_atype=android&_mgj=6951ab5afba72ec1fbf6086d73c7104f1393485889&_sdklevel=17&_msys=4.2.2&_network=2&_saveMode=0&_fs=MAMwandoujia540&_did=862966021103675&_source=MAMwandoujia540&_minfo=2013023"
        },
        @{
            @"name"  : @"明星衣橱",
            @"url" : @"http://api2.haobao.com/hotwords?version=0&ga=%2Fhotwordsitem&gv=42&gi=862966021103675&access_token=&type=item&gc=wandoujia&gn=mxyc_adr&gf=android"
        },
        @{
            @"name" : @"美丽说",
            @"url" : @"http://mobapi.meilishuo.com/2.0/navigation/selected?imei=862966021103675&mac=f8%3Aa4%3A5f%3Af8%3A9a%3Ac7&qudaoid=10140&access_token=f1036a1ec3568d454a9bcb8327ef797b"
        }

        
    ];
    _arrayData = array;
    _arrayResult = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)handleTapStart:(id)sender{
    NSLog(@"handleTapStart");
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                              target:self
                                            selector:@selector(sendRequest)
                                            userInfo:nil
                                             repeats:YES];
    _buttonStart.enabled = NO;
    _buttonPasue.enabled = YES;
    [self sendRequest];
}
-(IBAction)handleTapPause:(id)sender{
    _buttonPasue.enabled = NO;
    
    //TODO 等待框，等待本次请求结束
    [self performSelector:@selector(enableButtonStart) withObject:nil afterDelay:30.0];
    [_timer invalidate];
    _timer = nil;
}
-(void)enableButtonStart{
    _buttonStart.enabled = YES;
    //TODO 等待框消失
}
-(IBAction)handleTapTotal:(id)sender{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [_arrayResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        for (NSInteger i = 0;  i < _arrayData.count; i++) {
            MyRequest *request = obj[i];
            if(dic[@(i)] == nil){
                dic[@(i)] = @0;
            }
            if(![request.status isEqualToString:@"200"]){
                dic[@(i)] = @([dic[@(i)] integerValue] + 1);
            }
        }
    }];
    NSString *message = @"非200统计，";
    for(NSInteger i = 0; i<_arrayData.count; i++){
        NSString *m = [NSString stringWithFormat:@"%@:%@个；", _arrayData[i][@"name"], dic[@(i)]];
        message = [message stringByAppendingString:m];
    }
    [[[UIAlertView alloc] initWithTitle:@"统计结果" message:message  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
}
-(IBAction)handleTapReset:(id)sender{
    _buttonStart.enabled = YES;
    _buttonPasue.enabled = NO;
}
-(void)sendRequest{
    [_tableView reloadData];
    if(_arrayResult.count > 1){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_arrayData.count-1 inSection:_arrayResult.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    NSMutableArray *aResult = [NSMutableArray array];
    NSInteger time = _arrayResult.count;
    [_arrayData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MyRequest *request = [[MyRequest alloc] init];
        request.index = idx;
        request.time = time;
        request.name = obj[@"name"];
        request.url = obj[@"url"];
        [request send];
        [aResult addObject:request];
    }];
    [_arrayResult addObject:aResult];
    NSLog(@"====sendRequest and the current time is :%d", time);
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayResult.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil];
        UIView *subView = [nibViews objectAtIndex:0];
        [cell addSubview : subView];
        cell.frame = CGRectMake(0, 0, 320, 44);
        subView.tag = 20000;
    }
    MyCell *myCell = (MyCell *)[cell viewWithTag:20000];
    MyRequest *request = _arrayResult[section][row];
    myCell.time = section;
    myCell.name = request.name;
    myCell.status = request.status;
    myCell.duration = request.duration;
    myCell.date =  [NSDate dateWithTimeIntervalSince1970:request.begin];
    return cell;
}
@end
