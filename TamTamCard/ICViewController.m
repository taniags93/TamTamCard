//
//  ViewController.m
//  ImageCropView
//
//  Created by Ming Yang on 12/27/12.
//
//

#import "ICViewController.h"

@interface ICViewController ()

@end

@implementation ICViewController{
    AppDelegate *delegate;
}

@synthesize imageCropView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imageCropView.image = [UIImage imageNamed:@"pict.jpeg"];
    imageCropView.controlColor = [UIColor cyanColor];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takeBarButtonClick:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your device doesn't have a camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

- (IBAction)openBarButtonClick:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    imageView.image = image;
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cropBarButtonClick:(id)sender {
    if (image != nil) {
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:image];
        
        controller.delegate = self;
        controller.blurredBackground = YES;
        [[self navigationController] pushViewController:controller animated:YES];
    }
}

- (void)ImageCropViewController:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
   image = croppedImage;
   imageView.image = croppedImage;
   [[self navigationController] popViewControllerAnimated:YES];
}


- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    imageView.image = image;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!"
                                                        message:[NSString stringWithFormat:@"Saved with error %@", error.description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succes!"
                                                                message:@"Saved to camera roll"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

    }
}

- (IBAction)saveBarButtonClick:(id)sender {
    [ICViewController saveImage:image andImageName:[NSString stringWithFormat:@"image%@", delegate.buttonName]];
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
}

+ (void)saveImage:(UIImage*)img andImageName:(NSString *)imageName
{
    if (img != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:imageName];
        NSData* data = UIImagePNGRepresentation(img);
        [data writeToFile:path atomically:YES];
    }
}

+ (UIImage*)loadImage:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      imageName ];
    UIImage* newImage = [UIImage imageWithContentsOfFile:path];
    return newImage;
}

+ (UIImage*)viewAsImage:(UIView*)view {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
