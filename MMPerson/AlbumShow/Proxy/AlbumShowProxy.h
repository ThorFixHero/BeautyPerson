//
//  AlbumShowProxy.h
//  MMPerson
//
//  Created by 徐文达 on 15/11/18.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContainModel;

@interface AlbumShowProxy : NSObject
/**
 *  获取相册详情
 *
 *  @param model   传入的数据模型
 *  @param success 请求相册数据成功
 *  @param failed  请求相册数据失败
 */
+(void)loadAlbumWith:(ContainModel*)model loadAlbumSuccess:(void(^)(id data))success loadAlbumFailed:(void(^)(id data))failed;

@end
