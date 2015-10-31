//
//  PrivacyPolicyViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import "BaseHeaderView.h"
#import "MenuViewController.h"
#import "JASidePanelController.h"

@interface PrivacyPolicyViewController () <BaseHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet BaseHeaderView *header;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation PrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Select "Marcar consulta" button @ side menu
    JASidePanelController *panelController = (JASidePanelController *)self.navigationController.parentViewController;
    [(MenuViewController *)panelController.leftPanel selectCell:2];
}

-(void)setup
{
    [self setupNavBar];
    [self setupHeader];
    [self setupTextView];
}

- (void) setupNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)setupTextView
{
    self.textView.text = @"Ao efetuar login no aplicativo e marcar consultas, você está automaticamente concordando com a Política de Privacidade aqui descrita.\n\n1. Sobre os dados pessoais\nO App Regenere é um aplicativo com o objetivo de lembrar os clientes da Empresa Regenere Estética de suas consultas, bem como de possibilitar que eles possam marcá-las e desmarcá-las com facilidade.\nAlém do cadastro presencial (que é comum a todos os clientes do estabelecimento - usuários e não usuários do aplicativo), os usuários do App Regenere devem cadastrar um e-mail válido e uma senha.\nEstes dados são trafegados de forma segura pela Internet para o servidor web da Regenere Estética, que provê todas as informações necessárias para o agendamento das consultas. As senhas salvas são encriptadas, de maneira que ninguém, nem mesmo os administradores do sistema, é capaz de descobri-las.\n\n2. Sobre as consultas\nAs consultas marcadas pelo aplicativo são tão importantes quanto as marcadas presencialmente ou via telefone. Ao agendar pelo aplicativo, este horário é dedicado para o cliente, de maneira que os esteticistas ficarão ociosos se o cliente não comparecer no estabelecimento durante o horário marcado. É dever do cliente desmarcar a consulta se perceber que não vai conseguir estar presente no horário agendado.\n\n3. Outros tópicos\nQuaisquer outros tópicos concernentes à Política de Privacidade ou Termos de Uso que não foram tratados aqui podem ser esclarecidos diretamente através do email olga@olga.com.br.";
    [self.textView setTextContainerInset:UIEdgeInsetsMake(15, 15, 15, 15)];

}


-(void)setupHeader
{
    [self.header setDelegate:self];
    [self.header updateDescriptionLabel:@"Veja nossa política de privacidade"];
    [self.header updateWithName:[[NSUserDefaults standardUserDefaults] objectForKey:@"user-name"]];
    
}

#pragma mark - Base Header View Delegate
-(void)didTapMenuButton
{
    //[(JASidePanelController *)self.navigationController.parentViewController toggleLeftPanel:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end