//
//  WDNavigationController.m
//  SearchCar
//
//  Created by wangweiwangwei on 15/3/17.
//  Copyright (c) 2015年 wangweiwangwei. All rights reserved.
//

#import "WDNavigationController.h"

@interface WDNavigationController ()

@property(nonatomic,strong)UIImage *bgImage;

@end

@implementation WDNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController WithBgImage:(UIImage *)image{
    
    if (self=[super initWithRootViewController:rootViewController]) {
        self.bgImage=image;
        [self makeNavAppearance];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)makeNavAppearance{
    // 1.appearance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 2.设置导航栏的背景图片
    [bar setBackgroundImage:self.bgImage forBarMetrics:UIBarMetricsDefault];
    // 3.设置导航栏文字的主题
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName :COLOR(18, 143, 208, 1.0),NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]
                                  }];
    //NSFontAttributeName:[UIFont fontWithName:@"经典圆体简" size:18.0]
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
@end
