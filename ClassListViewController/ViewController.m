//
//  ViewController.m
//  ClassListViewController
//
//  Created by tztddong on 16/6/28.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ViewController.h"
#import "ListClassModel.h"
#import "ListClassView.h"
#import "MJExtension.h"
#import "UIView+XL.h"
#import "ListClassBtnView.h"

@interface ViewController ()<ListClassBtnViewDelegate>
@property(nonatomic,strong)NSMutableArray *classListArray;
/** button */
@property(nonatomic,strong)NSMutableArray *classBtnArray;
@end

@implementation ViewController
{
    ListClassView *listclassView;
    ListClassBtnView *listClassBtnView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)classBtnArray{
    
    if (!_classBtnArray) {
        
        _classBtnArray = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            NSDictionary *dic = @{@"className":[NSString stringWithFormat:@"大类_%d",i],
                                  @"classId":[NSString stringWithFormat:@"%d",i],
                                  @"classAtt":@[@{@"className":[NSString stringWithFormat:@"商品小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"下商品小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类蕾蕾_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小小小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  }
                                                ]
                                  };
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            if (i == 1 ||i == 6) {
                dict[@"classAtt"] = @[@{@"className":[NSString stringWithFormat:@"小类leilei_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小____类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小哈哈哈类leilei_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小金黄色的类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        }
                                      ];
            }
            if(i==0){
                dict[@"className"] = @"全部";
                dict[@"classAtt"] = @[];
            }
            [_classBtnArray addObject:dict];
        }

    }
    return _classBtnArray;
}

//分类
- (NSMutableArray *)classListArray{
    
    if (!_classListArray) {
        _classListArray = [NSMutableArray array];
        _classListArray = [ListClassModel mj_objectArrayWithKeyValuesArray:[self.classBtnArray copy]];
    }
    return _classListArray;
}
- (IBAction)click:(id)sender {
    
    listclassView = [ListClassView getListClassViewWithFrame:CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT) data:self.classListArray chooseBlock:^(NSString *classId) {
        [UIView animateWithDuration:0.3 animations:^{
            listclassView.y = -KHEIGHT;
        } completion:^(BOOL finished) {
            listclassView = nil;
            [listclassView removeFromSuperview];
            //在此处重新请求并刷新数据
        }];
        NSLog(@"%@",classId);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        listclassView.y = 0;
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [window addSubview:listclassView];

}
- (IBAction)clickButton:(id)sender {
    
    listClassBtnView = [[ListClassBtnView alloc]initWithFrame:CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT)];
    listClassBtnView.listClassDelegate = self;
    listClassBtnView.data = self.classBtnArray;

    [UIView animateWithDuration:0.3 animations:^{
        listClassBtnView.y = 0;
    }];
    [listClassBtnView setChooseBlock:^(NSString *classId) {
        [UIView animateWithDuration:0.3 animations:^{
            listClassBtnView.y = -KHEIGHT;
        } completion:^(BOOL finished) {
            listClassBtnView = nil;
            [listClassBtnView removeFromSuperview];
            //在此处重新请求并刷新数据
        }];
        NSLog(@"%@",classId);
    }];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [window addSubview:listClassBtnView];
}

#pragma mark ListClassBtnViewDelegate
- (CGFloat)columnMarginInListClassBtnView:(ListClassBtnView *)ListClassBtnView{
    return 10;
}

- (CGFloat)rowMarginInListClassBtnView:(ListClassBtnView *)ListClassBtnView{
    return 20;
}

- (UIEdgeInsets)edgeInsetsInListClassBtnView:(ListClassBtnView *)ListClassBtnView{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)scrollPaddingInListClassBtnView:(ListClassBtnView *)ListClassBtnView{
    return 50;
}
- (CGFloat)headerHeightInListClassBtnView:(ListClassBtnView *)ListClassBtnView{
    return 50;
}


@end
