//
//  ZZSuspensionButton.m
//  ZZSuspensionButton
//
//  Created by pzz on 2018/10.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "ZZSuspensionButton.h"

@interface ZZSuspensionButton()

//是否移动
@property (nonatomic,assign) BOOL isMoved;

@end

@implementation ZZSuspensionButton

- (instancetype)init {
    
    if (self=[super init]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        self.alpha=0.8;
        
        //点击事件
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)buttonClick:(UIButton*)sender {
    !self.suspensionButtonClickBlock?:self.suspensionButtonClickBlock(self);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    
    //本次触摸点
    CGPoint current = [touch locationInView:self];
    
    //上次触摸点
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.center;
    
    //中心点移动触摸移动的距离
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    
    //停靠：限制移动范围
    if(self.dockable){
        CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat           x = self.frame.size.width  * 0.5f;
        CGFloat           y = self.frame.size.height * 0.5f;
        
        CGFloat xMin = _leftSpace + x;
        CGFloat xMax = screenWidth-_rightSpace   - x;
        
        CGFloat yMin = _topSpace  + y;
        CGFloat yMax = screenHeight-_bottomSpace - y;
        
        if (center.x > xMax) center.x = xMax;
        if (center.x < xMin) center.x = xMin;
        
        if (center.y > yMax) center.y = yMax;
        if (center.y < yMin) center.y = yMin;
        
        self.center = center;
    }
    
    self.center = center;
    
    //移动距离大于0.5才判断为移动了(提高容错性)
    if (fabs(current.x-previous.x)>=0.5 || fabs(current.y - previous.y)>=0.5) {
        self.isMoved = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.isMoved) {
        //如果没有移动，则调用父类方法，触发button的点击事件
        [super touchesEnded:touches withEvent:event];
    }
    self.isMoved = NO;
    
    //关闭高亮状态
    [self setHighlighted:NO];
    
    //停靠
    if (self.dockable) return;
    
    //回到一定范围
    if (1) {
        //屏宽高 & 自身一半宽高
        CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat           x = self.frame.size.width  * 0.5f;
        CGFloat           y = self.frame.size.height * 0.5f;
        //中间点
        CGPoint center = self.center;
        
        //目前中间点距各边距离
        CGFloat left   = center.x - (_leftSpace+x);
        CGFloat right  = (screenWidth-_rightSpace)-x    -  center.x;
        CGFloat top    = center.y - (_topSpace+x);
        CGFloat bottom = (screenHeight-_bottomSpace)-y  -  center.y;
        
        CGFloat minSpace = 0;
        if (self.type == 0) {
            minSpace = MIN(left, right);
        }else{
            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        }
        
        CGPoint newCenter = self.center;
        if (minSpace == left) {
            newCenter.x = (_leftSpace+x);
        }else if (minSpace == right) {
            newCenter.x = (screenWidth-_rightSpace)-x;
        }else if (minSpace == top) {
            newCenter.y = (_topSpace+x);
        }else if (minSpace == bottom) {
            newCenter.y = (screenHeight-_bottomSpace)-y;
        }
        
        [UIView animateWithDuration:.25 animations:^{
            self.center = newCenter;
        }];
    }

}

@end
