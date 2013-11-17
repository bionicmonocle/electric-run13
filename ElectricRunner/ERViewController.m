//
//  ERViewController.m
//  ElectricRunner
//
//  Created by Adam Iredale on 16/11/2013.
//  Copyright (c) 2013 Bionic Monocle Pty Ltd. All rights reserved.
//

#import "ERViewController.h"
#import "ERMyScene.h"

@implementation ERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Configure the view.
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [ERMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.view addSubview:skView];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
