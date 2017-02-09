//
//  ViewController.m
//  手势解锁2
//
//  Created by ZKJ on 16/9/2.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "ViewController.h"
#import "VCBackgroundView.h"
#import "LockView.h"

@interface ViewController ()
{
    NSInteger _num;
}

@property (nonatomic, weak) VCBackgroundView *backView;
@property (nonatomic, weak) LockView *lockView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 100, 200, 50)];
    textView.scrollsToTop = NO;
    textView.editable = NO;
    textView.selectable = NO;
    textView.text = @"爱丽丝的减肥了圣诞节法律手段就发了啥；的健康法拉数据库的法拉盛剪短发了；案件是地方了；案件是地方了；加上了地方就俺俩是；大就发生了剪短发了；按数据库地方了；爱上家地方了；爱上家地方；拉上来；打飞机爱丽丝；的接发牢骚；大姐夫；拉伸件地方了；按数据库地方了；爱上家地方了；爱上家地方；拉丝机";
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    
    
    [self initLockView];
}

- (void)initLockView
{
    VCBackgroundView *backView = [[VCBackgroundView alloc] init];
    backView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backView = backView;
    [self.view addSubview:backView];
    
    _num = 5;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 65, 290, 20);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = YES;
    [backView addSubview:label];
    self.titleLabel = label;
    
    LockView *lockView = [[LockView alloc] init];
    lockView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
    lockView.backgroundColor = [UIColor clearColor];
    [backView addSubview:lockView];
    [lockView.pan addTarget:self action:@selector(pan:)];
    self.lockView = lockView;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded) {
        NSLog(@"passWord:%@",_lockView.passWord);
        if ([_lockView.passWord isEqualToString:@"1235789"]) {
            self.titleLabel.hidden = YES;
            [UIView animateWithDuration:1.0 animations:^{
                _backView.alpha = 0;
            } completion:^(BOOL finished) {
                [_backView removeFromSuperview];
            }];
        } else {
            _num -= 1;
            self.titleLabel.hidden = NO;
            self.titleLabel.text = [NSString stringWithFormat:@"密码错误，您还有%d次机会",_num];
        }
    }
}


@end
