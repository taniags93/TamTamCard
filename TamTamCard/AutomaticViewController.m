//
//  AutomaticViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 24/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "AutomaticViewController.h"
#import "AppDelegate.h"
#import "ICViewController.h"
@interface AutomaticViewController (){
    AppDelegate *delegate;
}

@end

@implementation AutomaticViewController
@synthesize description;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _viewTitle.text = [NSString stringWithFormat:@"A little about %@...!", delegate.cardCountry];
    description.text = [delegate.countryDescriptions objectForKey:delegate.cardCountry];
    _image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"automatic-1-%@.jpg",delegate.cardCountry]];
    _image2.image = [UIImage imageNamed:[NSString stringWithFormat:@"automatic-2-%@.jpg",delegate.cardCountry]];

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

- (IBAction)nextButton:(id)sender {
    //Get the size of the screen
    CGRect screenRect = [_containerAutomatic bounds];
    
    //Create a bitmap-based graphics context and make
    //it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    //render the receiver and its sublayers into the specified context
    //choose a view or use the window to get a screenshot of the
    //entire device
    [_containerAutomatic.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    //Save UIImage to camera roll
    [ICViewController saveImage:newImage andImageName:@"automatic.png"];
}
@end
