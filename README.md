MultiTouchSpriteKit
===================

MultiTouchSpriteKit is a collection of extensions for Apple's SpriteKit framework. Created by [Simon Voelker](mailto: Tistorm@mail.com), with support by Moritz Wittenhagen.

 Additional extensions will follow in the next couple of weeks.

****
###Update (03.04.2014)
**[MTKLayerNode](#MTKLayerNode):** A SKSpriteNode backed by a CALayer.

**[MTKShapeNode](#MTKShapeNode):** A subclass of MTKLayer with a CAShapeLayer.

**[MTKAction](#MTKAction):** New property animations.

****

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

###<a name="MTKLayerNode"></a>MTKLayerNode
The MTKLayerNode is a SKSpriteNode backed by a CALayer.
 The CALayer is rendered into a texture which is displayed by SKSpriteNode.

###<a name="MTKShapeNode"></a>MTKShapeNode

Due to the problems of the SKShapeNode, pointed out by [Sartak](http://sartak.org/2014/03/skshapenode-you-are-dead-to-me.html), the MTKShapeNode is a SKSpriteNode backed by a CAShapeLayer. The MTKShapeNode is a subclass of the MTKLayerNode.

It nearly has the same properties as the SKShapeNode plus additional properties from the CAShapeLayer.




###<a name="MTKAction"> MTKAction  _updated_

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
Since a instance of a MTKAction can be applied to more then one node at the same time, some values that store in the <code>setup:</code> method have to stored for each individual node.

Therefore, the following method allow to store node specific values in a NSDictionary:

```
-(NSMutableDictionary*)actionDataForNode:(SKNode*)node;
```
This method returns a NSMutableDictionary for a specific node.

```
-(NSMutableDictionary*)actionData;
```
Returns a global Dictionary to store variable that a independent of the node that runs the the actions. For example for a custom move animation the move vector. 

```
-(void)setData:(id)data forNode:(SKNode*)node andKey:(NSString*)key;
```
Stores a object for a key for a specific node. ****

```
-(id)dataForNode:(SKNode*)node andKey:(NSString*)key;
```
Returns the object for a key that was stored for a specific node


####Generic property animations
The following methods create a animation that animate a specific property of a node (using KeyValueCoding):

```
+(MTKAction*)animateProperty:(NSString*)name to:(id)targetValue withDuration:(NSTimeInterval)duration;
+(MTKAction*)animateProperty:(NSString*)name by:(id)targetValue withDuration:(NSTimeInterval)duration;
```
* **name:** The name of the property.
* **targetValue:** The target value for the property. The type of the target value has to match the type of the property. Only floats, ints, doubles, and CGPoints as NSNumbers or NSValues are currently supported. Other Types such es SKColor will follow soon.
* **duration:** Duration of the animation.

For example, the code to animate a specific float value such as the lineWidth of the MTKShapeNode looks like this:

```
@property float lineWidth;

[MTKAction animateProperty:@"lineWidth" to:@(10.0) withDuration:5];
```




 
###MTKTransformationAction

This class is a subclass of MTKAction which animates the transformation from the SKNode+MTKTransform category.

```
+(MTKTransformationAction *)transformFromScenePoints:(NSArray*)startPoints toScenePoints:(NSArray*)endPoints  duration:(NSTimeInterval)sec;

```
This class methods  returns a MTKAction that transforms the node such that the relative position of the node to the endPoints is the same as it was to the startPoints. This methods currently uses two points.

```
+(MTKTransformationAction *)transformToSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec;
```
This class method return a MTKAction that transforms a SKSpriteNode to the same location, rotation and scale of a other SKSpriteNode.

```
+(MTKTransformationAction *)transformToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec;
```
This class method return a MTKAction that transforms a SKSpriteNode to a Rect in the coordinate system of a other SKSpriteNode.



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


### MTKDemo
In the demo project you can easier test the direct manipulation functionality by transform the Spaceship using one or two fingers. Or you can test the MTKTransformationAction by pressing on the gray rectangles to transform the Spaceship to these positions.

