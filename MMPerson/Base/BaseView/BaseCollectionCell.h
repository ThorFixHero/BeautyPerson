//
//  BaseCollectionCell.h
//  MMPerson
//
//  Created by 徐文达 on 15/11/5.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView withIndexPath:(NSIndexPath*)path;

@end
