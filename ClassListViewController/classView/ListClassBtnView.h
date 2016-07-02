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
#define KMARGIN 10//默认间距
#define KNAVHEIGHT 64 //导航栏的高度
#define FONTSIZE(x)  [UIFont systemFontOfSize:x]//设置字体大小
#define SCALE_W(value) (value)*KWIDTH/375.0
#define SCALE_H(value) (value)*KHEIGHT/667.0
#define TEXTFONT 15
#define HEADBTNHEIGHT 50

@interface ListClassBtnView : UIView

+ (ListClassBtnView *)getListClassBtnViewwWithFrame:(CGRect)frame data:(NSArray *)data chooseBlock:(ChooseClass)chooseBlock;
@property(nonatomic,copy)ChooseClass chooseBlock;
@property(nonatomic,strong)NSArray *data;

@end
