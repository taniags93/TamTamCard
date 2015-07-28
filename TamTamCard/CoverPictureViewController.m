//
//  CoverPictureViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 21/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "CoverPictureViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CoverPictureViewController ()

@end

@implementation CoverPictureViewController{
    AppDelegate *delegate;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _coverPicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",delegate.cardCountry]];
    [ICViewController saveImage:_coverPicture.image andImageName:@"image0"];
    _countryLabel.text = delegate.cardCountry;
    _titleLabel.text = delegate.cardTitle;
}

- (void) viewDidAppear:(BOOL)animated
{
    _coverPicture.image = [ICViewController loadImage:@"image0"];

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

- (IBAction)coverButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    delegate.buttonName = [NSString stringWithFormat:@"%ld", (long)button.tag];
}

- (IBAction)nextButton:(id)sender {
    //Get the size of the screen
    CGRect screenRect = [_containerCover bounds];
    
    //Create a bitmap-based graphics context and make
    //it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    //render the receiver and its sublayers into the specified context
    //choose a view or use the window to get a screenshot of the
    //entire device
    [_containerCover.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    //Save UIImage to camera roll
    [ICViewController saveImage:newImage andImageName:@"cover.png"];
}

@end
