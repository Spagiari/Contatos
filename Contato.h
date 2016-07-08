//
//  Contato.h
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef Contato_h
#define Contato_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject<MKAnnotation>

-(NSString *)description;

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) UIImage  *foto;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

@end

#endif /* Contato_h */
