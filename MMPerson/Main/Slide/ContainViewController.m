//
//  ContainViewController.m
//  MMPerson
//
//  Created by WDTechnology on 15/8/2.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import "ContainViewController.h"
#import "SlideBar.h"
#import "SlideView.h"
#import "MainViewController.h"
#import "ContainModel.h"

@interface ContainViewController (){
    SlideBar *sliderBar;
    SlideView *sliderView;

}

@end

@implementation ContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sliderBar=[[SlideBar alloc] initWithSEL:@selector(containIndex:) orignalArrary:self.itemArray viewController:self];
    [self.view addSubview:sliderBar];
    sliderView =  [[SlideView alloc]initWithViewController:self];
    [self.view addSubview:sliderView];

}

-(void)setItemArray:(NSMutableArray *)itemArray{
    _itemArray=itemArray;
    
    [sliderBar setItemAraray:_itemArray];
    
    [sliderView changeSeeModel];
    
    [sliderView setItemArray:sliderBar.orignalItemArray];
}

-(void)containIndex:(UIButton *)button{
    
    WDLog(@"选着了%@",button.currentTitle);
    
    [sliderView setContentOffset:CGPointMake(sliderView.frame.size.width *button.tag, 0) animated:NO];
}

-(void)chooseContainModel:(ContainModel *)model withCollectionViewCell:(MMCollectionViewCell *)collectionCell{
    
    MainViewController * choiceViewController =(MainViewController *) self.parentViewController;
    [choiceViewController chooseContainModel:model withCollectionViewCell:collectionCell];
}



@end
