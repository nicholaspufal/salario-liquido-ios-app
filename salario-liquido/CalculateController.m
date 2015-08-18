//
//  CalculateController.m
//  salario-liquido
//
//  Created by Nicholas Pufal on 8/16/15.
//  Copyright (c) 2015 Nicholas Pufal. All rights reserved.
//

#import "ViewController.h"
#import "CalculateController.h"

@interface CalculateController ()

@end

@implementation CalculateController
@synthesize grossSalaryValue;
@synthesize dependentsValue;

// Use a single instance of iAd
- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAdvertisements];
    
    self.dependentsLabel.text = [NSString stringWithFormat:@"Dependentes: %@", self.dependentsValue];
    self.grossSalaryLabel.text = [NSString stringWithFormat:@"Salário Bruto: %@", self.grossSalaryValue];
    [self calculateNetSalary];
}

// Retrieves 'adView' from AppDelegate,
// assigns it to a local property and injects it
// as a subview at the bottom of the screen
- (void)loadAdvertisements {
    self.adView = [[self appDelegate] adView];
    self.adView.frame = CGRectMake(self.view.frame.size.width - self.adView.frame.size.width,
                                   self.view.frame.size.height - self.adView.frame.size.height,
                                   self.adView.frame.size.width,
                                   self.adView.frame.size.height);
    self.adView.delegate = self;

    [self.view addSubview:self.adView];
}

//Remove adView in case of a failure
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self.adView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)calculateNetSalary {
    NSString * endpointString = [NSString
                                 stringWithFormat:@"http://104.131.75.80:3000/calculate_net_salary?grossSalary=%@&dependents=%@",
                                 self.grossSalaryValue,
                                 self.dependentsValue];
    NSURL * endpoint = [NSURL URLWithString:endpointString];
    NSURLRequest * request = [NSURLRequest requestWithURL:endpoint];
    
    NSURLConnection * connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!connection) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                         message:@"O aplicativo não conseguiu iniciar uma conexão. Tente novamente."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"Not able to initiate the connection!");
        self.responsePayload = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError * error;
    self.responsePayload = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Falha ao se conectar"
                                                     message:@"O aplicativo depende de conexão com a internet. Verique e tente novamente."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
    
    alert = nil;
    connection = nil;
    self.responsePayload = nil;
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Response payload: %@", self.responsePayload);
    self.INSSLabel.text = [NSString stringWithFormat:@"INSS: %@", [self.responsePayload objectForKey:@"INSS"]];
    self.IRRFLabel.text = [NSString stringWithFormat:@"IRRF: %@", [self.responsePayload objectForKey:@"IRRF"]];
    self.netSalaryLabel.text = [self.responsePayload objectForKey:@"netSalary"];

    connection = nil;
    self.responsePayload = nil;
}

@end
