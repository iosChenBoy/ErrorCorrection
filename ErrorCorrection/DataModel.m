/*
 *@class DataModel.m
 *
 *@abstract 关于这个类的一些基本描述
 *
 *@author Created by cll on 17/7/11(作者信息)
 */

#import "DataModel.h"

@implementation DataModel

- (instancetype)initDataModelWith:(NSString *)text {
    self = [super init];
    if (self) {
        self.contentText = text;
        self.isChange = NO;
        self.isDelete = NO;
        self.isAdd = NO;
        
        self.isSelect = NO;
    }
    return self;
}
@end
