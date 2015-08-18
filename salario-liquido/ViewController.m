//
//  ViewController.m
//  salario-liquido
//
//  Created by Nicholas Pufal on 8/15/15.
//  Copyright (c) 2015 Nicholas Pufal. All rights reserved.
//

#import "ViewController.h"
#import "CalculateController.h"

@interface ViewController ()

@end

@implementation ViewController

// Use a single instance of iAd
- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAdvertisements];

    self.dependentsLabel.text = @"0";
}

// Retrieve 'adView' from AppDelegate and injects it
// as a subview at the bottom of the screen
- (void)loadAdvertisements {
    self.adView = [[self appDelegate] adView];
    self.adView.frame = CGRectMake(self.view.frame.size.width - self.adView.frame.size.width,
                                   self.view.frame.size.height - self.adView.frame.size.height,
                                   self.adView.frame.size.width,
                                   self.adView.frame.size.height);
    [self.view addSubview:self.adView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)changedNumberOfDependents:(id)sender {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    self.dependentsLabel.text = [numberFormatter stringFromNumber: @(self.dependentsControl.value)];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"GoToCalculation"]) {
        CalculateController * calculateController = [segue destinationViewController];
        calculateController.grossSalaryValue = [self grossSalaryText:self.grossSalaryField];
        calculateController.dependentsValue = self.dependentsLabel.text;
    }
}

- (NSString *)grossSalaryText:(UITextField *) grossSalaryField {
    if ([grossSalaryField.text isEqualToString:@""]) return @"0.00";
    return grossSalaryField.text;
}
@end
