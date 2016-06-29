//
//  ListClassView.h
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/28.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KWIDTH  [UIScreen mainScreen].bounds.size.width//屏幕的宽
#define KHEIGHT [UIScreen mainScreen].bounds.size.height//屏幕的高
#define KMARGIN 10//默认间距
#define KNAVHEIGHT 64 //导航栏的高度
#define FONTSIZE(x)  [UIFont systemFontOfSize:x]//设置字体大小

typedef void(^ChooseClass)(NSString *classId);

@interface ListClassView : UIView

+ (ListClassView *)getListClassViewWithFrame:(CGRect)frame data:(NSArray *)data chooseBlock:(ChooseClass)chooseBlock;

@property(nonatomic,copy)ChooseClass chooseBlock;
@property(nonatomic,strong)NSArray *data;

@end
