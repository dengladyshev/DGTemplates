//
//  DGCellModel.h
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import <Foundation/Foundation.h>

@protocol DGCellModel <NSObject>

@required

- (Class)cellClass;
- (NSString *)cellIdentifier;

@end
