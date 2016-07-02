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

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *classListArray;
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

//分类
- (NSMutableArray *)classListArray{
    
    if (!_classListArray) {
        _classListArray = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            NSDictionary *dic = @{@"className":[NSString stringWithFormat:@"大类_%d",i],
                                  @"classId":[NSString stringWithFormat:@"%d",i],
                                  @"classAtt":@[@{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  },
                                                @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                                  @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                                  }
                                                ]
                                  };
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            if (i == 1 ||i == 6) {
                dict[@"classAtt"] = @[@{@"className":[NSString stringWithFormat:@"小类leilei_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
                                        @"classId":[NSString stringWithFormat:@"%d%d",i,i]
                                        },
                                      @{@"className":[NSString stringWithFormat:@"小类_%d%d",i,i],
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
            [_classListArray addObject:dict];
        }
//        _classListArray = [ListClassModel mj_objectArrayWithKeyValuesArray:[_classListArray copy]];
    }
    return _classListArray;
}
- (IBAction)click:(id)sender {
    
//    listclassView = [ListClassView getListClassViewWithFrame:CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT) data:self.classListArray chooseBlock:^(NSString *classId) {
//        [UIView animateWithDuration:0.3 animations:^{
//            listclassView.y = -KHEIGHT;
//        } completion:^(BOOL finished) {
//            listclassView = nil;
//            [listclassView removeFromSuperview];
//            //在此处重新请求并刷新数据
//        }];
//        NSLog(@"%@",classId);
//    }];
//    [UIView animateWithDuration:0.3 animations:^{
//        listclassView.y = 0;
//    }];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
//    [window addSubview:listclassView];
    
    listClassBtnView = [ListClassBtnView getListClassBtnViewwWithFrame:CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT) data:self.classListArray chooseBlock:^(NSString *classId) {
        [UIView animateWithDuration:0.3 animations:^{
            listClassBtnView.y = -KHEIGHT;
        } completion:^(BOOL finished) {
            listClassBtnView = nil;
            [listClassBtnView removeFromSuperview];
            //在此处重新请求并刷新数据
        }];
        NSLog(@"%@",classId);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        listClassBtnView.y = 0;
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [window addSubview:listClassBtnView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
