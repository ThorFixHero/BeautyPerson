//
//  AlbumShowController.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/18.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "AlbumShowController.h"
#import "AlbumShowProxy.h"
#import "AlbumShowCollectionView.h"
#import "ContainModel.h"
#import "NetWorkHelper.h"
@interface AlbumShowController ()
/**
 *  相册的最底部视图
 */
@property (weak, nonatomic) IBOutlet AlbumShowCollectionView *albumView;

@end

@implementation AlbumShowController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg1.png"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey: NSForegroundColorAttributeName];
    
    self.title  = [NSString stringWithFormat:@"1/%ld",(long)self.model.albumNum];
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 40, 40);
    [back setBackgroundImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavgationBarLeftItem:@[back]];
    
    
    UIButton *downLoad=[UIButton buttonWithType:UIButtonTypeCustom];
    
    downLoad.frame=CGRectMake(0, 0, 40, 40);
    [downLoad setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    
    [downLoad addTarget:self action:@selector(saveImageWithAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self setNavgationBarRightItem:@[downLoad]];
    
    [self loadData];
    
    self.albumView.offsetBlock = ^(NSInteger page){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title  = [NSString stringWithFormat:@"%ld/%ld",page,self.model.albumNum];
        });
    };
    
}
#pragma mark---保存图片到相册

-(void)saveImageWithAlbum{
    
    
    [self.albumView writeImageToAlbum];
}



-(void)loadData{
    
    if([NetWorkHelper getConnectedType]==NOT_CONNECTED){
        [self showToastWithText:@"您的网络有问题哦!"];
        return;
    }
    
    [self showLoadingViewWithText:@"数据加载中...."];
    __weak typeof(self) weakSelf=self;
    
    [AlbumShowProxy loadAlbumWith:_model loadAlbumSuccess:^(id data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self removeLoadingView];
            weakSelf.albumView.dataArray=data;
            
        });
        
    } loadAlbumFailed:^(id data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self showToastWithText:@"您的网络有问题哦!"];
            
        });
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
