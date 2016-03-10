//
//  AppVersionTools.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/10.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "AppVersionTools.h"

@implementation AppVersionTools

+(BOOL)isHaveSaveVerison{
    
    //是否显示新特性或者用户指引
    

    NSString *key = (NSString *)kCFBundleVersionKey;

    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([[AppVersionTools readeVersion] isEqualToString:saveVersion]) {
        return YES;
    }else{
        return NO;
    }
    
}

+(NSString*)readeVersion{
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    return version;
}

+(void)saveNewVersion{
    
    NSString *key = (NSString *)kCFBundleVersionKey;

    [[NSUserDefaults standardUserDefaults] setObject:[AppVersionTools readeVersion] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
