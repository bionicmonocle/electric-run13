//
//  ERMyScene.m
//  ElectricRunner
//
//  Created by Adam Iredale on 16/11/2013.
//  Copyright (c) 2013 Bionic Monocle Pty Ltd. All rights reserved.
//

#import "ERMyScene.h"
#import <CoreMotion/CoreMotion.h>

@interface ERMyScene ()

@property (nonatomic, assign) NSUInteger hue;

@property (nonatomic, strong) SKEmitterNode *emitter;

@property (nonatomic, strong) SKSpriteNode *sprite;

@end

@implementation ERMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        //self.blendMode = SKBlendModeSubtract;
//        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
        //[self addChild:myLabel];
        
        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        
        _sprite.position = CGPointMake(160, 240);
        _sprite.alpha = 0.7;
        [self addChild:_sprite];
        
        self.emitter = [[SKEmitterNode alloc] init];//[self newSparky];
        
        _emitter.particleTexture = [SKTexture textureWithImageNamed:@"spark.png"];
        _emitter.particleBirthRate = 1500;
        _emitter.particleLifetime = 1;
        _emitter.particlePositionRange = CGVectorMake(50, 0);
        _emitter.particleSpeed = 200;
        _emitter.particleSpeedRange = 450;
        _emitter.particleAlpha = 1.0;
        _emitter.particleAlphaRange = 0.214;
        _emitter.particleAlphaSpeed = -0.25;
        _emitter.particleScale = 0.291;
        _emitter.particleScaleRange = 0.2;
        _emitter.particleScaleSpeed = -0.3;
        _emitter.particleRotation = 0;
        _emitter.particleRotationRange = M_2_PI;
        _emitter.particleRotationSpeed = 0;
        _emitter.particleColorBlendFactor = 4.003;
        _emitter.emissionAngle = 197.669/180.0 * M_PI;
        _emitter.emissionAngleRange = 2 * M_PI;
        _emitter.xAcceleration = 0;
        _emitter.yAcceleration = 0.0;
        
        _emitter.particleBlendMode = SKBlendModeAdd;
        
        _emitter.particleColor = [self nextColor];
        
        _emitter.position = CGPointMake(231, 330);
        
        [self addChild:_emitter];

        [[NSNotificationCenter defaultCenter] addObserverForName:@"activity"
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification *note) {
                                                          CMDeviceMotion *data = note.object;
                                                          //NSLog(@"%@", data);
                                                          double maxell = MAX(ABS(data.userAcceleration.x), MAX(ABS(data.userAcceleration.y), ABS(data.userAcceleration.z)));
                                                          NSLog(@"%f", maxell);
                                                          
                                                          if (maxell <= 0.1) {
                                                              _emitter.particleSpeed = 200.0;
                                                          } else if (maxell > 0.1) {
                                                              _emitter.particleSpeed = 600.0;
                                                              _emitter.particleColor =[self nextColor];
                                                          }
                                                          
                                                      }];
        
    }
    return self;
}

- (SKColor *)nextColor
{
    _hue = arc4random();
    
    return [SKColor colorWithHue:(_hue % 256)/255.0 saturation:0.9 brightness:0.9 alpha:1.0];
}

- (SKEmitterNode *)newSparky
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    return smoke;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
       // CGPoint location = [touch locationInNode:self];
        
        _emitter.particleColor = [self nextColor];
       
        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
