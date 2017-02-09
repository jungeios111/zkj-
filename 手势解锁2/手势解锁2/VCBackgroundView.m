//
//  VCBackgroundView.m
//  手势解锁
//
//  Created by ZKJ on 16/9/2.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "VCBackgroundView.h"

@implementation VCBackgroundView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
}


@end
