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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dependentsLabel.text = @"0";
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
