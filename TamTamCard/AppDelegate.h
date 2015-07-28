//
//  AppDelegate.h
//  TamTamCard
//
//  Created by Tania Garrido Salido on 07/06/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) NSString *buttonName;
@property (strong,nonatomic) NSString *cardTitle;
@property (strong,nonatomic) NSString *cardCountry;
@property (strong,nonatomic) NSString *message;
@property (strong,nonatomic) NSDictionary *countryDescriptions;
@property (strong,nonatomic) NSString *address;


@end

