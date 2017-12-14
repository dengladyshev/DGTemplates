//
//  DGContenUnderKeyboardViewController.m
//  DGTemplates
//
//  Created by Denis Gladyshev on 11.10.16.
//
//

#import "DGContenUnderKeyboardViewController.h"

@interface DGContenUnderKeyboardViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DGContenUnderKeyboardViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Notification Handlers

- (void)keyboardWillShown:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.scrollView.contentInset = self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, CGRectGetHeight(keyboardFrame), 0);
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    self.scrollView.contentInset = self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, 0, 0);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
