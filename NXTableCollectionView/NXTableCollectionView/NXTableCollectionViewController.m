//
//  NXTableCollectionViewController.m
//  NXTableCollectionView
//
//  Created by linyibin on 2017/3/23.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXTableCollectionViewController.h"
#import "NXTableViewCell.h"

const int cellHeight = 64;

@interface NXTableCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray; /**< 模型数组 */

/** 用于记录偏移量 */
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end

@implementation NXTableCollectionViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        const int numberOfTableViewRows = 32;         /**< table的行数 */
        const int numberOfCollectionViewCells = 16;   /**< 每行table的collectionCell个数 */
        
        //  设置随机颜色
        for (int tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
        {
            NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
            
            for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
            {
                
                CGFloat red = arc4random() % 255;
                CGFloat green = arc4random() % 255;
                CGFloat blue = arc4random() % 255;
                UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
                
                [colorArray addObject:color];
            }
            
            [_dataArray addObject:colorArray];
        }

        
    }
    return _dataArray;
}

- (NSMutableDictionary *)contentOffsetDictionary {
    if (_contentOffsetDictionary == nil) {
        _contentOffsetDictionary = [NSMutableDictionary dictionary];
    }
    return _contentOffsetDictionary;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tableView嵌套collectionview的最佳实现方案";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"NXTableViewCell";
    
    NXTableViewCell *cell = (NXTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(NXTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell setupCollectionViewDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;
    //  根据已有的记录，设置正确的偏移
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];

}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *collectionViewArray = self.dataArray[[(NXCollectionView *)collectionView indexPath].row ];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NXCollectionCellIdentifier forIndexPath:indexPath];
    
    NSArray *collectionViewArray = self.dataArray[[(NXCollectionView *)collectionView indexPath].row];
    cell.backgroundColor =  collectionViewArray[indexPath.row];
    
    return cell;
}


#pragma mark - UIScrollViewDelegate Methods

/*
 偏移量有变动时，记录偏移量的变动
 */
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 if (![scrollView isKindOfClass:[UICollectionView class]]) return;
 
 CGFloat horizontalOffset = scrollView.contentOffset.x;
 
 NXCollectionView *collectionView = (NXCollectionView *)scrollView;
 NSInteger index = collectionView.indexPath.row;
 self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
     
 }
 




@end
