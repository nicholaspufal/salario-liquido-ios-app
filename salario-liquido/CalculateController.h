//
//  CalculateController.h
//  salario-liquido
//
//  Created by Nicholas Pufal on 8/16/15.
//  Copyright (c) 2015 Nicholas Pufal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *grossSalaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dependentsLabel;
@property NSString * grossSalaryValue;
@property NSString * dependentsValue;
@end
