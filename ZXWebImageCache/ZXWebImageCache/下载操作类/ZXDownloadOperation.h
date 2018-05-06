//
//  ZXDownloadOperation.h
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXDownloadOperation : NSOperation

// 下载图片的url
@property (nonatomic, copy) NSString *urlString;

// 下载完成回调
@property (nonatomic, copy) void (^complectionBlock)(UIImage *img);

+ (instancetype)downloaderOperationWithUrlString: (NSString *)urlString complectionBlock: (void (^)(UIImage *image))complectionBlock;

@end
