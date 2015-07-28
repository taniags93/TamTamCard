//
//  ViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 07/06/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController (){
    AppDelegate *delegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _TTCLabel.layer.cornerRadius = _TTCLabel.frame.size.width + 15;
    _TTCLabel.clipsToBounds = YES;
    _TTCLabel.layer.borderWidth = 3.0f;
    _TTCLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.countryDescriptions = @{
                                     @"Paris" : @"Paris is the city of love, inspiration, art and fashion. The night scene, the Eiffel tower and the warm atmosphere will make you feel directly at home. Paris has a lot of interesting architecture and museums to offer, and is also a Walhalla for shopaholics. A city as Paris is one that everyone should visit and experience.",
                                     @"Mexico" : @"One of the world’s great civilizations. Mexico’s landscapes are just as diverse, from the shimmering blue coastline of Baja California and the iconic cactus-strewn deserts of the north, to the Mayan villages and gorgeous palm-smothered beaches of the south. You can climb volcanoes, watch whales, swim underground and tour tequila farms. And sprinkled throughout you’ll find richly adorned colonial churches, giant ancient pyramids and a sophisticated cuisine that has little in common with the world of nachos and burritos.",
                                     @"India" : @"The moment I start to think I'm right on the precipice of unravelling one of India's deep mysteries, she has an uncanny way of reminding me that it would take more than just a few lifetimes to do so. Indeed, demystifying India is a perpetual work in progress. And that is precisely what makes the country so deeply addictive for me. The constant exploration. The playful unpredictability. And knowing that, just when it's least expected, you can find yourself up close and personal with moments that have the power to alter the way you view the world and your place in it.",
                                     };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
