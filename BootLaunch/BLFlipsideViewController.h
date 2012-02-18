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
- (void)flipsideViewControllerDidFinish:(BLFlipsideViewController *)controller;
@end

@interface BLFlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <BLFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
