//
//  DGTemplateCollectionViewCell.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGTemplateCollectionViewCell.h"
#import "DGTemplateCellViewModel.h"

@implementation DGTemplateCollectionViewCell

- (void)setData:(DGTemplateCellViewModel *)cellModel {
    self.contentView.backgroundColor = [UIColor blueColor];
}

@end
