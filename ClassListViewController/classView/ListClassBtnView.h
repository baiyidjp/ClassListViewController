//
//  ListClassBtnView.h
//  ClassListViewController
//
//  Created by Keep丶Dream on 16/7/2.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseClass)(NSString *classId);

#define KWIDTH  [UIScreen mainScreen].bounds.size.width//屏幕的宽
#define KHEIGHT [UIScreen mainScreen].bounds.size.height//屏幕的高
#define FONTSIZE(x)  [UIFont systemFontOfSize:x]//设置字体大小
#define SCALE_W(value) (value)*KWIDTH/375.0
#define SCALE_H(value) (value)*KHEIGHT/667.0
#define TEXTFONT 15



@class ListClassBtnView;
@protocol ListClassBtnViewDelegate <NSObject>

 //选择实现 不实现代理则使用默认值
/** 代理返回列间距 默认10 */
- (CGFloat)columnMarginInListClassBtnView:(ListClassBtnView *)ListClassBtnView;
/** 代理返回行间距 默认10 */
- (CGFloat)rowMarginInListClassBtnView:(ListClassBtnView *)ListClassBtnView;
/** 代理返回四周间距 默认{0,10,10,10} */
- (UIEdgeInsets)edgeInsetsInListClassBtnView:(ListClassBtnView *)ListClassBtnView;
/** 代理返回scroll距离两边的距离 内部已经做了比例处理 适配 默认70 */
- (CGFloat)scrollPaddingInListClassBtnView:(ListClassBtnView *)ListClassBtnView;
/** 代理返回头部视图的高度 内部已经做了比例处理 适配 默认50 */
- (CGFloat)headerHeightInListClassBtnView:(ListClassBtnView *)ListClassBtnView;

@end

@interface ListClassBtnView : UIView

/** 传入的显示的数据 必传 不传出问题自己负责 哈哈 */
@property(nonatomic,strong)NSArray *data;
/** chooseBlock */
@property(nonatomic,copy)void(^chooseBlock)(NSString *classId);

@property(nonatomic,weak)id<ListClassBtnViewDelegate> listClassDelegate;

@end
