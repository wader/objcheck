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
	NSString* s = @"";

	NSArray* arr = [self genArray: ^() { return [ObjCheck genChar]; }];

	if ([arr count] < 1) {
		return @"";
	}

	char* arr2 = (char*) malloc(sizeof(char) * ([arr count] + 1));

	int i;
	for (i = 0; i < [arr count]; i++) {
		arr2[i] = '\0';
	}

	for (i = 0; i < [arr count]; i++) {
		arr2[i] = [[arr objectAtIndex: i] charValue];
	}

	s = [NSString stringWithUTF8String: arr2];

	free(arr2);

	return s;
}

+ forAll: (id^(id)) property withGenerators: (id) generators {
	// ...
}

@end