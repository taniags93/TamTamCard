//
//  AddressViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *addressTV;
- (IBAction)continueButton:(id)sender;

@end
