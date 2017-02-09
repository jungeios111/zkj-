//
//  LockView.m
//  手势解锁
//
//  Created by ZKJ on 16/9/2.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, strong) NSMutableArray *seleBtnArray;
@property (nonatomic, assign) CGPoint curP;

@end

@implementation LockView

- (NSMutableArray *)seleBtnArray
{
    if (_seleBtnArray == nil) {
        _seleBtnArray = [NSMutableArray array];
    }
    return _seleBtnArray;
}

// 画按钮
- (void)awakeFromNib
{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

// 创建9个按钮
- (void)setUp
{
    for (NSInteger i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = i + 1;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.pan = pan;
}

// 重置坐标
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    int num = 3;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 74;
    CGFloat h = 74;
    
    int col = 0;
    int row = 0;
    CGFloat margin = (self.bounds.size.width - num * w) / (num + 1);
    CGFloat space = 30;
    for (int i = 0; i < count; i++) {
        col = i % 3;
        row = i / 3;
        x = margin + (w + margin) * col;
        y = space + (h + space) * row;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

// 手势拖动
- (void)pan:(UIPanGestureRecognizer *)pan
{
    _curP = [pan locationInView:self];
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, _curP) && btn.selected == NO) {
            btn.selected = YES;
            [self.seleBtnArray addObject:btn];
        }
    }
    [self setNeedsDisplay];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        NSMutableString *strM = [NSMutableString string];
        for (UIButton *btn in self.seleBtnArray) {
            [strM appendFormat:@"%ld",btn.tag];
        }
        NSLog(@"strM:%@",strM);
        _passWord = strM;
        
//        [self.seleBtnArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
        
        for (UIButton *btn in self.seleBtnArray) {
            btn.selected = NO;
        }
        
        [self.seleBtnArray removeAllObjects];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 没选择，直接返回
    if (self.seleBtnArray.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSInteger count = self.seleBtnArray.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.seleBtnArray[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:_curP];
    [[UIColor greenColor] set];
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

- (void)setPassWord:(NSString *)passWord
{
    _passWord = passWord;
}


@end
