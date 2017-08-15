//
//  ViewController.m
//  ErrorCorrection
//
//  Created by wln100-IOS1 on 17/7/4.
//  Copyright © 2017年 TianXing. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"
#import "NSString+StringSize.h"
#import "DataModel.h"
#import "LTInputAccessoryView.h"
#import "Common.h"

#import "AddTipLabel.h"
#import "AddTextLabel.h"

@interface ViewController () <UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSIndexPath *selectIndexPath; //选中的cell的indexPath
    CGRect cellToScreenRect; //点击的cell在屏幕的位置
    
    CGRect rectInConllectionView; //cell在collectionview的位置
}

@property (nonatomic, strong) NSMutableAttributedString *mutableString;

@property (nonatomic, strong) NSArray *textData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *contextString = @"December 6th, Sunday Sunny\nToday my classmate Liu Yun and I paid a visit to Human Provincial Museum. We arrived there at 8 o'clock in the morning. To our delight, the museum is free of charge.\nWe spent a whole morning walking around the museum and enjoyed the exhibitions very much, especially the Mawangdui Han Tombs. We really felt amazed at the well-preserved female corpse. It is really a miracle.\nWe had a good day in the museum, which not only enriched our knowledge but also led us through history to appreciate the mystery and magnificence of Chinese civilization.\nWe had a good day in the museum, which not only enriched our knowledge but also led us through history to appreciate the mystery and magnificence of Chinese civilization.\nWe had a good day in the museum, which not only enriched our knowledge but also led us through history to appreciate the mystery and magnificence of Chinese civilization.";
    
    NSArray *sectionArray = [contextString componentsSeparatedByString:@"\n"];
    NSMutableArray *mutSection = [NSMutableArray arrayWithArray:sectionArray];
    
    for (int i=0; i<sectionArray.count; i++) {
        NSString *string = sectionArray[i];
        NSArray *data = [string componentsSeparatedByString:@" "];
        NSMutableArray *mutData = [NSMutableArray arrayWithArray:data];
        for (int j=0; j<data.count; j++) {
            DataModel *model = [[DataModel alloc] initDataModelWith:data[j]];
            [mutData replaceObjectAtIndex:j withObject:model];
        }
        [mutSection replaceObjectAtIndex:i withObject:mutData];
    }
    self.textData = mutSection;
    NSLog(@"%@", self.textData);
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
    //添加键盘监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ---- 根据键盘高度将当前视图向上滚动同样高度
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //判断所点击的cell是否被键盘覆盖
    if (cellToScreenRect.origin.y+offset+64>kScreen_Height) {
        //将视图上移计算好的偏移
        if(offset > 0) {
            [UIView animateWithDuration:duration animations:^{
                self.collectionView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


#pragma mark - UICollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.textData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.textData[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    DataModel *model = self.textData[indexPath.section][indexPath.row];
    [cell setValueWith:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *model = self.textData[indexPath.section][indexPath.row];
    CGSize size = [model.contentText sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(MAXFLOAT, 20)];
    return CGSizeMake(size.width+3, 35);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreen_Width, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    return view;
}

//定义每个UICollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectIndexPath = indexPath;
    
    //遍历数据源，判断是否选中，改变背景色
    for (int i=0; i<self.textData.count; i++) {
        NSArray *array = self.textData[i];
        if (i==indexPath.section) {
            for (int j=0; j<array.count; j++) {
                DataModel *model = array[j];
                if (j==indexPath.row) {
                    model.isSelect = YES;
                } else {
                    model.isSelect = NO;
                }
            }
        } else {
            for (int k=0; k<array.count; k++) {
                DataModel *model = array[k];
                model.isSelect = NO;
            }
        }
    }
    

    //取出点击的cell
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //获取点击的cell所在屏幕的位置
    rectInConllectionView = [collectionView convertRect:cell.frame toView:collectionView];
    cellToScreenRect = [collectionView convertRect:rectInConllectionView toView:self.view];
    

    DataModel *model = self.textData[indexPath.section][indexPath.row];
    if (model.isDelete==YES || model.isChange==YES || model.isAdd==YES) {
        [self showDeleteAnswerMenuInView:cell];
    } else {
        [self showDoExerciseMenuInView:cell];
    }
    
    [self.collectionView reloadData];
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/**
 做题时的menu

 @param cell cell
 */
- (void)showDoExerciseMenuInView:(CollectionViewCell *)cell {
    UIMenuItem *changeMenuItem = [[UIMenuItem alloc] initWithTitle:@"改为" action:@selector(changeEvent)];
    UIMenuItem *deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteEvent)];
    UIMenuItem *addMenuItem = [[UIMenuItem alloc] initWithTitle:@"在之前添加" action:@selector(addEvent)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:changeMenuItem, deleteMenuItem, addMenuItem, nil]];
    CGRect rect = CGRectMake(0, 5, cell.frame.size.width, 1);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
}


/**
 删除答案时的弹出menu

 @param cell cell
 */
- (void)showDeleteAnswerMenuInView:(CollectionViewCell *)cell {
    UIMenuItem *delAnswerMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除此答案" action:@selector(delAnswerEvent)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:delAnswerMenuItem, nil]];
    CGRect rect = CGRectMake(0, 5, cell.frame.size.width, 1);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuController处理
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action==@selector(changeEvent) || action==@selector(deleteEvent) || action==@selector(addEvent) || action==@selector(delAnswerEvent)) {
        return YES;
    } else {
        return NO;
    }
}


