//
//  BLFlipsideViewController.m
//  BootLaunch
//
//  Created by Tim Ekl on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BLFlipsideViewController.h"

#import "BLAppDelegate.h"

@implementation BLFlipsideViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize delegate = _delegate;
@synthesize launchCountLabel = _launchCountLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    return self;
}
							
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
    [self updateLaunchCountLabel];
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

#pragma mark - Actions

- (IBAction)resetLaunches:(id)sender {
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"AppLaunch"];
    
    NSError * error;
    NSArray * results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if(results == nil) {
        NSLog(@"failure fetching app launches to clear: %@", [error localizedDescription]);
        return;
    }
    
    for(id object in results) {
        [[self managedObjectContext] deleteObject:object];
    }
    
    if(![[self managedObjectContext] save:&error]) {
        NSLog(@"failure saving context after clearing objects: %@", [error localizedDescription]);
        return;
    }
    
    [self updateLaunchCountLabel];
    [self.delegate flipsideViewControllerDidUpdateLaunchData:self];
}

- (IBAction)fakeLaunch:(id)sender {
    // Kind of a hack. Better way?
    [(BLAppDelegate *)[[UIApplication sharedApplication] delegate] updateAppLaunchTime];
    [self updateLaunchCountLabel];
    [self.delegate flipsideViewControllerDidUpdateLaunchData:self];
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

#pragma mark - Custom methods

- (void)updateLaunchCountLabel {
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"AppLaunch"];
    
    NSError * error;
    NSArray * results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if(results == nil) {
        NSLog(@"failure fetching app launches to update label: %@", [error localizedDescription]);
        return;
    }
    
    self.launchCountLabel.text = [NSString stringWithFormat:@"App has launched %d times", [results count]];
}

@end
