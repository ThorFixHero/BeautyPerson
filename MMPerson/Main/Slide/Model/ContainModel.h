//
//  ContainModel.h
//  Sport
//
//  Created by wangweiwangwei on 15/5/21.
//  Copyright (c) 2015年 xuanit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainModel : NSObject

/**
 *  图片高度
 */
@property(nonatomic,assign)CGFloat imageHeight;
/**
 *  图片宽度
 */
@property(nonatomic,assign)CGFloat imageWidth;

/**
 *  下载地址
 */
@property(nonatomic,copy)NSString *downloadUrl;
/**
 *  相册的id
 */
@property(nonatomic,copy)NSString *albumId;
/**
 *  缩略图
 */
@property(nonatomic,copy)NSString *thumbLargeUrl;
/**
 *  更小的缩略图
 */
@property(nonatomic,copy)NSString *thumbnailUrl;
/**
 *  正常的图片
 */
@property(nonatomic,copy)NSString *imageUrl;
/**
 *  相册名称
 */
@property(nonatomic,copy)NSString *albumName;
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  描述
 */
@property(nonatomic,copy)NSString *desc;
/**
 *  相册的照片数目
 */
@property(nonatomic,assign)NSInteger albumNum;
/**
 *  大类
 */
@property(nonatomic,copy)NSString *column;
/**
 *  分类
 */
@property(nonatomic,copy)NSString *objTag;

@property(nonatomic,copy)NSString *dressId;

@property(nonatomic,strong)NSArray *user_id;
/**
 *  相册对应的id
 */
@property(nonatomic,copy)NSString *aid;

@property(nonatomic,copy)NSString *setId;

-(id)initWithDic:(NSDictionary *)dic;

-(void)loadContainDataChanelID:(NSString*)chanelID pageIndex:(NSInteger )page Success:(void(^)(id data,NSInteger count))success Faild:(void(^)(id data))faild;


@end
