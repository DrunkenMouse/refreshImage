//
//  ViewController.m
//  逐层刷新图片
//
//  Created by 王奥东 on 16/11/25.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ShowImage.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    UIImage *img;
    
    IBOutlet ShowImage *showImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)changeButton:(UIButton *)sender {
    
    if (sender.tag == 1) {
        showImage.image = [UIImage imageNamed:@"1"];
        sender.tag = 2;
    } else {
        sender.tag = 1;
        showImage.image = [UIImage imageNamed:@"2"];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
