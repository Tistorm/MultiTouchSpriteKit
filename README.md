MultiTouchSpriteKit
===================

MultiTouchSpriteKit is a collection of extensions for Apple's SpriteKit framework. Created by [Simon Voelker](mailto: Tistorm@mail.com).

 Additional extensions will follow in the next couple of weeks.

 

### SKNode+MTKTransform
This category allows to directly manipulated SKNodes with up to two touch points.

```
-(void)transformWithUITouches:(NSSet *)touches;
```
This method takes a set of up to two UITouches and transforms the node such that the relative position of the touches to the node stay the same to the relative position of the previous touch locations. 

If the set contains only one touch the node will only be moved. If the set contains two touches the node will be moved, rotated and scaled.

This behavior can be modified by modifying the property <code>@property(nonatomic)MTKNodeTransformationConstraints transformationConstraints; </code>

The transformationConstraints can be set to the following values:

```
typedef NS_OPTIONS(NSInteger, MTKNodeTransformationConstraints)
{
  
    MTKNoteMoveable = 1 << 0,
    MTKNoteScalabe  = 1 << 1,
    MTKNoteRotatable  = 1 << 2,
    MTKNoteTransformable  = 1 << 3,
    MTKNoteFixed = 1 << 5
};
```

In addition to using UITouches to transform the node, the transformation can also be calculated by using two set of two CGPoints.

```
-(NSDictionary*)transformFromPoints:(NSArray*)startPoints inCoordinatesOfNode:(SKNode*)startNode toPoints:(NSArray*)endPoints inCoordinatesOfNode:(SKNode*)endNode;
```
This method takes two arrays of up to two CGPoints stored in NSValues and the coordinate system of these CGPoints and returns the result as an NSDictionary with the following keys and objects:

* **position:** The absolute position of the node in coordinates of the parent node as a CGPoint stored in a NSValue.
*  **scale:** The absolute scale of the node as a CGSize stored in a NSValue.
*  **angle:** The absolute angle to its parent node as a float stored in a NSNumber.



### MTKAction

MTKAction is a custom animation class that uses the SKAction animation system. A MTKAction allows you to run custom code directly before an animation, on each frame of the animation, and directly after an animation.
 
  To create a custom MTKAction you have to subclass the MTKAction class and overwrite all of these three methods:
 
 ```
 -(void)setup:(SKNode *)node;
 ```
 This method is called exactly once at the beginning of the animation.
 
 
 ```
 -(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime;
 ```
 
  This method is called every frame while the action is running.
 
 ```
 -(void)teardown:(SKNode*)node;
 ```
  This method is called exactly once at the end of the animation.
  
To use your custom animation you just have to initialize your subclass with a duration and run it on a SKNode:

```
MyCustomMoveAction* myAction = [MyCustomMoveAction alloc] initWithDuration:4]; 
[myNode runAction:myAction.skAction];
  ```
 




### MTKUtil

A set of C-functions for working with CGPoint, CGSize, and CGVector

For example, it contains:

```
CGFloat MTKPointLength(CGPoint vector);
CGPoint MTKPointNormalize(CGPoint vector);
CGPoint MTKPointVectorBetweenPoints(CGPoint start, CGPoint end);
```

### NSValue+CGElements
This category extends the NSValue class to store CGPoint, CGSize, and CGRect on Mac OS with the same method names as on iOS.


