//
//  NetWorkHelper.h
//  Anviz
//
//  Created by 王莉 on 14/11/12.
//  Copyright (c) 2014年 xuanit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum :NSInteger{
    NOT_CONNECTED=0,
    CONNECTED_WIFI,
    CONNECTED_GPRS
} ConnectedStatus;

@interface NetWorkHelper : NSObject

//获取当前网络连接类型帮助类
+(ConnectedStatus) getConnectedType;
@end
