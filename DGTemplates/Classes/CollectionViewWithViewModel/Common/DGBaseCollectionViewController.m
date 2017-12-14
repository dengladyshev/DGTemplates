//
//  DGBaseCollectionViewController.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGBaseCollectionViewController.h"
#import "DGConfigurableCell.h"

@interface DGBaseCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (copy, nonatomic) NSDictionary<NSString *, UICollectionViewCell<DGConfigurableCell> *> *cells;

@end

@implementation DGBaseCollectionViewController

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<DGCellModel> cellModel = self.viewModel.items[indexPath.item];
    UICollectionViewCell<DGConfigurableCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellModel.cellIdentifier forIndexPath:indexPath];
    [cell setData:cellModel];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.viewModel.items.count) return CGSizeZero;
    
    id<DGCellModel> cellModel = self.viewModel.items[indexPath.row];
    UICollectionViewCell<DGConfigurableCell> *cell = nil;
    if (!self.cells[cellModel.cellIdentifier]) {
        NSMutableDictionary *mutableCells = self.cells ? [self.cells mutableCopy] : [NSMutableDictionary new];
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([cellModel cellClass]) owner:self options:0].firstObject;
        mutableCells[cellModel.cellIdentifier] = cell;
        self.cells = [mutableCells copy];
    } else {
        cell = self.cells[cellModel.cellIdentifier];
    }
    [cell setData:cellModel];
    return [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
