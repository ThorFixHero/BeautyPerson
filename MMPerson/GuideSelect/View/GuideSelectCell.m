//
//  GuideSelectCell.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/5.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "GuideSelectCell.h"
#import "TitleModel.h"

@interface GuideSelectCell ()
/**
 *  选择的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
/**
 *  选择状态的图片
 */
@property (weak, nonatomic) IBOutlet UIButton *isChooseImage;

@end

@implementation GuideSelectCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)path{
    
    static NSString *cellId=@"GuideSelectCell";
    
    [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    
    GuideSelectCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:path];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    self.tipsLab.font=[UIFont systemFontOfSize:17*ratio];
    
}

-(void)setModel:(TitleModel *)model{
    _model=model;
    [self.tipsLab setText:model.name];
}

#pragma mark--cell是否是选中状态
-(void)selectCellWithStatus:(BOOL)isSelect{
    
    if (!isSelect) {
        self.tipsLab.textColor=COLOR(80, 80, 80, 1.0);
    }else{
        self.tipsLab.textColor=ButtonColor;
    }
    self.isChooseImage.selected=isSelect;

}


@end
