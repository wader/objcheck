#import "example.h"
#import "ObjCheck.h"
#import <Foundation/Foundation.h>

@implementation Example

+ (id) isEven: (id) args {
	NSNumber* i = [(NSArray*) args objectAtIndex: 0];

	BOOL b = [i intValue] % 2 == 0;

	return [NSNumber numberWithBool: b];
}

+ (id) genEven {
	int i = [(NSNumber*)[ObjCheck genNum] intValue];

	if(i % 2 != 0) {
		i++;
	}

	return [NSNumber numberWithInt: i];
}

@end

int main(int argc, char **argv) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSArray* gs = [NSMutableArray array];
	gs = [gs arrayByAddingObject: ^() { return [ObjCheck genNum]; }];

	// Are all integers even?
	[ObjCheck forAll: ^(id args) { return [Example isEven: args]; } withGenerators: gs];

	NSArray *gs2 = [NSMutableArray array];
	gs2 = [gs2 arrayByAddingObject: ^() { return [Example genEven]; }];

	// Are all even integers even?
	[ObjCheck forAll: ^(id args) { return [Example isEven: args]; } withGenerators: gs2];

	[pool drain];

	return 0;
}