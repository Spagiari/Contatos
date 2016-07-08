//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios5948 on 07/07/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (id)init{
    self = [super init];
    if (self) {
        UIImage* icone = [UIImage imageNamed:@"mapa-contatos.png"];
        
        UITabBarItem* tabItem = [[UITabBarItem alloc] initWithTitle:@"Lista"
                                                              image:icone
                                                                tag:0];
        self.tabBarItem = tabItem;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MKUserTrackingBarButtonItem *track = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
    self.navigationItem.rightBarButtonItem = track;
    
    CLLocationManager* manager = [CLLocationManager new];
    [manager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray<Contato*>* contatos = [[ContatoDao contatoDaoInstance] getAllContacts];
    [self.map addAnnotations:contatos];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSArray<Contato*>* contatos = [[ContatoDao contatoDaoInstance] getAllContacts];
    [self.map removeAnnotations:contatos];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
