//
//  TYTagView.m
//  TYTagViewDemo
//
//  Created by Tiny on 2018/4/17.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TYTagView.h"
#import "Masonry.h"
#import "TYTagItem.h"

@interface TYTagView ()

@property (nonatomic, strong) NSMutableArray<TYTagItem *> *tagList;

@end

@implementation TYTagView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.tagList = [NSMutableArray array];
    self.margin = 10;
    self.top = 10;
    self.tagHeight = 33;
}

-(void)setItems:(NSArray *)items{
    //先移除之前的
    if (items.count == _items.count && _items.count!= 0) {
        //直接赋值
        for (int i = 0; i < items.count; i++) {
            TYTagItem *tagItem = [self.tagList objectAtIndex:i];
            tagItem.title = [items objectAtIndex:i];
        }
        [self setNeedsLayout];
    }else{
        //创建tagView 并赋值
        [self creatTags:items];
    }
    _items = items;
}

-(void)creatTags:(NSArray *)items{
    //先移除
    for (UIView *v in self.tagList) {
        [v removeFromSuperview];
    }
    [self.tagList removeAllObjects];
    
    NSInteger count = items.count;
    for (int i = 0; i < count; i++) {
        TYTagItem *tagItem = [TYTagItem new];
        tagItem.tag = i;
        tagItem.title = items[i];
        tagItem.tagItemClickEvent =^(NSInteger tag){
            NSLog(@"tag:%zi   title:%@",tag,items[tag]);
        };
        [self addSubview:tagItem];
        [self.tagList addObject:tagItem];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //重新设置TagView约束
    if (self.tagList.count == self.items.count && self.tagList != 0) {
        //重新设置约束
        NSInteger count = self.items.count;
        NSInteger margin = self.margin;
        NSInteger top = self.top;
        CGFloat width = self.bounds.size.width;   //总宽度
        CGFloat rowWidth = 0;  //单行内容的宽度
        CGFloat height = self.tagHeight;
        __block BOOL isChange = YES;  //是否需要换行
        TYTagItem *last = nil;
        for (int i = 0; i < count; i++) {
            TYTagItem *tagItem = self.tagList[i];
            tagItem.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
           //判断宽度是否可以在该行布局 可以布局直接布局 不可以换行
            CGFloat tagWidth = tagItem.viewWidth;
            rowWidth += tagWidth + margin;
            
            if (rowWidth  > width - margin) {      //需要换行
                isChange = YES;
                //判断是否超过最大值
                if (tagWidth + margin *2 > width) {
                    tagWidth = (width - margin*2);
                }
                //换行后重新设置当前行的总宽度
                rowWidth = tagWidth + margin;
            }
            [tagItem mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (isChange) {  //换行
                    if (!last) {
                        make.top.mas_offset(top);
                    }else{
                        make.top.mas_equalTo(last.mas_bottom).mas_offset(top);
                    }
                    make.left.mas_offset(margin);
                    isChange = NO;
                }else{
                    make.left.mas_equalTo(last.mas_right).mas_offset(margin);
                    make.top.mas_equalTo(last.mas_top);
                }
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(tagWidth);

                //设置最后一个item
                if (i == count -1) {
                    make.bottom.mas_offset(-top);
                }
            }];
            last = tagItem;
        }
    }
}



@end
