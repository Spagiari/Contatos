//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#ifndef ContatoDao_h
#define ContatoDao_h

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface ContatoDao : NSObject

+(id) contatoDaoInstance;
-(void) adicionarcontato:(Contato*) contato;
-(NSInteger) countSection;
-(NSInteger) countOfSectionWithKey: (NSString*) sec;
-(Contato*) buscaContatoDaPosicaoWithSection: (NSInteger) pos section: (NSString*) sec;
-(void) removeContatoDaPosicaoWithSection:(NSInteger) pos section: (NSString*) sec;
-(NSArray<NSString*>*) getSections;
-(NSIndexPath*) buscaPosicaoDoContato:(Contato*) contato;
-(void) removeSection: (NSString*) sec;
-(NSArray<Contato*>*) getAllContacts;

@property (strong, readonly) NSMutableDictionary *dicSections;
@property (strong, readonly) NSMutableArray<NSString*> *keysSections;

@end

#endif /* ContatoDao_h */
