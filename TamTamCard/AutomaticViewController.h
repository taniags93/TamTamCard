//
//  AutomaticViewController.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutomaticViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *viewTitle;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIScrollView *containerAutomatic;
- (IBAction)nextButton:(id)sender;

@end
