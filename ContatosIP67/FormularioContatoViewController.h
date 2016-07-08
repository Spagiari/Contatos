//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Contato.h"
#import "ContatoDao.h"

@protocol Pintor <NSObject>

-(void) destacaContato: (Contato*) contato;

@end

@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

-(IBAction) tiraFoto:(id)sender;
-(IBAction) BuscaCoordenadas:(UIButton*)sender;

@property (weak, nonatomic) IBOutlet UITextField* txtNome;
@property (weak, nonatomic) IBOutlet UITextField* txtTelefone;
@property (weak, nonatomic) IBOutlet UITextField* txtEmail;
@property (weak, nonatomic) IBOutlet UITextField* txtEndereco;
@property (weak, nonatomic) IBOutlet UITextField* txtSite;
@property (weak, nonatomic) IBOutlet UITextField* txtLat;
@property (weak, nonatomic) IBOutlet UITextField* txtLon;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* load;

@property (weak, nonatomic) IBOutlet UIButton* btnFoto;

@property (strong) Contato* contato;

@property (strong) ContatoDao* dao;
@property (weak) id<Pintor> lista;
@end
