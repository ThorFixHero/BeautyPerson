//
//  GuideSelectViewController.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "GuideSelectViewController.h"
#import "GuideSelectCollectionView.h"
#import "TitleModel.h"
#import "TitleItemModel.h"
#import "MainViewController.h"
#import "WDNavigationController.h"
#import "SaveCacheTools.h"


@interface GuideSelectViewController ()<GuideSelectCollectionViewDelegate>

@property(nonatomic,strong)NSArray *dataArray;

/**< 记录标题下标 */
@property(nonatomic,strong)NSMutableArray *titleNumberArray;
/**
 *  列表视图
 */
@property (weak, nonatomic) IBOutlet GuideSelectCollectionView *selectView;
/**
 *  保存缓存的数组数据
 */
@property(nonatomic,strong)NSMutableArray *saveCacheArray;

@end

@implementation GuideSelectViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请选择您喜欢的标签";
	_titleNumberArray = [NSMutableArray array];
    self.selectView.guideDelegate=self;
    self.selectView.selectArray=self.selectArray;

}

-(void)setSelectArray:(NSMutableArray *)selectArray{
    _selectArray=selectArray;
}

-(void)initInterface{
    [super initInterface];
    if (!_isComeFromAppDelegate) {
        [self setNavgationBarBack];
        self.title=@"请选择您喜欢的标签";
    }
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"save_tags"] forState:UIControlStateNormal];
    button.contentMode=UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(confirmSelectTitle) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavgationBarRightItem:@[button]];
}

#pragma mark---确认选择
-(void)confirmSelectTitle{
    
    if (_isComeFromAppDelegate) {
        
        if (self.selectArray.count==0) {
            [self showToastWithText:@"您还没有选择任何标签哦!"];
            return;
            
        }else{
            
            [SaveCacheTools saveCacheArray:self.saveCacheArray];
            
            MainViewController *main=[[MainViewController alloc] init];
            
            main.isRootFromGuide=YES;
            
            main.dataArray=self.selectArray;
            [UIApplication sharedApplication].delegate.window.rootViewController=[[WDNavigationController alloc] initWithRootViewController:main WithBgImage:[UIImage imageNamed:@"bg"]];

        }

    }else{
        
        if (!_titleNumberArray) {
            
            [self showToastWithText:@"您还没有选择任何标签哦!"];
            return;
            
        }else{//返回到主界面，刷新视图
            
            
            if ([_delegate respondsToSelector:@selector(selectBeautyPerson:)]) {
                [SaveCacheTools saveCacheArray:self.saveCacheArray];
                [_delegate selectBeautyPerson:self.selectArray];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
	
}

#pragma mark---数组的get方法

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
#pragma mark---更改数据结构
-(void)changeSelectArray{
    
}

#pragma mark---储存缓存的数组
-(NSMutableArray*)saveCacheArray{
    
    if (!_saveCacheArray) {
        _saveCacheArray=[NSMutableArray array];
    }
    return _saveCacheArray;
}

#pragma mark---列表视图的代理

-(void)guideSelectIndexPath:(NSIndexPath *)index withSelectCollectionViewCell:(UICollectionViewCell *)collectionCell withIsSelect:(BOOL)isSelect{
    
    
    TitleItemModel *model=self.dataArray[index.row];

    if (isSelect) {
		
        [self.selectArray addObject:self.dataArray[index.row]];
        
        [self.saveCacheArray addObject:[self handle:self.dataArray[index.row]]];
        
        WDLog(@"添加了%@",model.Model.name);
        
    }else{//没有选择时默认是全部选择，但是所有的都是待选择状态
        
        [self changeDeleteSelectArray:model.Model.name];
        [self deleteSaveDict:model.Model.name];
        
        WDLog(@"删除了%@",model.Model.name);
        
    }
}

-(NSDictionary*)handle:(TitleItemModel*)model{
    
    return @{@"name":model.Model.name};
}

-(void)deleteSaveDict:(NSString*)name{
    
    [self.saveCacheArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict=(NSDictionary*)obj;
        
        if ([dict[@"name"] isEqualToString:name]) {
            
            [self.saveCacheArray removeObject:dict];
            
            WDLog(@"删除了");
        }
    }];
    
}

-(BOOL)judgeSelectArrayContainObj:(NSString*)name{
    
    
    BOOL isContain=NO;
    
    for (TitleItemModel *model in self.selectArray) {
        if ([model.Model.name isEqualToString:name]) {
            isContain=YES;
            break;
        }
    }
    
    return isContain;
}

-(void)changeDeleteSelectArray:(NSString*)name{
    
    [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        TitleItemModel *model=(TitleItemModel*)obj;
        
        if ([model.Model.name isEqualToString:name]) {
            
            [self.selectArray removeObject:model];
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
