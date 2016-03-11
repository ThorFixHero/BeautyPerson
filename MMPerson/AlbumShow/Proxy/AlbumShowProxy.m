//
//  AlbumShowProxy.m
//  MMPerson
//
//  Created by WDTechnology on 15/11/18.
//  Copyright © 2015年 WDTechnology. All rights reserved.
//

#import "AlbumShowProxy.h"
#import "ContainModel.h"
#import "AlbumShowModel.h"
#import "AFNetworking.h"
#define AlbumUrl @"http://image.baidu.com/data/albumimgs?"

@implementation AlbumShowProxy

+(void)loadAlbumWith:(ContainModel *)model loadAlbumSuccess:(void (^)(id))success loadAlbumFailed:(void (^)(id))failed{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *dict=@{@"col":model.column,@"tag":model.objTag,@"sort":@"0",@"from":@"1",@"user_id":model.user_id,@"aid":@"",@"cid":model.aid,@"setid":model.setId,@"dressid":model.dressId};
    
    [manager GET:AlbumUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSMutableArray *containModelArray = [NSMutableArray array];
        
        NSArray *array = [responseObject objectForKey:@"imgs"];
        
        for (NSDictionary *dict in array) {
            
            AlbumShowModel *model=[[AlbumShowModel alloc] initWithDict:dict];
            
            [containModelArray addObject:model];
            
        }
        
        if(success){
            success(containModelArray);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WDLog(@"%@",error.description);
        if (failed) {
            failed(error);
        }

    }];
}

@end
