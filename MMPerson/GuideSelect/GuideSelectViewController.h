//
//  GuideSelectViewController.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@protocol GuideSelectViewControllerDelegate <NSObject>

@optional
/**
 *  选中的数组
 *
 *  @param selectArray 选择完成之后的数组,数组中是全数组的下标
 */
-(void)selectBeautyPerson:(NSArray*)selectArray;

@end

@interface GuideSelectViewController : BaseViewController

/**
 *  代理
 */
@property(nonatomic,assign)id<GuideSelectViewControllerDelegate>delegate;

/**
 *  选中的数组
 */
@property(nonatomic,strong)NSMutableArray *selectArray;
/**
 *  是否从appdelegate过来
 */
@property(nonatomic,assign)BOOL isComeFromAppDelegate;

@end
