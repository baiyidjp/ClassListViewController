//
//  ListClassFlowLayout.h
//  ClassListViewController
//
//  Created by Keep丶Dream on 16/7/2.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListClassFlowLayout;

@protocol ListClassFlowLayoutDelegate <NSObject>

@required
//必须实现 返回item的size
- (CGSize)listClassFlowLayout:(ListClassFlowLayout *)listClassFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional //选择实现 不实现代理则使用默认值
/** 代理返回列间距 默认10 */
- (CGFloat)columnMarginInListClassFlowLayout:(ListClassFlowLayout *)listClassFlowLayout;
/** 代理返回行间距 默认10 */
- (CGFloat)rowMarginInListClassFlowLayoutt:(ListClassFlowLayout *)listClassFlowLayout;
/** 代理返回四周间距 默认{10,10,10,10} */
- (UIEdgeInsets)edgeInsetsInListClassFlowLayout:(ListClassFlowLayout *)listClassFlowLayout;

@end
@interface ListClassFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,weak)id<ListClassFlowLayoutDelegate> delegate;

@end
