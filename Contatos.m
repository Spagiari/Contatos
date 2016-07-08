//
//  Contatos.m
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(CLLocationCoordinate2D) coordinate{
    return CLLocationCoordinate2DMake([_latitude doubleValue], [_longitude doubleValue]);
}

-(NSString*) title{
    return _nome;
}

-(NSString*) subtitle{
    return _email;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Email: %@, Endereço: %@, Site: %@", self.nome, self.telefone, self.email, self.endereco, self.site];
}

@end