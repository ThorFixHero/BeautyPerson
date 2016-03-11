//
//  SlideBar.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/2.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
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
