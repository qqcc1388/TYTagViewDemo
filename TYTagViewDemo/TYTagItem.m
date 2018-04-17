//
//  TYTagItem.m
//  TYTagViewDemo
//
//  Created by Tiny on 2018/4/17.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TYTagItem.h"
#import "Masonry.h"

@interface TYTagItem ()

@property (nonatomic, strong) UIButton *itemButton;

@end

@implementation TYTagItem

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    //初始化参数
    self.font = [UIFont systemFontOfSize:14];
    self.titleColor = [UIColor blackColor];
    self.leftMargin = 10;
    self.topMargin = 4;
    
    self.itemButton = [UIButton new];
    self.itemButton.titleLabel.font = self.font;
    self.itemButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.itemButton addTarget:self action:@selector(itemClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.itemButton];
    [self.itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(self.topMargin);
        make.bottom.mas_offset(-self.topMargin);
        make.left.mas_offset(self.leftMargin);
        make.right.mas_offset(-self.leftMargin);
    }];
}

-(void)itemClick{
    if (self.tagItemClickEvent) {
        self.tagItemClickEvent(self.tag);
    }
}
#pragma mark - setter getter

-(CGFloat)viewWidth{
    return [self tagWidthForTitle];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.itemButton setTitle:title forState:UIControlStateNormal];
}

-(void)setFont:(UIFont *)font{
    _font = font;
    self.itemButton.titleLabel.font = font;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.itemButton setTitleColor:titleColor forState:UIControlStateNormal];
}

-(void)setTopMargin:(CGFloat)topMargin{
    _topMargin = topMargin;
    //重新布局
    if (self.itemButton && self.itemButton.superview) {
        [self.itemButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_offset(topMargin);
            make.bottomMargin.mas_offset(-topMargin);
        }];
    }
}

-(void)setLeftMargin:(CGFloat)leftMargin{
    _leftMargin = leftMargin;
    //重新布局
    if (self.itemButton && self.itemButton.superview) {
        [self.itemButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(leftMargin);
            make.right.mas_offset(-leftMargin);
        }];
    }
}

#pragma mark - Private

-(CGFloat)tagWidthForTitle{
    //根据文字内容和margin返回文字的真实宽度
    if (self.title.length == 0) {
        return 0.f;
    }
    return  [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.itemButton.titleLabel.font} context:nil].size.width + self.leftMargin*2 + 0.5;  //masonry布局会四舍五入 + 0.5防止宽度不够
}
@end
