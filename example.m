#import "ObjCheck.h"
#import <Foundation/Foundation.h>

int main(int argc, char **argv) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	printf("Random integer: %d\n", [ObjCheck genInt]);

	printf("Random boolean: %d\n", [ObjCheck genBool]);

	printf("Random character: %c\n", [ObjCheck genChar]);

	// ...

	[pool drain];

	return 0;
}