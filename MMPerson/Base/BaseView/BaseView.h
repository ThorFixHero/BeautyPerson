//
//  BaseView.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
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
