//
//  GuideSelectCollectionView.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/7.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideSelectCollectionViewDelegate <NSObject>

@optional
/**
 *  选中的cell
 *
 *  @param index          选中的当前行数和段数
 *  @param collectionCell 选中的当前的cell
 *  @param isSelect       选中的状态

 */
-(void)guideSelectIndexPath:(NSIndexPath*)index withSelectCollectionViewCell:(UICollectionViewCell*)collectionCell withIsSelect:(BOOL)isSelect;

@end


@interface GuideSelectCollectionView : UICollectionView

/**
 *  列表的代理
 */
@property(nonatomic,assign)id<GuideSelectCollectionViewDelegate>guideDelegate;
/**
 *  选中的数组
 */
@property(nonatomic,strong)NSMutableArray *selectArray;

@end
