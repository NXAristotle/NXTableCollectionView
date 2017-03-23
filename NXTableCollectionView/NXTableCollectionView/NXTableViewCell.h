//
//  NXTableViewCell.h
//  NXTableCollectionView
//
//  Created by linyibin on 2017/3/23.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *NXCollectionCellIdentifier = @"NXCollectionCell";

@interface NXTableViewCell : UITableViewCell

@property (nonatomic, strong) NXCollectionView *collectionView;

- (void)setupCollectionViewDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)delegate indexPath:(NSIndexPath *)indexPath;


@end
