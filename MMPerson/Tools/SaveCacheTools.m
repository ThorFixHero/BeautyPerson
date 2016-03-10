//
//  SaveCacheTools.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/10.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "SaveCacheTools.h"

#define CacheArray @"cacheArray"

@implementation SaveCacheTools

+(void)saveCacheArray:(NSArray *)array{
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:CacheArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(NSArray*)readeCacheArray{
    
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:CacheArray];
    
    return array;
}

@end
