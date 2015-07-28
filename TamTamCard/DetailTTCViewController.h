//
//  DetailTTCViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 07/06/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICViewController.h"
#import "AppDelegate.h"

@interface DetailTTCViewController : UIViewController

- (IBAction)imageButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageOne;
@property (strong, nonatomic) IBOutlet UIImageView *imageTwo;
@property (strong, nonatomic) IBOutlet UIImageView *imageThree;
@property (strong, nonatomic) IBOutlet UIImageView *imageFour;
@property (strong, nonatomic) IBOutlet UIImageView *imageFive;
- (IBAction)nextButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *containerPersonal;

@end
