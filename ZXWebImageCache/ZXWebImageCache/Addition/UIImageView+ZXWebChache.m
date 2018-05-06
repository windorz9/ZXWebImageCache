//
//  UIImageView+ZXWebChache.m
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import "UIImageView+ZXWebChache.h"
#import "ZXWebImageCacheManager.h"
#import <objc/runtime.h>

@interface UIImageView()

// 当前显示图片的地址
@property (nonatomic, copy) NSString *currentUrlString;


@end

@implementation UIImageView (ZXWebChache)

- (void)zx_setImageWithUrlString:(NSString *)urlString {
    
    // 防止连续设置图片, 导致imageView 上显示的图片连续切换
    // 判断当前设置的 urlString 是否与 currentUrlString 一致, 如果一致就不重新设置图片, 如果不一致就取消上一次的操作.
    if (![urlString isEqualToString: self.currentUrlString]) {
        // 取消上一次操作, 直接加载urlString
        [[ZXWebImageCacheManager sharedInstance] cancleOperation:self.currentUrlString];
        
    }
    
    // 记录上一次的图片地址
    self.currentUrlString = urlString;
    
    // 下载图片
    [[ZXWebImageCacheManager sharedInstance] downloadeWithUrlString:urlString complectionBlock:^(UIImage *image) {
        self.image = image;
    }];

}

- (void)zx_setImageWithUrlString:(NSString *)urlString withPlaceHolderImageName:(NSString *)placeholderImageName {
    
    self.image = [UIImage imageNamed: placeholderImageName];
    [self zx_setImageWithUrlString:urlString];

}


// 使用运行时关联对象 为 其扩充属性
- (void)setCurrentUrlString:(NSString *)currentUrlString {
    
    objc_setAssociatedObject(self, @"currentUrlString", currentUrlString, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (NSString *)currentUrlString {
    
    return objc_getAssociatedObject(self, @"currentUrlString");
}

@end
