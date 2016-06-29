//
//  ListClassView.m
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/28.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import "ListClassView.h"
#import "ListClassModel.h"
#import "Masonry.h"
#import "UIColor+HexCode.h"

#define HEADBTNTAG 20160628


@interface ListClassView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ListClassView
{
    UICollectionView *ListCollectionView;
}
+ (ListClassView *)getListClassViewWithFrame:(CGRect)frame data:(NSArray *)data chooseBlock:(ChooseClass)chooseBlock{
    
    return [[[self class]alloc]initWithFrame:frame data:data chooseBlock:chooseBlock];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data chooseBlock:(ChooseClass)chooseBlock{
    
    self = [super init];
    if (self) {
        self.frame = frame;
        self.data = data;
        self.chooseBlock = chooseBlock;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    UIImageView *imageBackView = [[UIImageView alloc]init];
    imageBackView.image = [UIImage imageNamed:@"GYKditu"];
    imageBackView.frame = self.bounds;
    [self addSubview:imageBackView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = KMARGIN;
    layout.sectionInset = UIEdgeInsetsMake(0, KMARGIN, 0, KMARGIN);
    ListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(70*KWIDTH/375.0, 20, KWIDTH-2*70*KWIDTH/375.0, KHEIGHT-KNAVHEIGHT-50) collectionViewLayout:layout];
    ListCollectionView.dataSource = self;
    ListCollectionView.delegate = self;
    [ListCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ListCollectionView"];
    [ListCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ListCollectionViewHeader"];
    [ListCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ListCollectionViewFooter"];
    ListCollectionView.backgroundColor = [UIColor clearColor];
    ListCollectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:ListCollectionView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"guanbi_hui"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ListCollectionView.mas_centerX);
        make.bottom.offset(-25);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    ListClassModel *model = [self.data objectAtIndex:section];
    return model.classAtt.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionView" forIndexPath:indexPath];
    
    //先清空subviews 防止重影 有更好的方法一定要告诉我
    for (UIView * view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    
    ListClassModel *sectionModel = [self.data objectAtIndex:indexPath.section];
    ListClassModel *itemModel = sectionModel.classAtt[indexPath.item];
    
    UILabel *textL = [[UILabel alloc]init];
    textL.font = FONTSIZE(15);
    textL.textColor = [UIColor colorFromHexString:@"000000"];
    textL.text = itemModel.className;
    textL.frame = CGRectMake(0, 0, itemModel.nameSize.width, itemModel.nameSize.height);
    [cell.contentView addSubview:textL];
    
    return cell;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        ListClassModel *sectionModel = [self.data objectAtIndex:indexPath.section];
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ListCollectionViewHeader" forIndexPath:indexPath];
        //先清空subviews 防止重影 有更好的方法一定要告诉我
        for (UIView * view in headerView.subviews){
            [view removeFromSuperview];
        }
        UIButton *headerBtn = [[UIButton alloc]init];
        [headerBtn setTitleColor:[UIColor colorFromHexString:@"000000"] forState:UIControlStateNormal];
        [headerBtn.titleLabel setFont:FONTSIZE(15)];
        [headerBtn addTarget:self action:@selector(clickHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        headerBtn.tag = HEADBTNTAG+indexPath.section;
        [headerBtn setTitle:sectionModel.className forState:UIControlStateNormal];
        headerBtn.frame = headerView.bounds;
        headerView.backgroundColor = [UIColor clearColor];
        [headerView addSubview:headerBtn];
        
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ListCollectionViewFooter" forIndexPath:indexPath];
        //先清空subviews 防止重影 有更好的方法一定要告诉我
        for (UIView * view in footerView.subviews){
            [view removeFromSuperview];
        }
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorFromHexString:@"bbbbbb"];
        lineView.frame = CGRectMake(0, CGRectGetHeight(footerView.frame)-1, CGRectGetWidth(footerView.frame), 1);
        footerView.backgroundColor = [UIColor clearColor];
        [footerView addSubview:lineView];
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListClassModel *sectionModel = [self.data objectAtIndex:indexPath.section];
    if (sectionModel.classAtt.count) {
        ListClassModel *itemModel = sectionModel.classAtt[indexPath.item];
        return itemModel.nameSize;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(KWIDTH-70*KWIDTH/375.0, 50);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(KWIDTH-70*KWIDTH/375.0, 10);
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    
//    return UIEdgeInsetsMake(0, KMARGIN*2, 0, KMARGIN*2);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击%zd",indexPath.item);
    ListClassModel *sectionModel = [self.data objectAtIndex:indexPath.section];
    ListClassModel *itemModel = sectionModel.classAtt[indexPath.item];
    if(self.chooseBlock){
        self.chooseBlock(itemModel.classId);
    }
}

- (void)clickHeaderBtn:(UIButton *)headerBtn{
    
    NSLog(@"点击%zd",headerBtn.tag-HEADBTNTAG);
    ListClassModel *sectionModel = [self.data objectAtIndex:headerBtn.tag-HEADBTNTAG];
    if(self.chooseBlock){
        self.chooseBlock(sectionModel.classId);
    }
}

- (void)clickClose{
    if(self.chooseBlock){
        self.chooseBlock(nil);
    }
}
@end
