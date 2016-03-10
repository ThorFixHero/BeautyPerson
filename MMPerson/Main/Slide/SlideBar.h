//
//  SlideBar.h
//  MMPerson
//
//  Created by 徐文达 on 15/8/2.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideBar : UIScrollView{
    
    SEL tittleButtonRespond;
}
@property(nonatomic, retain)NSMutableArray *itemAraray;

@property(nonatomic, retain)NSMutableArray *orignalItemArray;

@property(nonatomic, assign)UIViewController *vc;

-(instancetype)initWithSEL:(SEL)selector orignalArrary:(NSMutableArray*)orignal viewController:(UIViewController *)viewconroller;

@end
