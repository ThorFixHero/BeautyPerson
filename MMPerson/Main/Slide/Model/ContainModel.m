//
//  ContainModel.m
//  Sport
//
//  Created by wangweiwangwei on 15/5/21.
//  Copyright (c) 2015年 xuanit. All rights reserved.
//

#import "ContainModel.h"
#import "AFNetworking.h"
#define BaseUrl @"http://image.baidu.com/data/imgs?"


@implementation ContainModel

-(id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    WDLog(@"XXXXXXXX%@",key);
    
}

-(void)loadContainDataChanelID:(NSString*)chanelID pageIndex:(NSInteger )page Success:(void(^)(id data,NSInteger count))success Faild:(void(^)(id data))faild{
    
    NSDictionary *dict=@{@"col":@"美女",@"tag":chanelID,@"sort":@"1",@"tag3":@"",@"rn":@"60",@"pn":[NSString stringWithFormat:@"%ld",(long)page],@"p":@"channel",@"from":@"1"};
    
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,[self buildParams:dict]]];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:BaseUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *containModelArray = [NSMutableArray array];
        
        NSArray *array = [responseObject objectForKey:@"imgs"];
        NSInteger count = [[responseObject objectForKey:@"totalNum"] integerValue];
        
        for (NSDictionary *dictionary in array ) {
            
            ContainModel *containModel = [[ContainModel alloc]initWithDic:dictionary];
            containModel.aid=dictionary[@"id"];
            containModel.user_id=dictionary[@"owner"][@"userId"];
            
            if (containModel.imageHeight!=0&&containModel.imageWidth!=0) {
                [containModelArray addObject:containModel];
            }
            
        }
        if (success) {
            success(containModelArray,count);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faild) {
            if (error) {
                WDLog(@"%@",error);
            }
            faild(@"获取数据失败");
        }
    }];
}

-(NSString*)buildParams:(NSDictionary*)paramsDict{
    NSArray *keyArray=[paramsDict allKeys];
    NSString *params=@"";
    for (NSString *key in keyArray) {
        NSString *valueKey=paramsDict[key];
        params=[params stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[valueKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    params=[params substringToIndex:params.length-1];
    return params;
}


@end
