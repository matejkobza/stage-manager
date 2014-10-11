//
//  MasterViewController.m
//  StageManager
//
//  Created by Tomas Cejka on 4/11/13.
//  Modified by Matej Kobza.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MovableViewController.h"
#import "CustomCell.h"
#import "ImageHelper.h"

@interface MasterViewController ()
{
    ImageHelper *imageHelper;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef DEBUG
    NSLog(@"Application launched in DEBUG mode");
    NSLog(@"MasterViewController#viewDidLoad");
#endif
	// Do any additional setup after loading the view, typically from a nib.
    if(!imageHelper) {
        imageHelper = [[ImageHelper alloc] init];
    }
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController.master = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Menu Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = imageHelper.getMenuItems.count;
#ifdef DEBUG
    NSLog(@"MasterViewController#numberOfRowsInSection: %d", count);
#endif
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"MasterViewController#cellForRowAtIndexPath: %d", indexPath.row);
#endif
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    if(cell==nil)
    {
        cell = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomCell"];
    }

    Image *image = [imageHelper imageAtIndex: indexPath.row];
    NSString *label = image.title;
    UIImage *menuImage = image.menuIcon;
    if(label != nil) {
        cell.cellText.text = label;
    }
    if(menuImage != nil) {
        cell.cellImage.image = menuImage;
    }
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood-texture.png"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;// Return NO if you do not want the specified item to be editable.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"MasterViewController#didSelectRowAtIndexPath");
#endif
    Image *image = [imageHelper imageAtIndex:indexPath.row];
    [self.detailViewController addInstrument : image];
}


@end
