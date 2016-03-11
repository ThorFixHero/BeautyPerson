//
//  AlbumCollectionCell.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/18.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "AlbumCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "AlbumShowModel.h"

@interface AlbumCollectionCell ()
/**
 *  展示的相册图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *showImage;


@end

@implementation AlbumCollectionCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)path{
    
    static NSString *cellId=@"AlbumCollectionCell";
    
    [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    
    AlbumCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:path];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}

-(void)setModel:(AlbumShowModel *)model{
    _model=model;
    [_showImage sd_setImageWithURL:[NSURL URLWithString:model.downloadUrl] placeholderImage:[UIImage imageNamed:@"defaultpic"]];
    
    
}

-(UIImage *)getCurrentImage{
    
    return self.showImage.image;
}

- (void)awakeFromNib {
    
}

@end
