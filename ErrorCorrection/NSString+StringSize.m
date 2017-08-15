//
//  NSString+StringSize.m
//  TeachingMonit
//
//  Created by wln100-IOS1 on 16/8/19.
//  Copyright © 2016年 TianXing. All rights reserved.
//

#import "NSString+StringSize.h"
#import "Common.h"
@implementation NSString (StringSize)

- (CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size{
    CGSize resultSize;
    //段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    
    //字体大小，换行模式
    NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
    
    resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attributes context:nil].size;
    return resultSize;
}

- (CGPoint)stringLastPointWithFont:(UIFont *)font Size:(CGSize)size {
    CGSize sz = [self sizeWithFont:font Size:CGSizeMake(MAXFLOAT, 20)];
    CGSize lineSz = [self sizeWithFont:font Size:CGSizeMake(kScreen_Width-20, MAXFLOAT)];
    CGPoint lastPoint;
    //判断是否换行
    if(sz.width <= lineSz.width) {
        lastPoint = CGPointMake(10 + sz.width, 10);
    } else {
        lastPoint = CGPointMake(10 + (int)sz.width % (int)lineSz.width,lineSz.height - sz.height);
    }
    
    return lastPoint;
}
@end
