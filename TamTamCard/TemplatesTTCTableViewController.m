//
//  TemplatesTTCTableViewController.m
//  TamTamCard
//
//  Created by Tania Garrido Salido on 07/06/2015.
//  Copyright (c) 2015 Tania Garrido Salido. All rights reserved.
//

#import "TemplatesTTCTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TemplateTTCTableViewCell.h"
#import "AppDelegate.h"


@interface TemplatesTTCTableViewController ()



@end

@implementation TemplatesTTCTableViewController{
    NSArray *countries;
    
    NSArray *images;
    AppDelegate *delegate;

}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    countries = @[@"Paris", @"Mexico", @"India"];
    images = @[@"paris.jpg", @"mexico-vacations.jpg", @"india.jpeg"];

    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [countries count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TemplateTTCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TemplateCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.thelabel.text = countries[indexPath.row];
    cell.descriptiveImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"small-%@.jpg",countries[indexPath.row]]];
    cell.descriptiveImage.layer.cornerRadius = cell.descriptiveImage.frame.size.width / 4;
    cell.descriptiveImage.clipsToBounds = YES;
    cell.descriptiveImage.layer.borderWidth = 3.0f;
    cell.descriptiveImage.layer.borderColor = [UIColor whiteColor].CGColor;
    

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    delegate.cardCountry = countries[indexPath.row];
}


@end
