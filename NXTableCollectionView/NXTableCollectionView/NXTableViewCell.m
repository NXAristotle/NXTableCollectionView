//
//  NXTableViewCell.m
//  NXTableCollectionView
//
//  Created by linyibin on 2017/3/23.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXTableViewCell.h"

@implementation NXCollectionView


@end


@implementation NXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) )return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(46, 46);
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    self.collectionView = [[NXCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NXCollectionCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //  这个时候设置collectionView的fram
    self.collectionView.frame = self.contentView.bounds;
}

- (void)setupCollectionViewDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)delegate indexPath:(NSIndexPath *)indexPath {
    
    self.collectionView.dataSource = delegate;
    self.collectionView.delegate = delegate;
    self.collectionView.indexPath = indexPath;
    
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:YES];

    [self.collectionView reloadData];
}

@end
