//
//  DRTestViewController.m
//  DRFallingWords
//
//  Created by Danny Ricciotti on 1/10/14.
//  Copyright (c) 2014 Danny Ricciotti. All rights reserved.
//

#import "DRTestViewController.h"
#import "DRFallingWordsView.h"

@interface DRTestViewController ()

@end

@implementation DRTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Create falling words view
    DRFallingWordsView *fallingWordsView = [[DRFallingWordsView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(20, 0, 0, 0))];
    [self.view addSubview:fallingWordsView];
    
    
    // Demo: Show different strings on the screen with various delays
    {
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fallingWordsView showWords:@"Hello, World!"];
        });
    }
    {
        double delayInSeconds = 3.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fallingWordsView showWords:@"Animate words on to the screen with ease!"];
        });
    }
    {
        double delayInSeconds = 6.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fallingWordsView showWords:@"Simply add DRFallingWordsView as a subview and call the showWord: method passing it as a string."];
        });
    }
    {
        double delayInSeconds = 13.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fallingWordsView showWords:@"Bye Bye"];
        });
    }
    {
        double delayInSeconds = 15.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fallingWordsView clear];
        });
    }
}

@end
