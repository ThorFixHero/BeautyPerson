//
//  GuideSelectCollectionView.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/7.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "GuideSelectCollectionView.h"
#import "GuideSelectCell.h"
#import "TitleItemModel.h"
#import "TitleModel.h"

@interface GuideSelectCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 *  数据模数组
 */
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation GuideSelectCollectionView


-(void)awakeFromNib{
    self.delegate=self;
    self.dataSource=self;
    self.allowsMultipleSelection=YES;
}

-(void)setSelectArray:(NSMutableArray *)selectArray{
    
    _selectArray=[[NSMutableArray alloc] initWithArray:selectArray];
    
    __weak typeof(self) weakSelf=self;
    
    [_selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WDLog(@"%ld",(long)_selectArray.count);
        
        TitleItemModel *title=(TitleItemModel*)obj;
        
        [weakSelf.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TitleItemModel *model=(TitleItemModel*)obj;
           
            if ([title.Model.name isEqualToString:model.Model.name]) {
                
                [self collectionView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
                
                [self selectItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                
            }
            
            
        }];
        
        
        
        
    }];
    
    
    
}

-(NSArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray=[[NSArray alloc] init];
        NSString *filePath=[[NSBundle mainBundle] pathForResource:@"TagsPlist.plist" ofType:nil];
        NSArray *modelArr1=[NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray *tittleArray = [[NSMutableArray alloc]init];
        
        for(NSInteger i=0;i<modelArr1.count;i++){
            
            NSDictionary *dict=modelArr1[i];
            
            TitleItemModel *itemModel = [[TitleItemModel alloc]init];
            
            TitleModel *model=[[TitleModel alloc] initWithDic:dict];
            
            if (i==0) {
                model.isFirst=YES;
            }else{
                model.isFirst=NO;
            }
            itemModel.Model=model;
            
            [tittleArray addObject:itemModel];
            
        }
        _dataArray = tittleArray;
    }
    return _dataArray;
}

#pragma mark---列表视图的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GuideSelectCell *cell=[GuideSelectCell cellWithCollectionView:collectionView withIndexPath:indexPath];
    TitleItemModel *model=self.dataArray[indexPath.row];
    
    cell.model=model.Model;
    
    if ([self isContainData:model]) {
        
        [cell selectCellWithStatus:YES];
        
    }else{
        [cell selectCellWithStatus:NO];
    }
    return cell;
}

-(BOOL)isContainData:(TitleItemModel*)model{
    
    BOOL isContain=NO;
    
    for (TitleItemModel *m1 in self.selectArray) {
        if ([model.Model.name isEqualToString:m1.Model.name]) {
            isContain =YES;
            break;
        }
        
    }
    
    return isContain;

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((MainWidth-4)/4, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 1, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.guideDelegate respondsToSelector:@selector(guideSelectIndexPath:withSelectCollectionViewCell:withIsSelect:)]) {
        
        [self.guideDelegate guideSelectIndexPath:indexPath withSelectCollectionViewCell:nil withIsSelect:YES];
        [self changeCellStatus:YES with:indexPath withCollectionView:collectionView];

    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.guideDelegate respondsToSelector:@selector(guideSelectIndexPath:withSelectCollectionViewCell:withIsSelect:)]) {
        [self.guideDelegate guideSelectIndexPath:indexPath withSelectCollectionViewCell:nil withIsSelect:NO];
        [self changeCellStatus:NO with:indexPath withCollectionView:collectionView];
    }
}

-(void)changeCellStatus:(BOOL)status with:(NSIndexPath*)path withCollectionView:(UICollectionView*)collectionView{
    
    GuideSelectCell *cell=(GuideSelectCell*)[collectionView cellForItemAtIndexPath:path];
    [cell selectCellWithStatus:status];
}


@end
