//
//  ContainViewController.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/2.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainModel,MMCollectionViewCell;
@interface ContainViewController : UIViewController

@property(nonatomic, retain)NSMutableArray *itemArray;

-(void)chooseContainModel:(ContainModel *)model withCollectionViewCell:(MMCollectionViewCell *)collectionCell;

@end
