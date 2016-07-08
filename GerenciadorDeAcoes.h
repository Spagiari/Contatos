//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by ios5948 on 07/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Contato.h"

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

-(id) initWithContato:(Contato *) contato;
-(void) acoesDoController:(UIViewController*) controller;

@property (weak) Contato *contato;
@property (weak) UIViewController* controller;

@end
