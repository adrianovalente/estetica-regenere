//
//  HomeHeaderView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BasicButtonView.h"

@interface HomeHeaderView ()<BasicButtonProtocol>

@property (weak, nonatomic) IBOutlet BasicButtonView *marcarConsultaBasicButton;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentsLabel;

@end


@implementation HomeHeaderView
#pragma mark - public api
-(void)updateWithName:(NSString *)name appointments:(NSNumber *)appointments
{
    [self.helloLabel setText:[NSString stringWithFormat:@"Olá, %@", name]];
    [self.appointmentsLabel setText:[NSString stringWithFormat:@"Essa semana você tem %@ consultas marcadas", appointments]];
}


#pragma mark - setup methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void) setup
{
    [self.marcarConsultaBasicButton setTitle:@"Marcar consulta"];
    [self.marcarConsultaBasicButton setDelegate:self];
}


#pragma mark - Basic Button Delegate
- (void)buttonTapped:(id)button
{
    [self.delegate didSelectMarcarConsulta];
}

@end
