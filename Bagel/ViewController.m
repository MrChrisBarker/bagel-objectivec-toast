//
//  ViewController.m
//  Bagel
//
//  Created by Chris Barker on 25/07/2020.
//  Copyright © 2020 Cocoa-Cabana Code Ltd. All rights reserved.
//

#import "ExampleViewController.h"
#import "Bagel.h"

@interface ExampleViewController ()

@property (weak, nonatomic) IBOutlet UIView *specificView;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnSpecificView:(id)sender {
    [[Bagel shared] pop:_specificView withMessage:@"Added to a specific View"];
}

- (IBAction)btnWindowView:(id)sender {
    [[Bagel shared] pop:nil withMessage:@"Added to the Window View"];
}

@end
