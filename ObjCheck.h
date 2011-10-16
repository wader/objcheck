#import <Foundation/Foundation.h>

@interface NSObject (performSelectorWithArgsArray)
- (id)performSelector:(SEL)sel withArgsArray:(NSArray *)args;
@end

@interface ObjCheck: NSObject {}

+ (id) genNum;
+ (id) genBool;
+ (id) genChar;
+ (id) genArray: (id(^)()) gen;
+ (id) genString;

+ target:(id)target withSelector:(SEL)sel withGenerators:(NSArray *)generators;

@end
