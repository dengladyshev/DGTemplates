//
//  DGBaseCollectionViewController.h
//  DGTemplates
//
//  Created by Denis Gladyshev on 14.12.17.
//

#import <UIKit/UIKit.h>
#import "DGBaseListViewModelProtocol.h"

@interface DGBaseCollectionViewController : UIViewController <UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic, readonly) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) id<DGBaseListViewModelProtocol> viewModel;

@end
