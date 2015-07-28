//
//  ViewController.h
//  ImageCropView
//
//  Created by Ming Yang on 12/27/12.
//
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"
#import "AppDelegate.h"

@interface ICViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate> {
    ImageCropView* imageCropView;
    UIImage* image;
    IBOutlet UIImageView *imageView;
}

- (IBAction)takeBarButtonClick:(id)sender;
- (IBAction)openBarButtonClick:(id)sender;
- (IBAction)cropBarButtonClick:(id)sender;
- (IBAction)saveBarButtonClick:(id)sender;
+ (UIImage*)loadImage:(NSString *)imageName;
+ (void)saveImage:(UIImage*)img andImageName:(NSString*)imageName;
+ (UIImage*)viewAsImage:(UIView*)view;
@property (nonatomic, strong) IBOutlet ImageCropView* imageCropView;

@end
