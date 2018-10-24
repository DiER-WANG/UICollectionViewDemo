//
//  ViewController.m
//  demo
//
//  Created by 王昌阳 on 2018/10/19.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [_redView viewWithTag:1001];
    NSLog(@"%@, %@, %@", _redView.subviews, @(view == _whiteView), @(view == _orangeView));
}

@end
