//
//  NSMutableDictionary+NonRetainedObjectKey.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 31.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "NSMutableDictionary+NonRetainedObjectKey.h"

@implementation NSMutableDictionary (NonRetainedObjectKey)


-(void)setObject:(id)anObject forNonRetainedKey:(id)aKey;
{
    [self setObject:anObject forKey:[NSValue valueWithNonretainedObject:aKey]];
}
-(id)objectForNonRetainedKey:(id)aKey
{
    return [self objectForKey:[NSValue valueWithNonretainedObject:aKey]];
    
}
-(void)removeObjectForNonRetainedKey:(id)aKey
{
    [self removeObjectForKey:[NSValue valueWithNonretainedObject:aKey]];
}

@end
