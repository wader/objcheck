#import "example.h"
#import "ObjCheck.h"
#import <Foundation/Foundation.h>

@implementation Example

+ (id) isEven: (id) args {
	NSNumber* i = [(NSArray*) args objectAtIndex: 0];

	BOOL b = [i intValue] % 2 == 0;

	return [NSNumber numberWithBool: b];
}

@end

int main(int argc, char **argv) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSArray* gs = [NSMutableArray array];
	gs = [gs arrayByAddingObject: ^() { return [ObjCheck genNum]; }];

	[ObjCheck forAll: ^(id args) { return [Example isEven: args]; } withGenerators: gs ];

	[pool drain];

	return 0;
}