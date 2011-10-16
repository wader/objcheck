#import "ObjCheck.h"
#import <Foundation/Foundation.h>
#import <stdlib.h>

@implementation NSObject (performSelectorWithArgsArray)
- (id)performSelector:(SEL)sel withArgsArray:(NSArray *)args {
	NSInvocation *inv = [NSInvocation invocationWithMethodSignature:
				       [self methodSignatureForSelector:sel]];
	[inv setSelector:sel];
	[inv setTarget:self];
	int i;
	for (i = 0; i < args.count; i++) {
	      id a = [args objectAtIndex:i];
	      [inv setArgument:&a atIndex:2 + i]; // 0 is target, 1 i cmd-selector
	}
	[inv invoke];

	NSNumber *r;
	[inv getReturnValue:&r];
	return r;
}
@end

@implementation ObjCheck

+ (id) genNum {
	return [NSNumber numberWithInt: arc4random()];
}

+ (id) genBool {
	return [NSNumber numberWithBool: arc4random() % 2 == 0 ];
}

+ (id) genChar {
	return [NSNumber numberWithChar: (char) (arc4random() % 128)];
}

+ (id) genArray: (id(^)()) gen {
	NSMutableArray* arr = [NSMutableArray array];

	int len = arc4random() % 100;
	int i;
	for (i = 0; i < len; i++) {
		[arr addObject:gen()];
	}

	return arr;
}

+ (id) genString {
	NSMutableArray* arr = (NSMutableArray*) [self genArray: ^() { return [ObjCheck genChar]; }];
	NSMutableString* s = [NSMutableString stringWithCapacity: [arr count]];

	int i;
	for (i = 0; i < [arr count]; i++) {
		[s appendString: [NSString stringWithFormat: @"%c", [[arr objectAtIndex: i] charValue]]];
	}

	return s;
}

+ target:(id)target withSelector:(SEL)sel withGenerators:(NSArray *)generators {
	int i, j, k;
	for (i = 0; i < 100; i++) {
		for (NSArray *(^b)() in generators) {
			NSArray *args = b();
			if(![[target performSelector:sel withArgsArray:args] boolValue]) {
				printf("*** Failed! %s %s\n",
				       [NSStringFromSelector(sel) UTF8String],
				       [[args description] UTF8String]);
			}
		}
	}

	printf("+++ OK, passed 100 tests.\n");
}

@end
