//
//  ZZSuspensionButton.h
//  ZZSuspensionButton
//
//  Created by pzz on 2018/10.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZZSuspensionButtonwLeanType) {
    /** Can only stay in the left and right */
    ZZSuspensionButtonLeanTypeHorizontal,
    /** Can stay in the upper, lower, left, right */
    ZZSuspensionButtonLeanTypeEachSide
};

/**
 悬浮按钮
 */
@interface ZZSuspensionButton : UIButton

@property(nonatomic, assign) BOOL dockable;//是否停靠（默认：自动滚到屏幕边沿）

@property(nonatomic, assign) ZZSuspensionButtonwLeanType type;//靠边类型(默认为靠边左右)

@property(nonatomic, assign) CGFloat topSpace;//顶部外加留空（默认为0）

@property(nonatomic, assign) CGFloat leftSpace;//左部外加留空（默认为0）

@property(nonatomic, assign) CGFloat bottomSpace;//底部外加留空（默认为0）

@property(nonatomic, assign) CGFloat rightSpace;//右部外加留空（默认为0）

@property(nonatomic, copy) void (^suspensionButtonClickBlock)(UIButton *suspensionButton);//当前这个按钮点击的事件回调block

@end
