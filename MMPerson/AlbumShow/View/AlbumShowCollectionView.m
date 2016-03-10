//
//  AlbumShowCollectionView.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/18.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "AlbumShowCollectionView.h"
#import "AlbumCollectionCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AlbumShowCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,strong)NSIndexPath *path;
/**
 *  展示的loading的控件
 */
@property(nonatomic,weak)UIActivityIndicatorView *indicatorView;

@end


@implementation AlbumShowCollectionView

@synthesize dataArray=_dataArray;

-(void)awakeFromNib{
    self.dataSource=self;
    self.delegate=self;
    self.path=[NSIndexPath indexPathForItem:0 inSection:0];
    [self registerNib:[UINib nibWithNibName:@"AlbumCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCollectionCell"];
}

-(void)setDataArray:(NSArray *)dataArray{
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:dataArray];
    
    [array removeLastObject];
    
    _dataArray=[[NSArray alloc] initWithArray:array];
    
    [self reloadData];
    
}

#pragma mark---列表视图的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    AlbumCollectionCell *cell =[AlbumCollectionCell cellWithCollectionView:collectionView withIndexPath:indexPath];
    cell.model=self.dataArray[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(MainWidth, MainHight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 1, 0, 0);
}

#pragma mark---写入相册
-(void)writeImageToAlbum{
    
    AlbumCollectionCell *cell=(AlbumCollectionCell*)[self collectionView:self cellForItemAtIndexPath:self.path];
    
    UIImageWriteToSavedPhotosAlbum([cell getCurrentImage], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    
    if (error) {
        label.text = @"保存失败!";
    }   else {
        label.text = @"图片已保存到相册!";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    
    if ([ALAssetsLibrary authorizationStatus]==ALAuthorizationStatusNotDetermined||[ALAssetsLibrary authorizationStatus]==ALAuthorizationStatusRestricted||[ALAssetsLibrary authorizationStatus]==ALAuthorizationStatusDenied) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"未保存到相册" message:@"您还没有授权程序访问您的照片，请到设置-》隐私-》照片中授权！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
}

#pragma mark - 判断偏移量
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/MainWidth+1;
    self.path=[NSIndexPath indexPathForItem:page inSection:0];
    if (self.offsetBlock) {
        self.offsetBlock(page);
    }
    
}


@end
