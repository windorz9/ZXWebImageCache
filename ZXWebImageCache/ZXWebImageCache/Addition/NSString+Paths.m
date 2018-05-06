//
//  NSString+Paths.m
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import "NSString+Paths.h"

@implementation NSString (Paths)




- (NSString *)appendDocumentDir {
    
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingString:self.lastPathComponent];

}


- (NSString *)appendCacheDir {
    
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingString:self.lastPathComponent];
    
}


- (NSString *)appendTempDir {
    
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingString:self.lastPathComponent];
    
    
    
}

@end
