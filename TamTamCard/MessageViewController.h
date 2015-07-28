//
//  MessageViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *myMessage;
- (IBAction)nextButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *containerMessage;
@property (strong, nonatomic) IBOutlet UILabel *addressTV;

@end
