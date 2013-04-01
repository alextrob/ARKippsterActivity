//
//  ViewController.m
//  KippsterActivityDemo
//
//  Created by Alex Robinson on 1/04/13.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "ViewController.h"
#import "ARKippsterActivity.h"

@interface ViewController ()

@property (strong, nonatomic) UIPopoverController *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActivitySheet:(id)sender {
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://kippster.net"];
    NSArray *activityItems = @[urlToShare];
    
    ARKippsterActivity *kippsterActivity = [[ARKippsterActivity alloc] initWithCallbackURL:[NSURL URLWithString:@"kippsteractivitydemo://"]];
    
    [kippsterActivity setCallbackSource:@"Demo"]; // Text that displays on the Cancel button in Kippster
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[kippsterActivity]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (!self.popover) {
            self.popover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        }
        if (!self.popover.isPopoverVisible) {
            [self.popover presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else {
            [self.popover dismissPopoverAnimated:YES];
        }
    }
    else {
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    
}

@end
