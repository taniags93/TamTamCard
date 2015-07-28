//
//  ShareViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 22/07/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
#import "ZipArchive/ZipArchive.h"
#import "AppDelegate.h"

#define kPayPalEnvironment PayPalEnvironmentSandbox


@interface ShareViewController (){
    AppDelegate *delegate;
    NSString *message;
}
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payNowButton;
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payFutureButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.title = @"";
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    message = [NSString stringWithFormat:@"%@ \n This is my personal Post Card made with TamTamCard! Discover more on: http://frtamtamcard.com/ ", delegate.message];
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = @"en";
    _payPalConfig.merchantName = @"TamTamCard";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    //NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dPath = [paths objectAtIndex:0];
    
    NSString* imageName1 = [dPath stringByAppendingPathComponent:@"cover"];
    NSString* imageName2 = [dPath stringByAppendingPathComponent:@"personal"];


    UIImage *combinedImage = [self imageByCombiningImage:[UIImage imageNamed:imageName1] withImage:[UIImage imageNamed:imageName2]];
    //Save UIImage to camera roll
    [ICViewController saveImage:combinedImage andImageName:@"combined.jpg"];
    
    
    _imageShare.image = combinedImage;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // Preconnect to PayPal early
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
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

- (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    
    CGSize size = CGSizeMake(firstImage.size.width, firstImage.size.height + secondImage.size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [firstImage drawInRect:CGRectMake(0,0,size.width, firstImage.size.height)];
    [secondImage drawInRect:CGRectMake(0,firstImage.size.height,size.width, secondImage.size.height)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

- (IBAction)facebookShare:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //set the initial text message
        [fbComposer setInitialText:message];
        [fbComposer addImage: _imageShare.image];
        
        //present the composer to the user
        [self presentViewController:fbComposer animated:YES completion:nil];
        
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Facebook Error"
                                  message:@"You may not have set up facebook service on your device or\n                                  You may not connected to internent.\nPlease check ..."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil];
        [alertView show];
        
    }
}

- (IBAction)twitterShare:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetController = [SLComposeViewController
                                                    composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //set the initial text message
        [tweetController setInitialText:message];
        [tweetController addImage:_imageShare.image];
        
        //present the controller to the user
        [self presentViewController:tweetController animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"twitter Error"
                                  message:@"You may not have set up twitter service on your device or\n                                  You may not connected to internent.\nPlease check ..."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil];
        [alertView show];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Receive Single Payment

#pragma mark PayPalPaymentDelegate methods
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    [self zip:[[completedPayment.confirmation objectForKey:@"response"] objectForKey:@"id"]];
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    [self updateInformationInServer:completedPayment];
}

#pragma mark - Server Update
- (void)updateInformationInServer:(PayPalPayment *) completedPayment{
    
}

#pragma mark - Authorize Future Payments
- (IBAction)getUserAuthorization:(id)sender {
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods
- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = futurePaymentAuthorization[@"code"];
    [self showSuccess];
    
    [self sendAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Helpers
- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushSettings"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
        }
    }
}

- (IBAction)togglePopover:(id)sender {
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction)pay:(id)sender {
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
    PayPalItem *item1 = [PayPalItem itemWithName:@"TamTam Card"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"6.50"]
                                    withCurrency:@"USD"
                                         withSku:@"TTC"];
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0.00"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.00"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"TamTamCard";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    //self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (void)uploadImage:(NSString *)path :(NSString*)zipName {
    // COnvert Image to NSData
   // NSData *dataImage = UIImageJPEGRepresentation([ICViewController loadImage:@"image1"], 1.0f);
 
    NSData *dataImage = [NSData dataWithContentsOfFile:path];

    // set your URL Where to Upload Image
    NSString *urlString = @"http://frtamtamcard.com/index.php/en";
    
    // set your Image Name
    NSString *filename = zipName;
    
    // Create 'POST' MutableRequest with Data and Other Image Attachment.
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile120[]\"; filename=\"%@.zip\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:dataImage]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    // Get Response of Your Request
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"Response  %@",responseString);
}


- (void)zip:(NSString *)zipName {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dPath = [paths objectAtIndex:0];
    
    NSString* img1 = [dPath stringByAppendingPathComponent:@"cover.png"];
    NSString* img2 = [dPath stringByAppendingPathComponent:@"automatic.png"];
    NSString* img3 = [dPath stringByAppendingPathComponent:@"personal.png"];
    NSString* img4 = [dPath stringByAppendingPathComponent:@"message.png"];
    
    NSString* zipfile = [dPath stringByAppendingPathComponent:zipName];
    ZipArchive* zip = [[ZipArchive alloc] init];
    BOOL ret = [zip CreateZipFile2:zipfile];
    ret = [zip addFileToZip:img1 newname:@"cover.png"];//zip
    ret = [zip addFileToZip:img2 newname:@"automatic.png"];//zip
    ret = [zip addFileToZip:img3 newname:@"personal.png"];//zip
    ret = [zip addFileToZip:img4 newname:@"message.png"];//zip


    if( ![zip CloseZipFile2] )
    {
        zipfile = @"";
    }

    NSLog(@"The file has been zipped");
    
    [self uploadImage:zipfile :zipName];
}
@end
