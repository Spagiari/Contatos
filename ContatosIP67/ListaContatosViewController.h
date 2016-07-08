//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5948 on 05/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"
#import "GerenciadorDeAcoes.h"

@interface ListaContatosViewController : UITableViewController<Pintor>

@property (strong, readonly) ContatoDao* dao;
@property (weak) Contato* contatoSelecionado;
@property (strong) GerenciadorDeAcoes* gerenciador;
@property (strong) NSIndexPath* path;

@end
