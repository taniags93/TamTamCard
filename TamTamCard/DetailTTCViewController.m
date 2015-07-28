//
//  DetailTTCViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 07/06/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "DetailTTCViewController.h"

@interface DetailTTCViewController ()

@end

@implementation DetailTTCViewController{
    AppDelegate *delegate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ICViewController saveImage:_imageOne.image andImageName:@"image1"];
    [ICViewController saveImage:_imageTwo.image andImageName:@"image2"];
    [ICViewController saveImage:_imageThree.image andImageName:@"image3"];
    [ICViewController saveImage:_imageFour.image andImageName:@"image4"];
    [ICViewController saveImage:_imageFive.image andImageName:@"image5"];

     delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    
}

- (void)viewDidAppear:(BOOL)animated{
    _imageOne.image = [ICViewController loadImage:@"image1"];
    _imageTwo.image = [ICViewController loadImage:@"image2"];
    _imageThree.image = [ICViewController loadImage:@"image3"];
    _imageFour.image = [ICViewController loadImage:@"image4"];
    _imageFive.image = [ICViewController loadImage:@"image5"];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    /*UIImage *temp = [ICViewController viewAsImage:self.view];
    UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil);*/
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)imageButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    delegate.buttonName = [NSString stringWithFormat:@"%ld", (long)button.tag];
}
- (IBAction)nextButton:(id)sender {
    //Get the size of the screen
    CGRect screenRect = [_containerPersonal bounds];
    
    //Create a bitmap-based graphics context and make
    //it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    //render the receiver and its sublayers into the specified context
    //choose a view or use the window to get a screenshot of the
    //entire device
    [_containerPersonal.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();
    
    //Save UIImage to camera roll
    [ICViewController saveImage:newImage andImageName:@"personal.png"];
}
@end
