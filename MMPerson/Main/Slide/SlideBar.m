//
//  SlideBar.m
//  MMPerson
//
//  Created by 徐文达 on 15/8/2.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import "SlideBar.h"
#import "TitleItemModel.h"
#import "TitleModel.h"

@implementation SlideBar

-(instancetype)initWithSEL:(SEL)selector orignalArrary:(NSMutableArray *)orignal viewController:(UIViewController *)viewconroller{
    if (self=[super init]) {
        
        self.orignalItemArray = [[NSMutableArray alloc]initWithArray:orignal];
        
        self.vc=viewconroller;
        
        tittleButtonRespond=selector;
        
        self.itemAraray=orignal;
        
        [self setFrame:CGRectMake(1, 1,viewconroller.view.frame.size.width - 45 - 2, 45)];

        self.showsHorizontalScrollIndicator=NO;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
    }
    return self;
}


-(void)setItemAraray:(NSMutableArray *)itemAraray{
    
    _itemAraray = [NSMutableArray arrayWithArray:itemAraray];
    
    [self createView:_itemAraray];
    
}


-(void)createView:(NSMutableArray *)array {
    
    NSMutableArray *nowArray = [self compareWithArray:array];
    
    NSInteger containOffx = 0;
    
    for (TitleItemModel *item in nowArray) {
        
        
        CGSize containSize = [item.Model.name sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0],NSFontAttributeName,nil]];
        
        
        containOffx += 5;
        
        //如果对象的按钮没有创建
        if (!item.titleSelectButton) {
            
            item.titleSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            item.titleSelectButton.frame = CGRectMake(containOffx, 0, containSize.width, 45);
            item.titleSelectButton.tag = [self.itemAraray indexOfObject:item];
            [item.titleSelectButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [item.titleSelectButton setTitle:item.Model.name forState:UIControlStateNormal];
            
            [item.titleSelectButton setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            [self addSubview:item.titleSelectButton];
            
            [item.titleSelectButton addTarget:self.vc action:self->tittleButtonRespond forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            item.titleSelectButton.frame = CGRectMake(containOffx, 0, containSize.width, 45);
            
            item.titleSelectButton.tag = [nowArray indexOfObject:item];
        }
        containOffx += containSize.width;
    }
    
    
    self.contentSize = CGSizeMake(containOffx, self.frame.size.height);
}
-(NSMutableArray *)compareWithArray:(NSMutableArray *)array{
    
    
    NSMutableArray *deleArray = [[NSMutableArray alloc]initWithArray:self.orignalItemArray];
    
    for (TitleItemModel *orignal in deleArray) {
        
        BOOL isContain = NO;
        
        for (TitleItemModel *currentItem in array) {
            
            if ([orignal.Model.name isEqualToString:currentItem.Model.name]) {
                
                isContain = YES;
                break;
            }else{
                isContain = NO;
            }
        }
        if (!isContain) {
            
            [self.orignalItemArray removeObject:orignal];
            
            [orignal.titleSelectButton removeFromSuperview];
            
            [orignal.collection removeFromSuperview];
            
        }
        
    }
    
    
    NSMutableArray *orderArray = [[NSMutableArray alloc]init];
    
    
    NSInteger i=0;
    
    for (TitleItemModel *currentItem  in array ) {
        
        for (TitleItemModel*orignal  in self.orignalItemArray) {
            
            if ([orignal.Model.name isEqualToString: currentItem.Model.name]) {
                
                if (i==0) {
                    orignal.Model.isFirst=YES;
                }
                [orderArray addObject:orignal];
                
            }
        }
        i++;
    }
    
    self.orignalItemArray = nil;
    self.orignalItemArray = [[NSMutableArray alloc]initWithArray:orderArray];
    
    
    for (TitleItemModel *currentItem  in array ) {
        
        BOOL isContain = NO;
        
        for (TitleItemModel *orignal  in orderArray) {
            
            if ([orignal.Model.name isEqualToString:currentItem.Model.name]) {
                
                isContain = YES;
                break;
            }else{
                
                isContain = NO;
                
            }
        }
        if (!isContain) {
            
            [self.orignalItemArray insertObject:currentItem atIndex:[array indexOfObject:currentItem]];
        }
        
    }
    return self.orignalItemArray;
}

@end
