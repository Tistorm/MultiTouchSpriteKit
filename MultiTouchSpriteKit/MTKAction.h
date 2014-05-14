//
//  MTKAction.h
//
//  Created by Simon Voelker and Moritz Wittenhagen on 05.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

/***********************************************************************************
 *
 * Copyright (c) 2014 Simon Voelker, Moritz Wittenhagen
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "SKNode+MTKTransform.h"

/**
MTKAction  is a custom SKAction class that allows to execute custom code before, during and after the Action.
 
 Each MTKAction consist of 3 sequential steps:
 
 * setup: is executed exactly once at the beginning of the animation
 
 - Bug: During the start of an application directly with a MTKAction the setup: method can be called more then once. This is due to a bug that during the start of an Application the SKAction method customActionWithDuration:actionBlock: is called multiple times even if the duration is set to 0. However, this happens only at the start of an application.
 
 * update:elapsedTime: is executed every frame while the action is running
 
 * teardown: is executed exactly once at the end of the animation
 
 To create your custom MTKAction you have to subclass the MTKAction class and overwrite all three methods.
 */
@interface MTKAction : NSObject

/**
 *  The SKAction that can be used to run the MTKAction on any SKNode.
 */
@property (readonly) SKAction *skAction;
/**
 *  The duration of the MTKAction.
 */
@property (readonly) CGFloat duration;


/**
 *  Init method
 *
 *  @param duration The duration of the animation in seconds.
 *
 *  @return A new MTKAction object.
 */
- (id)initWithDuration:(NSTimeInterval)duration;


/**
 *  Is called exactly once at the beginning of the animation.
 *
 * @bug During the start of an application directly with a MTKAction the setup: method can be called more then once. This is due to a bug that during the start of an Application the SKAction method customActionWithDuration:actionBlock: is called multiple times even if the duration is set to 0. However, this happens only at the start of an application.
 *
 *  @param node The node on which the action is running.
 */
-(void)setup:(SKNode *)node;

/**
 *  Is called each on each frame while the animation is running.
 *
 *  @param node The node on which the action is running.
 *  @param elapsedTime The amount of time that has passed in the animation.
 */
-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime;

/**
 *  Is called exactly once at the end of the animation.
 *
 *  @param node The SKNode on which the action is running.
 */
-(void)teardown:(SKNode*)node;


-(NSMutableDictionary*)actionDataForNode:(SKNode*)node;

-(NSMutableDictionary*)actionData;

-(id)dataForNode:(SKNode*)node andKey:(NSString*)key;

-(void)setData:(id)data forNode:(SKNode*)node andKey:(NSString*)key;

+(MTKAction*)animateProperty:(NSString*)name to:(id)targetValue withDuration:(NSTimeInterval)duration;
+(MTKAction*)animateProperty:(NSString*)name by:(id)targetValue withDuration:(NSTimeInterval)duration;

@end




@interface MTKTransformationAction : MTKAction

+(MTKTransformationAction *)transformFromScenePoints:(NSArray*)startPoints toScenePoints:(NSArray*)endPoints  duration:(NSTimeInterval)sec;
+(MTKTransformationAction *)transformToSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec;
+(MTKTransformationAction *)transformToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec;


@end


