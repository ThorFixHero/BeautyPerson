//
//  AppDelegate.m
//  MMPerson
//
//  Created by 徐文达 on 15/8/1.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WDNavigationController.h"
#import "AppVersionTools.h"
#import "GuideSelectViewController.h"
#import "SaveCacheTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    
    if ([AppVersionTools isHaveSaveVerison]) { // 不是第一次使用这个版本
        
        if ([SaveCacheTools readeCacheArray].count==0) {
            GuideSelectViewController *guide=[[GuideSelectViewController alloc] initWithNibName:@"GuideSelectViewController" bundle:nil];
            guide.isComeFromAppDelegate=YES;
            guide.selectArray=[NSMutableArray array];
            self.window.rootViewController=[[WDNavigationController alloc] initWithRootViewController:guide WithBgImage:[UIImage imageNamed:@"bg"]];
            
        }else{
            self.window.rootViewController=[[WDNavigationController alloc] initWithRootViewController:[[MainViewController alloc] init] WithBgImage:[UIImage imageNamed:@"bg.png"]];
        }
        
    } else {
        
        [AppVersionTools saveNewVersion];
        
        GuideSelectViewController *guide=[[GuideSelectViewController alloc] initWithNibName:@"GuideSelectViewController" bundle:nil];
        guide.isComeFromAppDelegate=YES;
        guide.selectArray=[NSMutableArray array];
        self.window.rootViewController=[[WDNavigationController alloc] initWithRootViewController:guide WithBgImage:[UIImage imageNamed:@"bg"]];
    }
    
    

    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
