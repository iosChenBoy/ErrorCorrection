/*
 *@class AddTextLabel.m
 *
 *@abstract 关于这个类的一些基本描述
 *
 *@author Created by cll on 17/7/12(作者信息)
 */

#import "AddTextLabel.h"

@implementation AddTextLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor orangeColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
