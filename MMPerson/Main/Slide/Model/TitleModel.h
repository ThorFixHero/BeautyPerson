//
//  TitleModel.h
//  MMPerson
//
//  Created by 徐文达 on 15/8/2.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleModel : NSObject
/**
 *  标签
 */
@property(nonatomic,copy)NSString *name;
/**
 *  是否是第一个
 */
@property(nonatomic,assign)BOOL isFirst;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
