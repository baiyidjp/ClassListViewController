//
//  ListClassFlowLayout.m
//  ClassListViewController
//
//  Created by Keep丶Dream on 16/7/2.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ListClassFlowLayout.h"

@interface ListClassFlowLayout ()

/** 所有cell的布局属性 */
@property(nonatomic,strong)NSMutableArray *cellAttributesArray;
/** 列间距 */
@property(nonatomic,assign) CGFloat columnMargin;
/** 行间距 */
@property(nonatomic,assign) CGFloat rowMargin;
/** 四周间距 */
@property(nonatomic,assign) UIEdgeInsets edgeInsets;
/** 存储最大X值 */
@property(nonatomic,assign) CGFloat columnMaxX;
/** 存储最大Y值 */
@property(nonatomic,assign) CGFloat columnMaxY;
@end

@implementation ListClassFlowLayout

/**
 *  懒加载
 */
- (NSMutableArray *)cellAttributesArray{
    
    if (!_cellAttributesArray) {
        
        _cellAttributesArray = [NSMutableArray array];
    }
    return _cellAttributesArray;
}
- (CGFloat)columnMargin{
    
    if (!_columnMargin) {
        if ([self.delegate respondsToSelector:@selector(columnMarginInListClassFlowLayout:)]) {
            _columnMargin = [self.delegate columnMarginInListClassFlowLayout:self];
        }else{
            _columnMargin = 10;
        }
    }
    return _columnMargin;
}

- (CGFloat)rowMargin{
    
    if (!_rowMargin) {
        if ([self.delegate respondsToSelector:@selector(rowMarginInListClassFlowLayoutt:)]) {
            _rowMargin = [self.delegate rowMarginInListClassFlowLayoutt:self];
        }else{
            _rowMargin = 10	;
        }
    }
    return _rowMargin;
}

- (UIEdgeInsets)edgeInsets{
    
    
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInListClassFlowLayout:)]) {
        return [self.delegate edgeInsetsInListClassFlowLayout:self];
    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

/**
 *  初始化layout  每次刷新都会重新调用
 */
- (void)prepareLayout{
    
    [super prepareLayout];
    
    self.columnMaxX = self.edgeInsets.left;
    self.columnMaxY = self.edgeInsets.top;
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i < sectionCount; i++) {
        
        NSInteger cellCount = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < cellCount; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *attibute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.cellAttributesArray addObject:attibute];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.cellAttributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize attributeSize = [self.delegate listClassFlowLayout:self sizeForItemAtIndexPath:indexPath];
    
    CGFloat attributeX = self.columnMaxX;
    CGFloat viewMaxX = self.collectionView.frame.size.width - self.edgeInsets.right;
    CGFloat attributeY = self.columnMaxY;
    if (attributeX + attributeSize.width >viewMaxX ) {
        attributeY = self.columnMaxY+attributeSize.height+self.rowMargin;
        attributeX = self.edgeInsets.left;
        self.columnMaxY = attributeY;
    }
    attribute.frame = CGRectMake(attributeX, attributeY, attributeSize.width, attributeSize.height);
    self.columnMaxX = CGRectGetMaxX(attribute.frame)+self.columnMargin;
    return attribute;
}

@end
