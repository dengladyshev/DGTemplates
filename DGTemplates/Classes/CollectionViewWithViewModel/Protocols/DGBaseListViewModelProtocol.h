//
//  DGBaseListViewModelProtocol.h
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGCellModel.h"

@protocol DGBaseListViewModelProtocol <NSObject>

@required

@property (copy, nonatomic, readonly) NSArray<id<DGCellModel>> *items;

@end
