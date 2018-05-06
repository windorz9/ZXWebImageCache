//
//  UIImageView+ZXWebChache.h
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZXWebChache)

/// 设置网络加载的图片
- (void)zx_setImageWithUrlString: (NSString *)urlString;

/// 设置带有占位图的的图片.
- (void)zx_setImageWithUrlString: (NSString *)urlString withPlaceHolderImageName: (NSString *)placeholderImageName;


@end
