//
//  NSString+Paths.h
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Paths)

// 追加文档路径
- (NSString *)appendDocumentDir;

// 增加缓存路径
- (NSString *)appendCacheDir;


// 增加临时路径
- (NSString *)appendTempDir;

@end
