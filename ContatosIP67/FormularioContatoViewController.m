//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Adic. Contatos";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (_contato)
    {
        UIBarButtonItem* botaoEditarContato = [[UIBarButtonItem alloc] initWithTitle:@"Salvar"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(SalvaContato)];
        self.navigationItem.rightBarButtonItem = botaoEditarContato;
        
        _txtNome.text = _contato.nome;
        _txtTelefone.text = _contato.telefone;
        _txtEmail.text = _contato.email;
        _txtEndereco.text = _contato.endereco;
        _txtSite.text = _contato.site;
        if (_contato.foto) {
            [_btnFoto setBackgroundImage:_contato.foto forState: UIControlStateNormal];
            [_btnFoto setTitle:nil forState:UIControlStateNormal];
        }
        _txtLat.text = [_contato.latitude stringValue];
        _txtLon.text = [_contato.longitude stringValue];
    }
    else
    {
        UIBarButtonItem* botaoAdicionarContato = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = botaoAdicionarContato;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)criaContato {
    _contato = [Contato new];
    [self pegaDadosDoFormulario];
    [self.dao adicionarcontato:_contato];
    [self.navigationController popViewControllerAnimated:YES];

    NSLog(@"Dados: %@", self.dao);
}

- (void) SalvaContato {
    [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    [_lista destacaContato:_contato];
}

- (void) pegaDadosDoFormulario {
    _contato.nome = [self.txtNome text];
    _contato.telefone = [self.txtTelefone text];
    _contato.email = [self.txtEmail text];
    _contato.endereco = [self.txtEndereco text];
    _contato.site = [self.txtSite text];
    _contato.foto = [self.btnFoto backgroundImageForState:UIControlStateNormal];
    _contato.latitude = [NSNumber numberWithFloat:[_txtLat.text floatValue]];
    _contato.longitude = [NSNumber numberWithFloat:[_txtLon.text floatValue]];
}


-(IBAction) tiraFoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancelar"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        
        [sheet showInView:self.view];
    }
    else
    {
        UIImagePickerController* picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* foto = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [_btnFoto setBackgroundImage:foto forState: UIControlStateNormal];
    [_btnFoto setTitle:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController* picker = [UIImagePickerController new];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(IBAction) BuscaCoordenadas:(UIButton*)sender {
    sender.hidden = YES;
    [self.load startAnimating];
    CLGeocoder* coder = [CLGeocoder new];
    void(^trataCoordSelf)(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) = ^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        trataCoord(placemarks, error, self, sender);
    };
    
    [coder geocodeAddressString:_txtEndereco.text
              completionHandler:trataCoordSelf];
    
//    [coder geocodeAddressString:_txtEndereco.text
//              completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                  if (error==nil && [placemarks count] > 0)
//                  {
//                      _txtLat.text = [NSString stringWithFormat:@"%f",placemarks[0].location.coordinate.latitude];
//                      _txtLon.text = [NSString stringWithFormat:@"%f",placemarks[0].location.coordinate.longitude];
//                      [self.load stopAnimating];
//                  }
//                  [self.load stopAnimating];
//                  sender.hidden = NO;
//              }];

}

void(^trataCoord)(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error, FormularioContatoViewController* meuself, UIButton*sender) = ^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error, FormularioContatoViewController* meuself, UIButton* sender){
    meuself.txtLat.text = [NSString stringWithFormat:@"%lf",placemarks[0].location.coordinate.latitude];
    meuself.txtLon.text = [NSString stringWithFormat:@"%lf",placemarks[0].location.coordinate.longitude];
    [meuself.load stopAnimating];
    sender.hidden = NO;
};

@end
