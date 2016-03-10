//
//  HandleSelectModelArray.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/10.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "HandleSelectModelArray.h"
#import "TitleItemModel.h"

@implementation HandleSelectModelArray

+(NSMutableArray *)handleArary:(NSArray *)array{
    
    NSMutableArray *changeArray=[NSMutableArray array];
    
    for (TitleItemModel *model in array) {
        
        TitleItemModel *changeModel=[[TitleItemModel alloc] init];
        
        changeModel.Model=model.Model;
        
        [changeArray addObject:changeModel];
        
    }
    
    return changeArray;
}

@end
