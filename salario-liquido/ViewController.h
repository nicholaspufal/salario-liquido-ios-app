//
//  ViewController.h
//  salario-liquido
//
//  Created by Nicholas Pufal on 8/15/15.
//  Copyright (c) 2015 Nicholas Pufal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dependentsLabel;
@property (weak, nonatomic) IBOutlet UITextField *grossSalaryField;
@property (weak, nonatomic) IBOutlet UIStepper *dependentsControl;
@property (strong, nonatomic) ADBannerView * adView;
- (IBAction)changedNumberOfDependents:(id)sender;
@end

