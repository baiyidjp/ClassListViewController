//
//  ListClassBtnView.m
//  ClassListViewController
//
//  Created by Keep丶Dream on 16/7/2.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ListClassBtnView.h"

#define HEADBTNTAG 20160702
#define CLASSBTNTAG 201607020702

@interface ListClassBtnView ()
/** UIScrollView */
@property(nonatomic,weak) UIScrollView *backScrollView;
/** viewY */
@property(nonatomic,assign) CGFloat classViewY;
/** 存放所有小分类的 */
@property(nonatomic,strong)NSMutableArray *classBtnDicts;
/** 列间距 */
@property(nonatomic,assign) CGFloat columnMargin;
/** 行间距 */
@property(nonatomic,assign) CGFloat rowMargin;
/** 四周间距 */
@property(nonatomic,assign) UIEdgeInsets edgeInsets;
/** scroll距离super的两边的距离 */
@property(nonatomic,assign) CGFloat scrollPadding;
/** 头部视图的高度 */
@property(nonatomic,assign) CGFloat headerHeight;
@end

@implementation ListClassBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    [self addSubviews];
}

- (NSMutableArray *)classBtnDicts{
    
    if (!_classBtnDicts) {
        
        _classBtnDicts = [NSMutableArray array];
    }
    return _classBtnDicts;
}

- (CGFloat)columnMargin{
    
    if (!_columnMargin) {
        if ([self.listClassDelegate respondsToSelector:@selector(columnMarginInListClassBtnView:)]) {
            _columnMargin = [self.listClassDelegate columnMarginInListClassBtnView:self];
        }else{
            _columnMargin = 10;
        }
    }
    return _columnMargin;
}

- (CGFloat)rowMargin{
    
    if (!_rowMargin) {
        if ([self.listClassDelegate respondsToSelector:@selector(rowMarginInListClassBtnView:)]) {
            _rowMargin = [self.listClassDelegate rowMarginInListClassBtnView:self];
        }else{
            _rowMargin = 10	;
        }
    }
    return _rowMargin;
}

- (UIEdgeInsets)edgeInsets{
    
    
    if ([self.listClassDelegate respondsToSelector:@selector(edgeInsetsInListClassBtnView:)]) {
        return [self.listClassDelegate edgeInsetsInListClassBtnView:self];
    }else{
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
}

- (CGFloat)scrollPadding{
    
    if (!_scrollPadding) {
        
        if ([self.listClassDelegate respondsToSelector:@selector(scrollPaddingInListClassBtnView:)]) {
            _scrollPadding = [self.listClassDelegate scrollPaddingInListClassBtnView:self];
        }else{
            _scrollPadding = 70;
        }
    }
    return _scrollPadding;
}

- (CGFloat)headerHeight{
    
    if (!_headerHeight) {
        
        if ([self.listClassDelegate respondsToSelector:@selector(headerHeightInListClassBtnView:)]) {
            _headerHeight = [self.listClassDelegate headerHeightInListClassBtnView:self];
        }else{
            _headerHeight = 50;
        }
    }
    return _headerHeight;
}

- (void)addSubviews{

    UIImageView *imageBackView = [[UIImageView alloc]init];
    imageBackView.image = [UIImage imageNamed:@"GYKditu"];
    imageBackView.frame = self.bounds;
    [self addSubview:imageBackView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"guanbi_hui"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    CGSize btnSize = CGSizeMake(20, 20);
    CGFloat btnX = self.frame.size.width/2 - btnSize.width/2;
    CGFloat btnY = self.frame.size.height - 25 - btnSize.height;
    closeBtn.frame = CGRectMake(btnX, btnY, btnSize.width, btnSize.height);
    [self addSubview:closeBtn];
    
    CGFloat scrollViewY = SCALE_H(30);
    UIScrollView *backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCALE_W(self.scrollPadding), scrollViewY, self.frame.size.width-2*SCALE_W(self.scrollPadding), CGRectGetMinY(closeBtn.frame)-scrollViewY-self.rowMargin)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:backScrollView];
    self.backScrollView = backScrollView;
    
    [self setAllClassViewWith:self.data];
    
    self.backScrollView.contentSize = CGSizeMake(0, self.classViewY);
}

