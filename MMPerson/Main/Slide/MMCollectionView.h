//
//  MMCollectionView.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/1.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleItemModel;

@interface MMCollectionView : UICollectionView

@property(nonatomic,assign)TitleItemModel *item;
/**
 *  是否已经请求过数据
 */
@property(nonatomic,assign)BOOL isHaveData;
/**
 *  是否加载完毕
 *
 *  @param loadCompelete 加载成功和失败的标志
 */
-(void)loadData:(void(^)(BOOL isSuccess))loadCompelete;

@end
