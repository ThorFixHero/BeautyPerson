//
//  TitleModel.m
//  MMPerson
//
//  Created by WDTechnology on 15/8/2.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    WDLog(@"没有该字段---%@",key);
}

@end
