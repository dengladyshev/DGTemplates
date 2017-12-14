//
//  DGTemplateCellViewModel.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGTemplateCellViewModel.h"
#import "DGTemplateCollectionViewCell.h"

@implementation DGTemplateCellViewModel

- (Class)cellClass {
    return [DGTemplateCollectionViewCell class];
}

- (NSString *)cellIdentifier {
    return @"DGTemplateCollectionViewCell";
}

@end
