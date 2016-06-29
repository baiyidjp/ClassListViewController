//
//  ListClassModel.h
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/28.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListClassModel : NSObject

@property(nonatomic,copy)NSString *classId;
@property(nonatomic,copy)NSString *className;
@property(nonatomic,strong)NSArray *classAtt;
@property(nonatomic,assign)CGSize nameSize;

@end
