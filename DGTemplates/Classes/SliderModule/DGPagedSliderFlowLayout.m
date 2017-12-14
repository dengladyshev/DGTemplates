//
//  DGPagedSliderFlowLayout.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGPagedSliderFlowLayout.h"

@interface DGPagedSliderFlowLayout ()

@property (assign, nonatomic) CGFloat collectionViewInset;

@end

@implementation DGPagedSliderFlowLayout

- (instancetype)initWithInset:(CGFloat)inset {
    if (self = [super init]) {
        self.collectionViewInset = inset;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset withScrollingVelocity:(CGPoint)velocity {
    CGRect scannerFrame = CGRectMake(offset.x, self.collectionView.bounds.origin.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:scannerFrame];
    CGFloat proposedXCoordWithInsets = offset.x + self.collectionViewInset;
    CGFloat offsetCorrection = CGFLOAT_MAX;
    
    for (UICollectionViewLayoutAttributes *attribute in layoutAttributes) {
        if (attribute.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        CGFloat discardableScrollingElementsFrame = self.collectionView.contentOffset.x + (self.collectionView.frame.size.width / 2);
        if ((attribute.center.x < discardableScrollingElementsFrame && velocity.x > 0) || (attribute.center.x > discardableScrollingElementsFrame && velocity.x < 0)) {
            continue;
        }
        if (fabs(attribute.frame.origin.x - proposedXCoordWithInsets) < fabs(offsetCorrection)) {
            offsetCorrection = attribute.frame.origin.x - proposedXCoordWithInsets;
        }
    }
    return CGPointMake(offset.x + offsetCorrection, self.collectionView.bounds.origin.y);
}

@end