/**
 修改该单词
 */
- (void)changeEvent {
    DataModel *model = self.textData[selectIndexPath.section][selectIndexPath.row];
    __weak typeof(self) weakSelf = self;
    LTInputAccessoryView *keyBoardView = [LTInputAccessoryView new];
    NSString *defaultText = [NSString stringWithFormat:@"将%@改成", model.contentText];
    [keyBoardView showKeyboardType:UIKeyboardTypeDefault content:defaultText Block:^(NSString *contentStr) {
        if (!NULLString(contentStr)) {
            //修改线显示
            model.isChange = YES;
            //选中状态取消
            model.isSelect = NO;
            model.changeText = contentStr;
            [weakSelf.collectionView reloadData];
        }
        //必须成为第一响应者才能弹出menu
        [self becomeFirstResponder];
    }];
}


/**
 删除该单词
 */
- (void)deleteEvent {
    DataModel *model = self.textData[selectIndexPath.section][selectIndexPath.row];
    model.isDelete = YES;
    model.isSelect = NO;
    [self.collectionView reloadData];
}

/**
 在之前添加
 */
- (void)addEvent {
    DataModel *model = self.textData[selectIndexPath.section][selectIndexPath.row];
    __weak typeof(self) weakSelf = self;
    LTInputAccessoryView *keyBoardView = [LTInputAccessoryView new];
    NSString *defaultText = [NSString stringWithFormat:@"在%@之前添加", model.contentText];
    [keyBoardView showKeyboardType:UIKeyboardTypeDefault content:defaultText Block:^(NSString *contentStr) {
        if (!NULLString(contentStr)) {
            //添加的状态
            model.isAdd = YES;
            //选中状态取消
            model.isSelect = NO;
            [weakSelf.collectionView reloadData];
            
            AddTipLabel *addTip = [[AddTipLabel alloc] init];
            addTip.frame = CGRectMake(rectInConllectionView.origin.x-5, rectInConllectionView.origin.y+15, 8, 10);
            [self.collectionView addSubview:addTip];
            
            AddTextLabel *addText = [[AddTextLabel alloc] init];
            CGSize addTextSize = [contentStr sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(MAXFLOAT, 15)];
            addText.frame = CGRectMake(0, 0, addTextSize.width+1, 15);
            addText.center = CGPointMake(addTip.center.x, addTip.center.y+8);
            addText.text = contentStr;
            [self.collectionView addSubview:addText];
        }
        //必须成为第一响应者才能弹出menu
        [self becomeFirstResponder];
    }];

}


/**
 删除此答案事件
 */
- (void)delAnswerEvent {
    DataModel *model = self.textData[selectIndexPath.section][selectIndexPath.row];
    model.isDelete = NO;
    model.isChange = NO;
    model.isSelect = NO;
    model.changeText = nil;
    
    //判断是否是删除“在此之前添加”的答案
    if (model.isAdd == YES) {
        model.isAdd = NO;
        //遍历所有的add相关视图，删除选中cell的添加的相关内容视图
        for (id object in self.collectionView.subviews) {
            if ([object isKindOfClass:[AddTipLabel class]]) {
                AddTipLabel *addTip = (AddTipLabel *)object;
                if (addTip.frame.origin.x==rectInConllectionView.origin.x-5) {
                    for (id textObject in self.collectionView.subviews) {
                        if ([textObject isKindOfClass:[AddTextLabel class]]) {
                            AddTextLabel *addText = (AddTextLabel *)textObject;
                            if (addText.center.x==addTip.center.x) {
                                [addText removeFromSuperview];
                            }
                        }
                    }
                    [addTip removeFromSuperview];
                }
            }
    
        }
        
    }
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
