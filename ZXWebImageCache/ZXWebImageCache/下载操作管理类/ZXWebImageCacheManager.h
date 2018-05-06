//
//  ZXWebImageCacheManager.h
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXWebImageCacheManager : NSObject

/// 单例
+ (instancetype)sharedInstance;

/// 下载图片
- (void)downloadeWithUrlString: (NSString *)urlString complectionBlock: (void (^)(UIImage *image))complectionBlock;

/// 取消操作
- (void)cancleOperation: (NSString *)urlString;


@end
