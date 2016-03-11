//
//  GuideSelectCell.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionCell.h"


@class TitleModel;

@interface GuideSelectCell : BaseCollectionCell

/**
 *  选择标签的数据模型
 */
@property(nonatomic,strong)TitleModel *model;
/**
 *  选中的cell的状态
 *
 *  @param isSelect 是否是选中的状态
 */
-(void)selectCellWithStatus:(BOOL)isSelect;



@end
