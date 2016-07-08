//
//  GerenciadorDeAcoes.m
//  ContatosIP67
//
//  Created by ios5948 on 07/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "GerenciadorDeAcoes.h"

@implementation GerenciadorDeAcoes

-(id) initWithContato:(Contato *) contato {
    self = [super init];
    if (self)
        _contato = contato;
    return self;
}

-(void) acoesDoController:(UIViewController*) controller {
    _controller = controller;
    
    if ([self isPhone]) {
        UIActionSheet* menu=[[UIActionSheet alloc] initWithTitle:@"Ações"
                                                        delegate:self
                                               cancelButtonTitle:@"Fechar"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"Ligar", @"E-Mail", @"Site", @"Endereço", nil];
        [menu showInView:controller.view];
    }
    else
    {
        UIActionSheet* menu=[[UIActionSheet alloc] initWithTitle:@"Ações"
                                                        delegate:self
                                               cancelButtonTitle:@"Fechar"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"E-Mail", @"Site", @"Endereço", nil];
        [menu showInView:controller.view];
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([self isPhone]) {
        switch (buttonIndex) {
            case 0:
                [self ligar];
                break;
            case 1:
                [self enviaEmail];
                break;
            case 2:
                [self abreSite];
                break;
            case 3:
                [self mostraMapa];
                break;
            
            default:
            break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 0:
                [self enviaEmail];
                break;
            case 1:
                [self abreSite];
                break;
            case 2:
                [self mostraMapa];
                break;
                
            default:
                break;
        }
    }
}

-(void) ligar {
    NSString* fonedocontato = [NSString stringWithFormat:@"tel://%@", _contato.telefone];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:fonedocontato]];
}

-(void) abreSite {
    NSString* siteDoContato = [NSString stringWithFormat:@"http://%@", _contato.site];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:siteDoContato]];
}

-(void) mostraMapa {
    NSString* EnderecoDoContato = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", _contato.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:EnderecoDoContato]];
}

-(void) enviaEmail {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* mail = [MFMailComposeViewController new];
        [mail setToRecipients:@[_contato.email]];
        [mail setSubject:@"assunto"];
        mail.mailComposeDelegate = self;
        [_controller presentViewController:mail animated:YES completion:nil];
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) isPhone {
    UIDevice *device = [UIDevice currentDevice];
    return [device.model isEqualToString:@"iPhone"];
}

@end
