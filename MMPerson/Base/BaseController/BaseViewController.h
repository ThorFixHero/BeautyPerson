//
//  BaseViewController.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController
/**
 *  初始化界面
 */
-(void)initInterface;
/**
 *  初始化变量
 */

-(void)initVal;
/**
 *  设置导航左边返回按钮
 */
-(void)setNavgationBarBack;
/**
 *  设置左边导航的buttonItem
 *
 *  @param customViewArray 自定义按钮的视图数组
 */
-(void)setNavgationBarLeftItem:(NSArray *)customViewArray;
/**
 *  设置右边导航的buttonItem
 *
 *  @param customViewArray 自定义右边的视图数组
 */
-(void)setNavgationBarRightItem:(NSArray *)customViewArray;

/**
 *  显示加载中...
 *
 *  @param text 显示要加加载的文字
 */
-(void)showLoadingViewWithText:(NSString *)text;
/**
 *  显示吐司
 *
 *  @param text 土司显示的文字
 */
-(void)showToastWithText:(NSString *)text;
/**
 *  移除加载中...
 */
-(void)removeLoadingView;

/**
 *  加载框
 */

@property(nonatomic,strong) MBProgressHUD *objLoadingView;
/**
 *  土司
 */
@property(nonatomic,strong) MBProgressHUD *objToast;

-(void)backPreviousController;

@end
