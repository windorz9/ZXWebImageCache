//
//  ZXWebImageChacheHeader.h
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#ifndef ZXWebImageChacheHeader_h
#define ZXWebImageChacheHeader_h

#ifdef DEBUG
#define ZXLog(...) NSLog(@"\n%s \n第%d行 \n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZXLog(...)

#endif


#endif /* ZXWebImageChacheHeader_h */
