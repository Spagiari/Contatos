//
//  Contatos.m
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

//@synthesize nome = _nome;
//@synthesize email = _email;
//@synthesize endereco = _Endereco;
//@synthesize site = _site;
//@synthesize telefone = _telefone;
//@synthesize foto = _foto;
//@synthesize latitude = _latitude;
//@synthesize longitude = _longitude;


@dynamic nome, email, endereco, site, telefone, foto, latitude, longitude;


-(CLLocationCoordinate2D) coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString*) title{
    return self.nome;
}

-(NSString*) subtitle{
    return self.email;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Email: %@, Endereço: %@, Site: %@", self.nome, self.telefone, self.email, self.endereco, self.site];
}

@end