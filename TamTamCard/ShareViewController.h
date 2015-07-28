//
//  ShareViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 22/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "ICViewController.h"


@interface ShareViewController : UIViewController<PayPalPaymentDelegate, PayPalFuturePaymentDelegate>
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic, strong, readwrite) UIPopoverController *flipsidePopoverController;
- (IBAction)facebookShare:(id)sender;
- (IBAction)twitterShare:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageShare;
- (IBAction)pay:(id)sender;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@end
