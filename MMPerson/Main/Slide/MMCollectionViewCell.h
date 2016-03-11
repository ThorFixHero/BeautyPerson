//
//  MMCollectionViewCell.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/1.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainModel;
@interface MMCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

/**
 *  数据模型
 */
@property(nonatomic,strong)ContainModel *model;


@end
