//
//  ViewController.m
//  MMPerson
//
//  Created by 徐文达 on 15/8/1.
//  Copyright (c) 2015年 徐文达. All rights reserved.
//

#import "MainViewController.h"
#import "MMCollectionView.h"
#import "WaterFLayout.h"
#import "ContainModel.h"
#import "ContainViewController.h"
#import "TitleModel.h"
#import "TitleItemModel.h"
#import "GuideSelectViewController.h"
#import "SaveCacheTools.h"
#import "HandleSelectModelArray.h"
#import "HZPhotoBrowser.h"
#import "MMCollectionViewCell.h"
#import "AlbumShowController.h"

@interface MainViewController ()<UIScrollViewDelegate,GuideSelectViewControllerDelegate,HZPhotoBrowserDelegate>
/**
 *  图片的地址URL
 */
@property(nonatomic,copy)NSString *singleImageUrl;
/**
 *  单张显示的图片
 */
@property(nonatomic,strong)UIImage *singleImage;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:COLOR(18, 143, 208, 1.0) forKey: NSForegroundColorAttributeName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:COLOR(18, 143, 208, 1.0) forKey: NSForegroundColorAttributeName];
    self.title=@"美女控";
    if(!self.isRootFromGuide){
        [self loadLocalCacheArray];
        self.title=@"美女控";
    }
}

-(void)addChildrenControl{
    ContainViewController *containVC = [[ContainViewController alloc]initWithNibName:nil bundle:nil];
    [self.view addSubview:containVC.view];
    
    [self addChildViewController:containVC];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(MainWidth-45-1, 1, 45, 45);
    button.contentMode=UIViewContentModeScaleAspectFit;
    [button setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentSelectView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)loadLocalData{
    
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
    self.dataArray = tittleArray;
}

-(void)loadLocalCacheArray{
    
    NSArray *arr=[SaveCacheTools readeCacheArray];
    
    NSMutableArray *tittleArray = [[NSMutableArray alloc]init];

    for (NSInteger i=0; i<arr.count; i++) {
        
        NSDictionary *dict=arr[i];
        
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
    
    self.dataArray=tittleArray;
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx==0) {
            TitleItemModel *model=(TitleItemModel*)obj;
            model.Model.isFirst=YES;
        }
        
    }];
    
    _dataArray = [[NSMutableArray alloc]initWithArray:dataArray];
    
    [self addChildrenControl];
    
    ContainViewController *containVC =[self.childViewControllers objectAtIndex:0];
    
    [containVC setItemArray:_dataArray];
}


-(void)chooseContainModel:(ContainModel *)model withCollectionViewCell:(MMCollectionViewCell *)collectionCell{
    
    WDLog(@"%@",model);
    
    
    
    if (model.albumNum>1) {
        
        AlbumShowController *album=[[AlbumShowController alloc] initWithNibName:@"AlbumShowController" bundle:nil];
        album.model=model;
        [self.navigationController pushViewController:album animated:YES];
        
        
    }else{
        
        _singleImage=collectionCell.cellImage.image;
        
        _singleImageUrl=model.imageUrl;
        
        HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
        browserVc.sourceImagesContainerView = (UIView*)collectionCell;
        browserVc.imageCount =1;
        browserVc.currentImageIndex=0;
        // 代理
        browserVc.delegate = self;
        // 展示图片浏览器
        [browserVc show];
        
    }
    
}

#pragma mark - photobrowser代理方法


- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    return _singleImage;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:_singleImageUrl];
}

#pragma mark---出现选择内容的视图
-(void)presentSelectView{
    
    GuideSelectViewController *guide=[[GuideSelectViewController alloc] initWithNibName:@"GuideSelectViewController" bundle:nil];
	guide.delegate =self;
    guide.selectArray=[HandleSelectModelArray handleArary:self.dataArray];
    [self.navigationController pushViewController:guide animated:YES];
    
}
#pragma mark -  GuideSelectViewControllerDelegate
-(void)selectBeautyPerson:(NSArray *)selectArray
{
    [self.dataArray removeAllObjects];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    for (UIViewController *controll in self.childViewControllers) {
        [controll removeFromParentViewController];
    }
    
    self.dataArray=[NSMutableArray arrayWithArray:selectArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
