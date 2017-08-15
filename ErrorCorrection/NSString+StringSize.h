//
//  NSString+StringSize.h
//  TeachingMonit
// 
//  Created by wln100-IOS1 on 16/8/19.
//  Copyright © 2016年 TianXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StringSize)

//计算字符串长度，高度
- (CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size;

//计算字符串最后一个元素的位置
- (CGPoint)stringLastPointWithFont:(UIFont *)font Size:(CGSize)size;
@end
