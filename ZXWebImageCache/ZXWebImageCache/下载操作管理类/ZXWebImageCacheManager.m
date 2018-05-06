//
//  ZXWebImageCacheManager.m
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import "ZXWebImageCacheManager.h"
#import "NSString+Paths.h"
#import "ZXDownloadOperation.h"

@interface ZXWebImageCacheManager()

// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
// 下载缓存池
@property (nonatomic, strong) NSMutableDictionary *operationCache;
// 内容缓存池(内存缓存) 从字典转为 NSCache.
@property (nonatomic, strong) NSCache *imageCache;


@end

@implementation ZXWebImageCacheManager

+ (instancetype)sharedInstance {
    
    static ZXWebImageCacheManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[ZXWebImageCacheManager alloc] init];
    });
    
    return instance;
    
    
}

- (void)downloadeWithUrlString:(NSString *)urlString complectionBlock:(void (^)(UIImage *))complectionBlock {
    
    // 设置断言 complectionBlock 不能为空
    NSAssert(complectionBlock != nil, @"complectionBlock 不能为nil");
    
    // 如果下载操作已经存在就直接返回
    if (self.operationCache[urlString]) {
        return;
    }
    // 判断图片是否有缓存 (内存和磁盘缓存)
    if ([self checkImageCache:urlString]) {
        // 如果有缓存就回调设置图像
        complectionBlock([self.imageCache objectForKey:urlString]);
        return;
    }
    
    // 如果到了这里, 说明内存当中没有缓存图像, 就需要自行下载图像
    ZXDownloadOperation *op = [ZXDownloadOperation downloaderOperationWithUrlString:urlString complectionBlock:^(UIImage *image) {
        
        complectionBlock(image);
        
        // 将图片下载完成回调后 还需要缓存图像
        // 内存缓存
        [self.imageCache setObject:image forKey:urlString];
        // 下载完成, 移除操作
        [self.operationCache removeObjectForKey:urlString];
        
    }];
    
    [self.queue addOperation:op];
    // 缓存下载操作
    self.operationCache[urlString] = op;

}

/// 取消操作
- (void)cancleOperation:(NSString *)urlString {
    //避免第一次urlString为空，然后调用[self.operationCache removeObjectForKey:urlString]导致崩溃的问题
    if (urlString == nil) {
        return;
    }
    
    [self.operationCache[urlString] cancel];
    
    // 从缓存池当中移除操作
    [self.imageCache removeObjectForKey:urlString];
    
    
}


/// 检查是否有缓存 (内存和磁盘缓存)
- (BOOL)checkImageCache:(NSString *)urlString {
    
    // 1. 检查内存缓存
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存当中加载");
        return YES;
    }
    
    // 2. 检查沙盒缓存
    UIImage *img = [UIImage imageWithContentsOfFile:[urlString appendCacheDir]];
    NSLog(@"沙盒路径: %@", [urlString appendCacheDir]);
    
    if (img) {
        // 沙盒存在图片就从沙盒加载
        // 如果沙盒当中存在图片就将其保存到内存当中
        [self.imageCache setObject:img forKey:urlString];
        return YES;
    }
    return NO;
}


#pragma mark 懒加载
- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        // 设置最大并发数, 如果不设置就会全部任务同时进行执行, 这样会有问题, 不利于性能, 一般最好不要超过 8 .
        _queue.maxConcurrentOperationCount = 4;
        
    }
    
    return _queue;
    
}

- (NSMutableDictionary *)operationCache {
    
    if (_operationCache == nil) {
        _operationCache = [[NSMutableDictionary alloc] init];
    }
    
    return _operationCache;
}

- (NSCache *)imageCache {
    
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc] init];
        
        // 设置最大图片缓存个数
        _imageCache.countLimit = 100;
    }
    return _imageCache;
    
}


@end
