//
//  MessageViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "MessageViewController.h"
#import "ICViewController.h"
#import "AppDelegate.h"
@interface MessageViewController ()

@end

@implementation MessageViewController{
    AppDelegate *delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _myMessage.delegate = self;
    _myMessage.text = @"Write your personal message here...";
    _myMessage.textColor = [UIColor lightGrayColor]; //optional
    _addressTV.text = delegate.address;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Write your personal message here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write your personal message here...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (IBAction)nextButton:(id)sender {
    if ([_myMessage.text isEqualToString:@"Write your personal message here..."]) {
        _myMessage.text = @"";
    }
    delegate.message = _myMessage.text;
    [_myMessage resignFirstResponder];

    //Get the size of the screen
    CGRect screenRect = [_containerMessage bounds];
    
    //Create a bitmap-based graphics context and make
    //it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    //render the receiver and its sublayers into the specified context
    //choose a view or use the window to get a screenshot of the
    //entire device
    [_containerMessage.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    //Save UIImage to camera roll
    [ICViewController saveImage:newImage andImageName:@"message.png"];
}
@end
