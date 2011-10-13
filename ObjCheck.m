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
	NSArray* arr = [NSArray array];

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
	s = [arr componentsJoinedByString: @""];

	return s;
}

@end