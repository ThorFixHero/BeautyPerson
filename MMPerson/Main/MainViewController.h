//
//  ViewController.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/1.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainModel,MMCollectionViewCell;

@interface MainViewController : UIViewController
/**
 *  是否从引导视图接管视图
 */
@property(nonatomic,assign)BOOL isRootFromGuide;

-(void)chooseContainModel:(ContainModel*)model withCollectionViewCell:(MMCollectionViewCell*)collectionCell;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

