//
//  CalculateController.m
//  salario-liquido
//
//  Created by Nicholas Pufal on 8/16/15.
//  Copyright (c) 2015 Nicholas Pufal. All rights reserved.
//

#import "CalculateController.h"

@interface CalculateController ()

@end

@implementation CalculateController
@synthesize grossSalaryValue;
@synthesize dependentsValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dependentsLabel.text = self.dependentsValue;
    self.grossSalaryLabel.text = self.grossSalaryValue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
