//
//  ListClassModel.m
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/28.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import "ListClassModel.h"
#import "MJExtension.h"

@implementation ListClassModel

- (void)setClassName:(NSString *)className{
    
    _className = className;
    
    CGSize nameS = [className sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
    self.nameSize = nameS;
}

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"classAtt":[ListClassModel class]};
}

@end
