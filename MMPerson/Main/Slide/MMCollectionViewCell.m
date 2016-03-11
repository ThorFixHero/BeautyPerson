//
//  MMCollectionViewCell.m
//  MMPerson
//
//  Created by WDTechnology on 15/8/1.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import "MMCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ContainModel.h"
@interface MMCollectionViewCell ()

/**
 *  照片的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@end

@implementation MMCollectionViewCell

- (void)awakeFromNib {
    
}

-(void)setModel:(ContainModel *)model{
    _model=model;
    
    if (model.albumNum>1) {
        
        self.numberLab.hidden=NO;
        
        [self.numberLab setText:[NSString stringWithFormat:@"%ld",(long)model.albumNum]];
        
    }else{
        
        self.numberLab.hidden=YES;
    }
    
    [_cellImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultpic"]];
}

@end
