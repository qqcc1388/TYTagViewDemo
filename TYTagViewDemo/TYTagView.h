//
//  TYTagView.h
//  TYTagViewDemo
//
//  Created by Tiny on 2018/4/17.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTagView : UIView
/**
 有多少个标签
 */
@property (nonatomic, strong) NSArray *items;

//默认33
@property (nonatomic, assign) CGFloat tagHeight;

//tag距离边缘的距离 默认10
@property (nonatomic, assign) CGFloat margin;

//tag距离顶部的距离 默认10
@property (nonatomic, assign) CGFloat top;

@end
