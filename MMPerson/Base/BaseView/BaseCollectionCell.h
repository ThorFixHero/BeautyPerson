//
//  BaseCollectionCell.h
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView withIndexPath:(NSIndexPath*)path;

@end
