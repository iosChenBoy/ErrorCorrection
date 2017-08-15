//
//  Common.h
//  ErrorCorrection
//
//  Created by wln100-IOS1 on 17/7/10.
//  Copyright © 2017年 TianXing. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define NULLString(string) ((![string isKindOfClass:[NSString class]]) || [string isKindOfClass:[NSNull class]] || [string isEqualToString:@""] || (string == nil) || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [string length]<=0)

#endif /* Common_h */

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
