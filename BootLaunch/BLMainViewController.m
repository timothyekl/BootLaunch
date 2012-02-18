//
//  BLMainViewController.m
//  BootLaunch
//
//  Created by Tim Ekl on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BLMainViewController.h"

@implementation BLMainViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize flipsidePopoverController = _flipsidePopoverController;
@synthesize lastStartedLabel = _lastStartedLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateLastLaunchTimeLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Custom methods

- (void)updateLastLaunchTimeLabel {
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"AppLaunch"];
    request.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO]];
    request.fetchLimit = 1;
    
    NSError * error;
    NSArray * results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if(results == nil) {
        NSLog(@"failed to find app launch instances: %@", [error localizedDescription]);
        return;
    }
    
    if([results count] == 0) {
        NSLog(@"no prior app launches (huh?)");
        self.lastStartedLabel.text = @"--";
        return;
    }
    
    id appLaunch = [results objectAtIndex:0];
    NSDate * lastLaunch = [appLaunch valueForKey:@"timestamp"];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    formatter.locale = [NSLocale currentLocale];
    self.lastStartedLabel.text = [formatter stringFromDate:lastLaunch];
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(BLFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)flipsideViewControllerDidUpdateLaunchData:(BLFlipsideViewController *)controller {
    [self updateLastLaunchTimeLabel];
}

- (IBAction)showInfo:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        BLFlipsideViewController *controller = [[BLFlipsideViewController alloc] initWithNibName:@"BLFlipsideViewController" bundle:nil];
        controller.delegate = self;
        controller.managedObjectContext = self.managedObjectContext;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];
    } else {
        if (!self.flipsidePopoverController) {
            BLFlipsideViewController *controller = [[BLFlipsideViewController alloc] initWithNibName:@"BLFlipsideViewController" bundle:nil];
            controller.delegate = self;
            controller.managedObjectContext = self.managedObjectContext;
            
            self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
        }
        if ([self.flipsidePopoverController isPopoverVisible]) {
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        } else {
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

@end
