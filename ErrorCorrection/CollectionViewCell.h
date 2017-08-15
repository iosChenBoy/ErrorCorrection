/*
 *@class CollectionViewCell.h
 *
 *@abstract 关于这个类的一些基本描述
 *
 *@author Created by cll on 17/7/6(作者信息)
 */

#import <UIKit/UIKit.h>

@class DataModel;
@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *contentLabel; //短文内容
@property (nonatomic, strong) UIView *deleteLine; //删除线
@property (nonatomic, strong) UIView *changeLine; //修改线
@property (nonatomic, strong) UILabel *changeText; //修改的内容

@property (nonatomic, strong) UILabel *addTip; //添加内容的标志
@property (nonatomic, strong) UILabel *addText; //添加的内容


- (void)setValueWith:(DataModel *)model;

@end
