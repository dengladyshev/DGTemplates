//
//  DGTableViewController.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 11.10.16.
//
//

#import "DGTableViewController.h"
#import "DGContenUnderKeyboardViewController.h"

static NSString *const kDGCellId = @"DGCellId";

@interface DGTableViewController ()

@property (copy, nonatomic) NSArray<NSString *> *templates;

@end

@implementation DGTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Templates";
    self.templates = @[@"Moving content under keyboard", @"Template 2", @"Template 3"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    if (row == 0) {
        DGContenUnderKeyboardViewController *contenUnderKeyboardViewController = [[DGContenUnderKeyboardViewController alloc]
                                                                                  initWithNibName:NSStringFromClass([DGContenUnderKeyboardViewController class]) bundle:nil];
        [self.navigationController pushViewController:contenUnderKeyboardViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.templates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDGCellId forIndexPath:indexPath];
    cell.textLabel.text = self.templates[indexPath.row];
    return cell;
}

@end