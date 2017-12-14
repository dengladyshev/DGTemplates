//
//  DGTemplateCollectionViewController.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGTemplateCollectionViewController.h"
#import "DGListViewModel.h"

@interface DGTemplateCollectionViewController ()

@property (strong, nonatomic) NSSet *cellIds;

@end

@implementation DGTemplateCollectionViewController

#pragma mark - Lifecycle

- (NSString *)nibName {
    return [super nibName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [DGListViewModel new];
    [self registerCellsIfNeeded];
}

- (void)registerCellsIfNeeded {
    for (id<DGCellModel> cellModel in self.viewModel.items) {
        if ([self.cellIds containsObject:cellModel.cellIdentifier]) continue;
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellModel cellClass]) bundle:nil] forCellWithReuseIdentifier:cellModel.cellIdentifier];
        NSMutableSet *cellIds = [NSMutableSet new];
        [cellIds addObject:cellModel.cellIdentifier];
        self.cellIds = [cellIds copy];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

@end
