//
//  TitleItemModel.h
//  MMPerson
//
//  Created by WDTechnology on 15/8/2.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCollectionView.h"
#import "TitleModel.h"
@interface TitleItemModel : NSObject

@property(nonatomic,strong)MMCollectionView *collection;

@property(nonatomic,strong)UIButton *titleSelectButton;

@property(nonatomic,strong)TitleModel *Model;

@end
