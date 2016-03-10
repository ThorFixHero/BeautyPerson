//
//  BaseView.h
//  MMPerson
//
//  Created by 徐文达 on 15/11/5.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
/**
 *  从xib中构建视图
 *
 *  @return 返回视图对象
 */
+(instancetype)buildViewFromNib;

@end
