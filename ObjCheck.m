#import "ObjCheck.h"
#import <Foundation/Foundation.h>
#import <stdlib.h>

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
	NSArray* arr = [NSMutableArray array];

	int len = arc4random() % 100;

	int i;
	for (i = 0; i < len; i++) {
		id value = gen();

		arr = [arr arrayByAddingObject: value];
	}

	return arr;
}

+ (id) genString {
	NSArray* arr = (NSArray*) [self genArray: ^() { return [ObjCheck genChar]; }];

	NSString* s = [NSMutableString stringWithCapacity: [arr count]];

	int i;
	for (i = 0; i < [arr count]; i++) {
		s = [s stringByAppendingString: [NSString stringWithFormat: @"%c", [[(NSArray*) arr objectAtIndex: i] charValue]]];
	}

	return s;
}

+ forAll: (id(^)(id)) property withGenerators: (id) generators {
	int i, j, k;
	for (i = 0; i < 100; i++) {
		NSArray* values = [NSMutableArray array];

		for (j = 0; j < [generators count]; j++) {
			id value = ((id(^)()) [(NSArray*) generators objectAtIndex: j])();

			values = [values arrayByAddingObject: value];
		}

		NSNumber* propertyHolds = property(values);

		if(![propertyHolds boolValue]) {
			printf("*** Failed!\n");

			for(k = 0; k < [values count]; k++) {
				printf("%s\n", [[[values objectAtIndex: k] description] UTF8String]);
			}

			return;
		}
	}

	printf("+++ OK, passed 100 tests.\n");
}

@end