/*
 *@class DataModel.h
 *
 *@abstract 关于这个类的一些基本描述
 *
 *@author Created by cll on 17/7/11(作者信息)
 */

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic, strong) NSString *contentText; //文本内容
@property (nonatomic) BOOL isDelete; //是否删除
@property (nonatomic) BOOL isChange; //是否修改
@property (nonatomic) BOOL isAdd; //是否在之前添加

@property (nonatomic) BOOL isSelect; //是否选中

@property (nonatomic, strong) NSString *changeText; //修改的内容

- (instancetype)initDataModelWith:(NSString *)text;

@end
