//
//  AlbumCollectionCell.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/18.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionCell.h"
@class AlbumShowModel;

@interface AlbumCollectionCell : BaseCollectionCell
/**
 *  展示图片的数据源
 */
@property(nonatomic,strong)AlbumShowModel *model;
/**
 *  获取当前展示的图片对象
 *
 *  @return 返回当前的图片对象
 */
-(UIImage*)getCurrentImage;

@end
