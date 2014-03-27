//
//  MyScene.m
//  MTKDemo
//
//  Created by Simon Voelker on 26.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
       
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Gill Sans bold"];
        
        myLabel.text = @"MultiTouchSpriteKit Demo";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        SKLabelNode *myDescription = [SKLabelNode labelNodeWithFontNamed:@"Gill Sans bold"];
        
        myDescription.text = @"Transform the Spaceship with one or two fingers.";
        myDescription.fontSize = 24;
        myDescription.position = CGPointMake(CGRectGetMidX(self.frame),
                                             CGRectGetMidY(self.frame)-30);
        
        [self addChild:myDescription];

        
        SKLabelNode *myDescription2 = [SKLabelNode labelNodeWithFontNamed:@"Gill Sans bold"];
        
        myDescription2.text = @"Touch the gray boxes to trigger the animation.";
        myDescription2.fontSize = 24;
        myDescription2.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)-60);
        
        [self addChild:myDescription2];
      
        {
            SKSpriteNode *box = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(150, 150)];
            box.name = @"button";
            [self addChild:box];
            box.position = CGPointMake(150, 150);
            box.zRotation = M_2_PI;
            
        }
        {
            SKSpriteNode *box = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(100, 100)];
            box.name = @"button";
            [self addChild:box];
            box.position = CGPointMake(150, 650);
            box.zRotation = M_1_PI;
            
        }
        {
            SKSpriteNode *box = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(40, 40)];
            box.name = @"button";
            [self addChild:box];
            box.position = CGPointMake(800, 600);
            box.zRotation = 4*M_2_PI;
        }

      
        
        SKSpriteNode *spaceship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        spaceship.size = CGSizeMake(300, 300);
        spaceship.name = @"Spaceship";
        [self addChild:spaceship];
        spaceship.position = CGPointMake(800, 200);
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    SKSpriteNode* spaceship = (SKSpriteNode*)[self childNodeWithName:@"Spaceship"];
    if ([touches count] == 1)
    {
        UITouch* touch = [touches anyObject];
        SKSpriteNode* box = (SKSpriteNode*)[self nodeAtPoint:[touch  locationInNode:self]];
        if ([box.name isEqualToString:@"button"])
        {
            [spaceship runAction:[MTKTransformationAction transformToSprite:box duration:1].skAction ];
        }
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
      SKSpriteNode* spaceship = (SKSpriteNode*)[self childNodeWithName:@"Spaceship"];
    
    NSMutableSet* touchesOnSpaceShip = [NSMutableSet set];
    for (UITouch* touch in touches)
    {
        if ([spaceship containsPoint:[touch locationInNode:self]])
        {
            [touchesOnSpaceShip addObject:touch];
        }
    }
     [spaceship transformWithUITouches:touchesOnSpaceShip];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
