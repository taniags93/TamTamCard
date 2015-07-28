//
//  AddressViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "AddressViewController.h"
#import "AppDelegate.h"
@interface AddressViewController ()

@end

@implementation AddressViewController{
    AppDelegate *delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _addressTV.delegate = self;
    _addressTV.text = @"Write the address here or leave empty if you don't wish to send.";
    _addressTV.textColor = [UIColor lightGrayColor]; //optional
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Write the address here or leave empty if you don't wish to send."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write the address here or leave empty if you don't wish to send.";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)continueButton:(id)sender {
    if ([_addressTV.text isEqualToString:@"Write the address here or leave empty if you don't wish to send."])
        _addressTV.text = @"";
    delegate.address = _addressTV.text;
}
@end
