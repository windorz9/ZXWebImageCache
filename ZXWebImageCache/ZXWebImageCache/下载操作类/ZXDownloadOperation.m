//
//  ZXDownloadOperation.m
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import "ZXDownloadOperation.h"
#import "NSString+Paths.h"

@implementation ZXDownloadOperation

// 重写 main 方法, 操作添加到队列去时会执行此方法
- (void)main {
    // 创建自动释放池, 因为是异步操作, 所以无法访问主线程的自动释放池, 所以需要手动创建
    @autoreleasepool {
        
        // 创建一个断言 判断 complectionBlock 是否存在, 不存在就直接崩溃弹出错误
        NSAssert(self.complectionBlock != nil, @"complection 不能为空");
        
        // 下载网络图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 缓存到沙盒当中
        if (data) {
            [data writeToFile:[self.urlString appendCacheDir] atomically:YES];
            
        }
        // 这里是子线程
        ZXLog(@"下载图片 %@, %@", self.urlString, [NSThread currentThread]);
        ZXLog(@"从网络下载图片");
        
        // 判断操作是否取消
        // 如果取消, 直接进行return. 放在耗时操作之后更加合理一些, 取消操作的时候, 不会拦截耗时操作, 耗时操作还可以执行. 下次想显示图像的时候, 耗时操作也执行完毕.
        if (self.isCancelled) {
            return;
        }
        // 图片下载完成后回到主线程刷新ui, 通过之前使用了断言, 这里不需要if (self.complectionBlock) 判断了
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *image = [UIImage imageWithData:data];
            self.complectionBlock(image);
        }];
        
    }
    
    
}



+ (instancetype)downloaderOperationWithUrlString: (NSString *)urlString complectionBlock: (void (^)(UIImage *))complectionBlock {
    
    ZXDownloadOperation *op = [[ZXDownloadOperation alloc] init];
    op.urlString = urlString;
    op.complectionBlock = complectionBlock;
    return op;
    
}

@end
