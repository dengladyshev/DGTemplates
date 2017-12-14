//
//  DGSliderViewController.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGSliderViewController.h"
#import "DGPagedSliderFlowLayout.h"

static NSString *const kHeaderSliderCellId = @"HeaderSliderCell";
static NSString *const kPagedSliderCellId = @"PagedSliderCell";
static CGFloat const kPagedSliderMinMargin = 16;
static CGFloat const kPagedSliderMaxMargin = 50;
static CGFloat const kPagedSliderLineSpacing = 8;

@interface DGSliderViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *headerSliderCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *pagedSliderCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerSliderHeightConstraint;

@property (assign, nonatomic) CGSize slideSize;
@property (copy, nonatomic) NSArray<UIColor *> *headerSlides;
@property (copy, nonatomic) NSArray<UIColor *> *pagedSlides;

@end

@implementation DGSliderViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.slideSize = CGSizeMake(screenWidth, self.headerSliderHeightConstraint.constant);
    [self configureHeaderSlider];
    [self configurePagedSlider];
}

- (void)configureHeaderSlider {
    self.headerSlides = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor], [UIColor blueColor]];
    self.headerSliderCollectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.headerSliderCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kHeaderSliderCellId];
    [self.headerSliderCollectionView setContentOffset:CGPointMake(self.slideSize.width, 0)];
}

- (void)configurePagedSlider {
    self.pagedSlides = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor grayColor], [UIColor lightGrayColor]];
    self.pagedSliderCollectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.pagedSliderCollectionView.collectionViewLayout = [[DGPagedSliderFlowLayout alloc] initWithInset:kPagedSliderMinMargin];
    [self.pagedSliderCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kPagedSliderCellId];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.headerSliderCollectionView) {
        [self moveScrollViewToOppositeEdgeIfNeeded:scrollView];
    }
}

- (void)moveScrollViewToOppositeEdgeIfNeeded:(UIScrollView *)scrollView {
    CGFloat fullScrolledContentOffset = self.slideSize.width * (self.headerSlides.count + 1);
    if (scrollView.contentOffset.x >= fullScrolledContentOffset) {
        [self.headerSliderCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else if (scrollView.contentOffset.x <= 0) {
        [self.headerSliderCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.headerSlides.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.headerSliderCollectionView) {
        return self.headerSlides.count + 2;
    }
    if (collectionView == self.pagedSliderCollectionView) {
        return self.pagedSlides.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.headerSliderCollectionView) {
        NSInteger itemIndex = [self slideIndexFromIndexPath:indexPath];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHeaderSliderCellId forIndexPath:indexPath];
        cell.contentView.backgroundColor = self.headerSlides[itemIndex];
        return cell;
    }
    if (collectionView == self.pagedSliderCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPagedSliderCellId forIndexPath:indexPath];
        cell.contentView.backgroundColor = self.pagedSlides[indexPath.item];
        cell.contentView.layer.cornerRadius = 8;
        return cell;
    }
    return nil;
}

- (NSInteger)slideIndexFromIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return self.headerSlides.count - 1;
    } else if (indexPath.item == self.headerSlides.count + 1) {
        return 0;
    } else {
        return indexPath.item - 1;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.headerSliderCollectionView) {
        return self.slideSize;
    }
    if (collectionView == self.pagedSliderCollectionView) {
        return CGSizeMake(self.slideSize.width - kPagedSliderMinMargin - kPagedSliderLineSpacing - kPagedSliderMaxMargin, self.slideSize.height);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.pagedSliderCollectionView) {
        return UIEdgeInsetsMake(0, kPagedSliderMinMargin, 0, kPagedSliderMinMargin);
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.pagedSliderCollectionView) {
        return kPagedSliderLineSpacing;
    }
    return 0;
}

@end
