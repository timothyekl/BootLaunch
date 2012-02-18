//
//  BLFlipsideViewController.h
//  BootLaunch
//
//  Created by Tim Ekl on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLFlipsideViewController;

@protocol BLFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidUpdateLaunchData:(BLFlipsideViewController *)controller;
- (void)flipsideViewControllerDidFinish:(BLFlipsideViewController *)controller;
@end

@interface BLFlipsideViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@property (weak, nonatomic) IBOutlet id <BLFlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel * launchCountLabel;

- (IBAction)resetLaunches:(id)sender;
- (IBAction)fakeLaunch:(id)sender;
- (IBAction)done:(id)sender;

- (void)updateLaunchCountLabel;

@end
