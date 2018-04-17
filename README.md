# TYTagViewDemo

在搜索页面经常会有不规则的tag出现，这种tagView要有点击事件，单个tagView可以设置文字颜色，宽度不固定根据内容自适应，高度固定，数量不固定。总高度就不固定。最近对于masonry的使用又有了一些新的理解，所有就写了一个这样的tagView的例子，demo中全部使用Masonry自动布局，高度也是自适应的，封装的tagView可以直接使用在tablView或者collectionView中。demo下载地址：https://github.com/qqcc1388/TYTagViewDemo
效果图：
![](https://images2018.cnblogs.com/blog/950551/201804/950551-20180417152410033-1445694217.jpg)

对于这种不规则标签的布局思路：
    1、由于宽度不固定，所以要想知道宽度，必须要根据内容来计算，所有需要在给标签赋值之后重新布局一次标签的位置;
    2、布局的时候要考虑换行的问题，当单个标签的宽度大于一行，或者单个标签+跟他同一行的标签总宽度大于一行的时候需要考虑换行操作;
    3、masonry布局根据换行的时机，分别计算距离上一个标签对于的位置。

关键代码实现：
```
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
        TYTagItem *last = nil;      //记录下上一个标签
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

```

这种不规则标签的使用方法（如果放在tableView中可以结合tableView的自适应高度）
```
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
```