/*
 *@class CollectionViewCell.m
 *
 *@abstract 关于这个类的一些基本描述
 *
 *@author Created by cll on 17/7/6(作者信息)
 */

#import "CollectionViewCell.h"
#import "DataModel.h"
#import "NSString+StringSize.h"
#import "Common.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = [UIColor darkGrayColor];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.contentLabel];
        
        //删除线
        self.deleteLine = [[UIView alloc] init];
        self.deleteLine.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.deleteLine];
        
        self.changeLine = [[UIView alloc] init];
        self.changeLine.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.changeLine];
        
        self.changeText = [[UILabel alloc] init];
        self.changeText.backgroundColor = [UIColor clearColor];
        self.changeText.textColor = [UIColor orangeColor];
        self.changeText.font = [UIFont systemFontOfSize:15];
        self.changeText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.changeText];
        
    }
    return self;
}

- (void)setValueWith:(DataModel *)model {
    CGSize size = [model.contentText sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(MAXFLOAT, 15)];
    self.contentLabel.frame = CGRectMake(0, 0, size.width+1, 15);
    self.contentLabel.text = model.contentText;
    
    //修改的内容的控件
    self.changeText.frame = CGRectMake(0, 20, size.width+3, 15);
    self.changeText.adjustsFontSizeToFitWidth = YES;
    
    if (model.isSelect == YES) {
        self.contentLabel.backgroundColor = RGBACOLOR(209, 227, 255, 1);
    } else {
        self.contentLabel.backgroundColor = [UIColor clearColor];
    }

    //删除线
    self.deleteLine.frame = CGRectMake(0, 8, size.width+1, 1.5);
    if (model.isDelete == YES) {
        self.deleteLine.hidden = NO;
    } else {
        self.deleteLine.hidden = YES;
    }

    //修改线
    self.changeLine.frame = CGRectMake(0, 18, size.width+1, 1.5);
    if (model.isChange == YES) {
        self.changeLine.hidden = NO;
        self.changeText.text = model.changeText;
    } else {
        self.changeLine.hidden = YES;
        self.changeText.text = nil;
    }
    
}

@end
