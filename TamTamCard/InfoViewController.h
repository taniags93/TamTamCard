//
//  InfoViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 21/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ICViewController.h"
#import "AppDelegate.h"


@interface InfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *CountryLabel;
@property (strong, nonatomic) IBOutlet UITextField *titleTF;
- (IBAction)nextButton:(id)sender;

@end