- (void)setAllClassViewWith:(NSArray *)data{
    
    NSInteger count = data.count;
    for (NSInteger i = 0; i < count; i++) {
        
        NSDictionary *dict = data[i];
        [self setClassViewWith:dict tag:i];
    }
    
}

- (void)setClassViewWith:(NSDictionary *)dict tag:(NSInteger)tag{
 
    //classAtt className classId
    
    UIView *classView = [[UIView alloc]init];
    classView.backgroundColor = [UIColor clearColor];
    [self.backScrollView addSubview:classView];
    
    CGFloat superViewW = self.backScrollView.frame.size.width;
    
    UIButton *headBtn = [[UIButton alloc]init];
    headBtn.tag = tag+HEADBTNTAG;
    [headBtn setTitle:[dict objectForKey:@"className"]forState:UIControlStateNormal];
    [headBtn.titleLabel setFont:FONTSIZE(TEXTFONT)];
    [headBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(clickHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
    CGSize nameS = [[dict objectForKey:@"className"] sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:TEXTFONT+1] forKey:NSFontAttributeName]];
    headBtn.frame = CGRectMake(superViewW/2 - nameS.width/2, 0, nameS.width, SCALE_H(self.headerHeight));//头部按钮的frame
    [classView addSubview:headBtn];
    CGFloat lineViewY = CGRectGetMaxY(headBtn.frame)-1;
    
    NSArray *classAtt = [dict objectForKey:@"classAtt"];
    if (classAtt.count) {
        CGFloat classMaxX = self.edgeInsets.left;//左边 边间距
        CGFloat classBtnY = CGRectGetMaxY(headBtn.frame)+self.edgeInsets.top;
        for (NSInteger i = 0; i < classAtt.count; i++) {
            NSDictionary *classDict = classAtt[i];
            [self.classBtnDicts addObject:classDict];
            CGSize nameSize = [[classDict objectForKey:@"className"] sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
            UIButton *classBtn = [[UIButton alloc]init];
            [classBtn setTitle:[classDict objectForKey:@"className"] forState:UIControlStateNormal];
            [classBtn.titleLabel setFont:FONTSIZE(TEXTFONT)];
            classBtn.tag = CLASSBTNTAG+self.classBtnDicts.count-1;
            [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [classBtn addTarget:self action:@selector(clickClassBtn:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat classX = classMaxX;
            CGFloat classY = classBtnY;
            if (classX + nameSize.width >superViewW-self.edgeInsets.right) {//右边 边间距
                classY = classBtnY+nameSize.height+self.rowMargin;//行间距
                classX = self.edgeInsets.left;
                classBtnY = classY;
            }
            classBtn.frame = CGRectMake(classX, classY, nameSize.width, nameSize.height);
            [classView addSubview:classBtn];
            classMaxX = CGRectGetMaxX(classBtn.frame)+self.columnMargin;
            lineViewY = classBtnY+nameSize.height+self.rowMargin-1;
        }
    }
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(0, lineViewY, superViewW, 1);
    [classView addSubview:lineView];

    classView.frame = CGRectMake(0, self.classViewY, superViewW, CGRectGetMaxY(lineView.frame));
    
    self.classViewY += CGRectGetMaxY(lineView.frame);
    
}

- (void)clickHeadBtn:(UIButton *)headerBtn{
    
    NSInteger count = headerBtn.tag-HEADBTNTAG;
    
    NSDictionary *dict = self.data[count];
    
    NSLog(@"点击%@",[dict objectForKey:@"className"]);
    
    if(self.chooseBlock){
        self.chooseBlock([dict objectForKey:@"classId"]);
    }
}


- (void)clickClassBtn:(UIButton *)classBtn{
    
    NSInteger count = classBtn.tag - CLASSBTNTAG;
    
    NSDictionary *dict = self.classBtnDicts[count];
    
    NSLog(@"点击%@",[dict objectForKey:@"className"]);

    if(self.chooseBlock){
        self.chooseBlock([dict objectForKey:@"classId"]);
    }
}

- (void)clickClose{
    if(self.chooseBlock){
        self.chooseBlock(nil);
    }
}
@end
