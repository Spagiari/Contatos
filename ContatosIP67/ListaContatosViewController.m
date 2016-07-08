//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5948 on 05/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatoDao.h"
#import "ListaContatosViewController.h"


@implementation ListaContatosViewController

NSArray<NSString *> *sections;

-(void) destacaContato:(Contato*) contato {
    _path = [_dao buscaPosicaoDoContato:contato];
}

-(void) exibeMaisAcoes:(UIGestureRecognizer*) gesture {
    [self clearSelection];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        _contatoSelecionado = [_dao buscaContatoDaPosicaoWithSection:index.row section:sections[index.section]];
        if (_contatoSelecionado)
        {
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:_contatoSelecionado];
            [_gerenciador acoesDoController:self];
        }
        else
        {
            _gerenciador = nil;
        }
    }
    
}

-(void) viewDidAppear:(BOOL)animated {
    if (_path) {
        [self.tableView selectRowAtIndexPath:_path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

-(instancetype)init {
    self = [super init];
    if (self) {
        UIBarButtonItem* botaoExibirFormulario = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(exibeFormulario)];
        
        self.navigationItem.title = @"Contatos";
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        _dao = [ContatoDao contatoDaoInstance];
        UILongPressGestureRecognizer* clickLongo = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
        
        [self.tableView addGestureRecognizer:clickLongo];
        
        UIImage* icone = [UIImage imageNamed:@"lista-contatos.png"];
        
        UITabBarItem* tabItem = [[UITabBarItem alloc] initWithTitle:@"Lista"
                                                               image:icone
                                                                 tag:0];
        self.tabBarItem = tabItem;
    }
    return self;
}

-(void)exibeFormulario {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    FormularioContatoViewController *form_contato = [board instantiateViewControllerWithIdentifier:@"form_contato"];
    
    [self.navigationController pushViewController:form_contato animated: YES];
    
    form_contato.lista = self;
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Aviso"
//                                                                   message:@"Aqui Vamos Exibir formulario"
//                                                            preferredStyle:(UIAlertControllerStyleAlert)];
//    
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {NSLog(@"Click");}];
//    
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
}

-(void)exibeFormulario: (Contato*) contato {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    FormularioContatoViewController *form_contato = [board instantiateViewControllerWithIdentifier:@"form_contato"];
    
    form_contato.lista = self;
    
    form_contato.contato = contato;
    
    [self.navigationController pushViewController:form_contato animated: YES];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    sections = _dao.getSections;
    return [_dao countOfSectionWithKey:sections[section]];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dao countSection];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return sections;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* etiqueta = @"linha";
    UITableViewCell *linha = [tableView dequeueReusableCellWithIdentifier:etiqueta];
    if (!linha)
        linha = [[ UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                   reuseIdentifier: etiqueta];
    //Contato* contato = [_dao buscaContatoDaPosicao:indexPath.row section:indexPath.section];
    Contato* contato = [_dao buscaContatoDaPosicaoWithSection:indexPath.row section:sections[indexPath.section]];
    linha.textLabel.text = contato.nome;
    
    return linha;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[_dao removeContatoDaPosicao:indexPath.row section:indexPath.section];
        [_dao removeContatoDaPosicaoWithSection:indexPath.row section:sections[indexPath.section]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([_dao countOfSectionWithKey:sections[indexPath.section]] == 0) {
            [_dao removeSection:sections[indexPath.section]];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clearSelection];

    Contato* contato = [_dao buscaContatoDaPosicaoWithSection:indexPath.row section:sections[indexPath.section]];
    
    [self exibeFormulario:contato];
}

-(void) clearSelection {
    if (_path) {
        [self.tableView deselectRowAtIndexPath:_path animated:YES];
        _path = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

@end
