//
//  BaseViewController.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/5.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVal];
    [self initInterface];
    // Do any additional setup after loading the view from its nib.
}

-(void)initVal{
    
}

-(void)showLoadingViewWithText:(NSString *)text{
    [self removeLoadingView];
    [self.view setUserInteractionEnabled:NO];
    self.objLoadingView=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.objLoadingView];
    self.objLoadingView.labelText=text;
    self.objLoadingView.labelFont=[UIFont fontWithName:@"Arial" size:13.0f];
    [self.objLoadingView show:YES];
}
-(void)showToastWithText:(NSString *)text{
    if(self.objToast!=nil){
        [self.objToast hide:YES];
        [self.objToast removeFromSuperview];
        self.objToast=nil;
    }
    self.objToast=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.objToast];
    self.objToast.mode=MBProgressHUDModeText;
    self.objToast.labelText=text;
    self.objToast.labelFont=[UIFont fontWithName:@"Arial" size:12.0f];
    self.objToast.margin=10.0f;
    [self.objToast setYOffset:[[UIScreen mainScreen] bounds].size.height/2-150];
    [self.objToast show:YES];
    [self.objToast hide:YES afterDelay:2];
}

-(void)removeLoadingView{
    
    [self.view setUserInteractionEnabled:YES];
    if(self.objLoadingView!=nil){
        [self.objLoadingView hide:YES];
        [self.objLoadingView removeFromSuperview];
        self.objLoadingView=nil;
    }
}

-(void)initInterface{
    
}

-(void)setNavgationBarBack
{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 40);
    backBtn.contentMode=UIViewContentModeScaleAspectFit;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backPreviousController) forControlEvents:UIControlEventTouchUpInside];
    [self setNavgationBarLeftItem:@[backBtn]];
}

-(void)backPreviousController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavgationBarLeftItem:(NSArray *)customViewArray
{
    NSMutableArray *viewArr=[NSMutableArray array];
    for (UIView *v1 in customViewArray) {
        UIBarButtonItem *LeftItem=[[UIBarButtonItem alloc] initWithCustomView:v1];
        [viewArr addObject:LeftItem];
    }
    self.navigationItem.leftBarButtonItems=viewArr;
}

-(void)setNavgationBarRightItem:(NSArray *)customViewArray
{
    NSMutableArray *viewArr=[NSMutableArray array];
    for (UIView *v1 in customViewArray) {
        UIBarButtonItem *LeftItem=[[UIBarButtonItem alloc] initWithCustomView:v1];
        [viewArr addObject:LeftItem];
    }
    self.navigationItem.rightBarButtonItems=viewArr;
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
