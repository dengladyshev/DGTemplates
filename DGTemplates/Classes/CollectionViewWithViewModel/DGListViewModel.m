//
//  DGListViewModel.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGListViewModel.h"
#import "DGTemplateCellViewModel.h"

@interface DGListViewModel ()

@property (copy, nonatomic, readwrite) NSArray<id<DGCellModel>> *items;

@end

@implementation DGListViewModel

- (NSArray<id<DGCellModel>> *)items {
    if (!_items) {
        _items = @[[DGTemplateCellViewModel new], [DGTemplateCellViewModel new], [DGTemplateCellViewModel new]];
    }
    return  _items;
}

@end
