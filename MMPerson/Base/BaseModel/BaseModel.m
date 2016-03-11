//
//  BaseModel.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    WDLog(@"没有该字段%@",key);
}

@end
