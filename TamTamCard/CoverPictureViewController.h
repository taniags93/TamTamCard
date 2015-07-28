//
//  CoverPictureViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 21/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ICViewController.h"
#import "AppDelegate.h"

@interface CoverPictureViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *coverPicture;
- (IBAction)coverButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UIView *containerCover;
- (IBAction)nextButton:(id)sender;
@end