//
//  DGConfigurableCell.h
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import "DGCellModel.h"

@protocol DGConfigurableCell <NSObject>

@required

- (void)setData:(id<DGCellModel>)cellModel;

@end
