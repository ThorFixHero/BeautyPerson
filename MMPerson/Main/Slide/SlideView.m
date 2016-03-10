//
//  SlideView.m
//  MMPerson
//
//  Created by 徐文达 on 15/8/2.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import "SlideView.h"
#import "TitleItemModel.h"
#import "MMCollectionView.h"
#import "WaterFLayout.h"
#import "MJRefresh.h"
#import "ContainViewController.h"
@interface SlideView ()<UIScrollViewDelegate>{
    /**
     *  当前的页数
     */
    NSInteger currentPage;
    /**
     *  当前查看的模型
     */
    TitleItemModel *currentSeeModel;
}

@end

@implementation SlideView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.delegate=self;
        self.showsHorizontalScrollIndicator=NO;
    }
    return self;
}

-(instancetype)initWithViewController:(UIViewController *)viewContoller{
    if (self=[super init]) {
        self.vc=viewContoller;
        self.frame=CGRectMake(0, 45, MainWidth, MainHight-64-45);
        self.pagingEnabled=YES;
        self.bounces=NO;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setItemArray:(NSMutableArray *)itemArray{
    
    _itemArray=[[NSMutableArray alloc] initWithArray:itemArray];
    if (!currentSeeModel) {
        currentSeeModel=[_itemArray firstObject];
        [currentSeeModel.titleSelectButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        currentSeeModel.titleSelectButton.titleLabel.font=[UIFont systemFontOfSize:18.0];
        currentPage=0;
    }
    [self loadViews];
}

-(void)loadViews{
    for (TitleItemModel *item in self.itemArray) {
        if (!item.collection) {
            WaterFLayout *layout=[[WaterFLayout alloc] init];
            layout.minimumColumnSpacing=2.0;
            layout.minimumInteritemSpacing=2.0;
            MMCollectionView *collection=[[MMCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
            
            collection.item=item;
            item.collection=collection;
            item.collection.frame=CGRectMake([self.itemArray indexOfObject:item]*MainWidth, 0, MainWidth, self.frame.size.height);
            [self addSubview:item.collection];
        }else{
            item.collection.frame=CGRectMake([self.itemArray indexOfObject:item]*MainWidth, 0, MainWidth, self.frame.size.height);
            item.collection.item=item;
        }
    }
    self.contentSize=CGSizeMake(MainWidth*self.itemArray.count, self.frame.size.height);
    if ([self.itemArray containsObject:currentSeeModel]) {
        currentPage=[self.itemArray indexOfObject:currentSeeModel];
    }else{
        currentSeeModel=[self.itemArray firstObject];
    }
    UIScrollView *superItemView=(UIScrollView*)[currentSeeModel.titleSelectButton superview];
    [superItemView scrollRectToVisible:currentSeeModel.titleSelectButton.frame animated:YES];
    [self scrollRectToVisible:currentSeeModel.collection.frame animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint poit = scrollView.contentOffset;
    
    NSInteger nextPag = poit.x/self.frame.size.width;
    
    if ( nextPag != currentPage) {
        
        TitleItemModel *nextItem = [self.itemArray objectAtIndex:nextPag];
        
        [nextItem.titleSelectButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        [nextItem.titleSelectButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        if (currentPage >= self.itemArray.count) {
            
            currentPage = 0;
        }
        
        TitleItemModel *currentItem = [self.itemArray objectAtIndex:currentPage];
        
        [currentItem.titleSelectButton setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0] forState:UIControlStateNormal];
        [currentItem.titleSelectButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        currentPage = nextPag;
        
        UIScrollView *superItemView = (UIScrollView *)[nextItem.titleSelectButton superview];
        [superItemView scrollRectToVisible:nextItem.titleSelectButton.frame animated:YES];
        
        currentSeeModel = nextItem;
        
        
        MMCollectionView *containView =(MMCollectionView *)currentSeeModel.collection;
        
        if (!containView.isHaveData) {
            
            [containView.header valueForKey:@"beginRefreshing"];
        }
        
        if (currentPage == 0) {
            
            [currentSeeModel.titleSelectButton setTitleColor:ButtonColor forState:UIControlStateNormal];
            [currentSeeModel.titleSelectButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        }
        
    }else{
        
        TitleItemModel *nextItem = [self.itemArray objectAtIndex:nextPag];
        [nextItem.titleSelectButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    }
    
    
}

-(void)changeSeeModel{
    self->currentSeeModel=nil;
}

-(void)chooseContainModel:(ContainModel *)containModel withCollectionViewCell:(MMCollectionViewCell *)collectionCell{
    
    [(ContainViewController *)self.vc chooseContainModel:containModel withCollectionViewCell:collectionCell];
}

@end
