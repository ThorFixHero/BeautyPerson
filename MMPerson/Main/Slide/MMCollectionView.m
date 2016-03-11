//
//  MMCollectionView.m
//  MMPerson
//
//  Created by WDTechnology on 15/8/1.
//  Copyright (c) 2015年 WDTechnology. All rights reserved.
//

#import "MMCollectionView.h"
#import "MJRefresh.h"
#import "MMCollectionViewCell.h"
#import "ContainModel.h"
#import "TitleItemModel.h"
#import "NetWorkHelper.h"
#import "SlideView.h"

@interface MMCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    ContainModel* model;
    NSInteger pageIndex;
    NSMutableArray *containModelArray;
    BOOL isRefressh;
    NSInteger serverCount;
}

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation MMCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate=self;
        self.dataSource=self;
        model=[[ContainModel alloc] init];
        self.isHaveData=NO;
        containModelArray=[NSMutableArray array];
        pageIndex=0;
        self.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshData];
        }];
        self.footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setItem:(TitleItemModel *)item{
    _item=item;
    if (item.Model.isFirst) {
        [self.header beginRefreshing];
    }
}

-(void)loadData:(void (^)(BOOL))loadCompelete{
    if (isRefressh) {
        return;
    }
    if ([NetWorkHelper getConnectedType]!=NOT_CONNECTED) {
        isRefressh=YES;
        MMCollectionView * __weak weakSelf = self;

        [model loadContainDataChanelID:self.item.Model.name pageIndex:pageIndex Success:^(id data, NSInteger count) {
            if (loadCompelete) {
                loadCompelete(YES);
            }
            
            if ([(NSArray*)data count]) {
                
                pageIndex+=60;
            }
            
            [containModelArray addObjectsFromArray:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                serverCount = count;
                
                if (containModelArray.count >= serverCount) {
                    
                    self.footer.hidden=YES;
                    
                }else{
                    
                    self.footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                    
                }
                
                if (containModelArray.count) {
                    weakSelf.isHaveData = YES;
                }
                
                [weakSelf reloadData];
            });
            
        } Faild:^(id data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (loadCompelete) {
                    loadCompelete(NO);
                }
                weakSelf.isHaveData = NO;
            });
        }];
        
    }else{
        if (loadCompelete) {
            loadCompelete(NO);
        }
        self.isHaveData = NO;
    }

}

-(void)loadMoreData{
    
    [self loadData:^(BOOL isSuccess) {
        
        [self.footer endRefreshing];
        isRefressh = NO;
    }];
    
}

-(void)refreshData{
    
    pageIndex = 0;
    
    [self loadData:^(BOOL isSuccess) {
        
        [self.header endRefreshing];
        
        if (isSuccess){
            
            [containModelArray removeAllObjects];
        }
        isRefressh = NO;
        
    }];
    
}


#pragma mark--瀑布流的代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return containModelArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"MMCollectionViewCell";
    [collectionView registerNib:[UINib nibWithNibName:@"MMCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    MMCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"MMCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell=[[MMCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.model=containModelArray[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{//collectionview里每一个小的模块就是一个cell
    //根据返回值里的文字和图片的大小来设置每一个cell的大小
    ContainModel *imageModel=containModelArray[indexPath.row];
    return CGSizeMake(MainWidth/2, MainWidth/2/imageModel.imageWidth*imageModel.imageHeight);
}


#pragma mark----选中当前的的cell视图
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SlideView *slide=(SlideView*)[self superview];
    
    MMCollectionViewCell *cell=(MMCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    [slide chooseContainModel:containModelArray[indexPath.row] withCollectionViewCell:cell];
}


@end
