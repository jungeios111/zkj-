//
//  LockView.h
//  手势解锁
//
//  Created by ZKJ on 16/9/2.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockView : UIView

/** 手势密码 */
@property(nonatomic,copy) NSString *passWord;
/** <#注释#> */
@property(nonatomic,strong) UIPanGestureRecognizer *pan;

@end
