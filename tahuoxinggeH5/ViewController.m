//
//  ViewController.m
//  tahuoxinggeH5
//
//  Created by crl on 2017/11/27.
//  Copyright © 2017年 lingyu. All rights reserved.
//

#import "ViewController.h"
#import <XtwSdk/XtwSdk.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDate* date=[NSDate date];
    
    NSTimeInterval interval=[date timeIntervalSince1970];
    
    
    NSString* url=[[NSString alloc] initWithFormat:@"http://gate.shushanh5.lingyunetwork.com/gate/micro/login.aspx?t=%d&p=%@",interval,@"ios" ];
    
    //url=@"http://baidu.com";
    
    [[XtwSdk getInstance] xtwH5Init:url listener:^(XtwSdkInitCode code, NSString *ret) {
        
        NSLog(@"error:%d %@",code,ret);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
