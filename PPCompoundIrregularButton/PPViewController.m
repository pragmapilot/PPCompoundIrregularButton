//
//  PPViewController.m
//  PPCompoundIrregularButton
//
//  Created by Rodrigo on 28/10/13.
//  Copyright (c) 2013 PragmaPilot. All rights reserved.
//

#import "PPViewController.h"

@interface PPViewController ()

/** @abstract holds a reference to the button */
@property (nonatomic, strong) UIButton *oddButton;

@end

@implementation PPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Build button and keep a reference to it (just in case...)
    self.oddButton = [self buildComplexButton];
    
    // Add button to view
    [self.view addSubview:self.oddButton];
}

- (UIButton*)buildComplexButton
{
    // Some constants
    static CGFloat fakeButtonHeight  = 100;
    static CGFloat fakeButtonPeakHeight = 150;
    
    // Create button with desired frame
    UIButton *oddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oddButton.frame = CGRectMake(0.0, 50.0, self.view.bounds.size.width, fakeButtonPeakHeight);
    
    // Create button shape
    UIBezierPath *buttonShape = [UIBezierPath bezierPath];
    [buttonShape moveToPoint: CGPointMake(0.0, 0.0)];
    [buttonShape addLineToPoint:CGPointMake(self.view.bounds.size.width, 0.0)];
    [buttonShape addLineToPoint:CGPointMake(self.view.bounds.size.width, fakeButtonHeight)];
    [buttonShape addLineToPoint:CGPointMake((self.view.bounds.size.width / 2), fakeButtonPeakHeight)];
    [buttonShape addLineToPoint:CGPointMake(0.0, fakeButtonHeight)];
    [buttonShape closePath];
    
    // Declare some vars to hold images and fetch the images that will be contained inside the button
    UIImage *normalStateImage;
    UIImage *highlightedStateImage;
    
    UIImage *normalSkullImage = [UIImage imageNamed:@"skull.png"];
    CGSize normalSkullSize = normalSkullImage.size;
    
    UIImage *highlightedSkullImage = [UIImage imageNamed:@"skull_oops.png"];
    CGSize highlightedSkullSize = normalSkullImage.size;
    
    // Get a graphics context
    UIGraphicsBeginImageContextWithOptions(buttonShape.bounds.size,NO,[UIScreen mainScreen].scale);
    
    /* ### Normal state image ### */
    
    // Set color
    [[UIColor whiteColor] setFill];
    // Fill shape with white color
    [buttonShape fill];
    // Draw the normal skull image inside the context
    [normalSkullImage drawInRect:CGRectMake(CGRectGetMidX(oddButton.frame) - normalSkullSize.width/2, CGRectGetMidY(oddButton.frame) - normalSkullSize.height, normalSkullSize.width, normalSkullSize.height)];
    // Generate an UIImage from the context
    normalStateImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /* ### Highlighted state image ### */
    
    // Set color
    [[UIColor lightGrayColor] setFill];

    // Fill shape with gray color
    [buttonShape fill];
    
    // Draw the "alive" skull image inside the context
    [highlightedSkullImage drawInRect:CGRectMake(CGRectGetMidX(oddButton.frame) - highlightedSkullSize.width/2, CGRectGetMidY(oddButton.frame) - highlightedSkullSize.height, highlightedSkullSize.width, highlightedSkullSize.height)];
    // Generate an UIImage from the context
    highlightedStateImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End context
    UIGraphicsEndImageContext();

    // Set previously composed images as button background images for the appropriate states
    [oddButton setBackgroundImage:normalStateImage forState:UIControlStateNormal];
    [oddButton setBackgroundImage:highlightedStateImage forState:UIControlStateHighlighted];

    // Do some text related settings on the button
    
    [oddButton setTitleEdgeInsets:UIEdgeInsetsMake(20.0, 0.0, 100.0, 0.0)];
    
    [oddButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:20.0]];
    
    [oddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [oddButton setTitle:@"Click me..." forState:UIControlStateNormal];
    
    [oddButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [oddButton setTitle:@"I'M ALIVE!" forState:UIControlStateHighlighted];
    
    // Return the customized odd-shaped button
    return oddButton;
}

@end
