#import "example.h"
#import "ObjCheck.h"
#import <Foundation/Foundation.h>

@implementation Example

+ (id) isEven: (id) i {
	BOOL b = [(NSNumber*) i intValue] % 2 == 0;

	return [NSNumber numberWithBool: b];
}

@end

int main(int argc, char **argv) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSArray* gs = [NSArray init];
	gs = [gs arrayByAddingObject: ^() { return [ObjCheck genNum]; }];

	[ObjCheck forAll: ^(id i) { return [Example isEven: i]; } withGenerators: gs ];

	[pool drain];

	return 0;
}