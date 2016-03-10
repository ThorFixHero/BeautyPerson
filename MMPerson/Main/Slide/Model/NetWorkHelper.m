//
//  NetWorkHelper.m
//  Anviz
//
//  Created by 王莉 on 14/11/12.
//  Copyright (c) 2014年 xuanit. All rights reserved.
//

#import "NetWorkHelper.h"
#import "Reachability.h"

@implementation NetWorkHelper

+(ConnectedStatus) getConnectedType{
    
    if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable){
        return CONNECTED_WIFI;
    }else if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable){
        return CONNECTED_GPRS;
    }else{
        return NOT_CONNECTED;
    }
}

@end
