//
//  TYTagItem.h
//  TYTagViewDemo
//
//  Created by Tiny on 2018/4/17.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTagItem : UIView

//文字
@property (nonatomic, copy) NSString *title;

//默认 Black
@property (nonatomic, strong) UIColor *titleColor;

//默认14
@property (nonatomic, strong) UIFont *font;

//默认10
@property (nonatomic, assign) CGFloat leftMargin;

//默认4
@property (nonatomic, assign) CGFloat topMargin;

//根据文字自动计算出内容的宽度
@property (nonatomic, assign) CGFloat viewWidth;

@property (nonatomic, copy) void (^tagItemClickEvent)(NSInteger index);


@end
