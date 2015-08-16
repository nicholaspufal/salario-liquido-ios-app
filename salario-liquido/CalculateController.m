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
    
    self.dependentsLabel.text = [NSString stringWithFormat:@"Dependentes: %@", self.dependentsValue];
    self.grossSalaryLabel.text = [NSString stringWithFormat:@"Salário Bruto: %@", self.grossSalaryValue];
    [self calculateNetSalary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)calculateNetSalary {
    NSString * endpointString = [NSString
                                 stringWithFormat:@"http://localhost:3000/calculate_net_salary?grossSalary=%@&dependents=%@",
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
