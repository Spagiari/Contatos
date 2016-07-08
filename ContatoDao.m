//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5948 on 04/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "Contato.h"
#import "ContatoDao.h"
#import <UIKit/UIKit.h>

@implementation ContatoDao

static ContatoDao* defaultdao = nil;

+(id) contatoDaoInstance{
    if (!defaultdao)
        defaultdao = [ContatoDao new];
    return defaultdao;
}

-(id) init{
    self = [super init];
    if (self) {
        _dicSections = [NSMutableDictionary new];
        _keysSections = [NSMutableArray<NSString*> new];
    }
    return self;
}

-(NSArray<NSString*>*) getSections {
    return [_keysSections sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

-(void) adicionarcontato:(Contato*) contato {
    if (![_dicSections objectForKey:[[contato.nome substringToIndex:1] uppercaseString]]) {
        [_dicSections setObject:[NSMutableArray new] forKey:[[contato.nome substringToIndex:1] uppercaseString]];
        [_keysSections addObject:[[contato.nome substringToIndex:1] uppercaseString]];
    }
    [[_dicSections objectForKey:[[contato.nome substringToIndex:1] uppercaseString]] addObject:contato];
    
}

-(NSString*) description {
    return [_dicSections description];
}

-(NSInteger) countSection {
    if (_keysSections)
        return [_keysSections count];
    return 0;
}

-(NSInteger) countOfSectionWithKey: (NSString*) sec {
    if ([_dicSections objectForKey: sec])
        return [[_dicSections objectForKey: sec] count];
    return 0;
}

-(Contato*) buscaContatoDaPosicaoWithSection: (NSInteger) pos section: (NSString*) sec {
    if ([_dicSections objectForKey: sec])
    {
        if ([[_dicSections objectForKey: sec] count] >= pos)
        return [_dicSections objectForKey: sec][pos];
    }
    return nil;
}

-(void) removeContatoDaPosicaoWithSection:(NSInteger) pos section: (NSString*) sec{
    if ([_dicSections objectForKey: sec])
    {
        NSMutableArray* list = [_dicSections objectForKey: sec];
        [list removeObjectAtIndex:pos];
    }
}

-(void) removeSection: (NSString*) sec{
    if ([[_dicSections objectForKey: sec] count] == 0)
    {
        [_dicSections removeObjectForKey:sec];
        [_keysSections removeObject:sec];
    }
}

-(NSIndexPath*) buscaPosicaoDoContato:(Contato*) contato
{
    NSString* key = [[contato.nome substringToIndex:1] uppercaseString];
    NSInteger i = [self.getSections indexOfObject:key];
    
    return [NSIndexPath indexPathForRow:[[_dicSections objectForKey:key] indexOfObject:contato] inSection:i];
}

-(NSArray<Contato*>*) getAllContacts {
    NSMutableArray<Contato*>* contatos = [NSMutableArray<Contato*> new];
    for (NSString* i in _keysSections) {
        [contatos addObjectsFromArray:_dicSections[i]];
    }
    return contatos;
}

@end