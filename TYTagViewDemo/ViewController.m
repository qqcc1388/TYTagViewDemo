//
//  ViewController.m
//  TYTagViewDemo
//
//  Created by Tiny on 2018/4/17.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "ViewController.h"
#import "TYTagView.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) TYTagView *tagView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];

}

-(void)setupUI{
    [self prepareDatas];

    //创建tagView
    TYTagView *tagView = [TYTagView new];
    self.tagView = tagView;
    tagView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tagView];
    
    //给tagView赋值
    tagView.items = self.datas;
    
    //设置约束
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    //布局tagView 让约束生效
    [tagView layoutIfNeeded];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tagView removeFromSuperview];

    [self setupUI];
}

-(void)prepareDatas{
    self.datas = [NSMutableArray new];
    [self.datas removeAllObjects];
    NSInteger count = arc4random_uniform(15);
    for (int i = 0; i < count; i++) {
        NSInteger m = arc4random_uniform(60) + 10;
        [self.datas addObject:[self randomStringWithLength:arc4random_uniform(m)]];
    }
}

-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

@end
