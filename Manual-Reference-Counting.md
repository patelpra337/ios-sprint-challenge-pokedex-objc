# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    ```
    NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

    for (NSString *word in words) {
        NSNumber *count = wordFrequency[word];
        if (count) {
            wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
        } else {
            wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
        }
    }

    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    [wordFrequency release];
    ```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
            `yesterday` is autoreleased because it is initialized with a convenience initializer.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
            `theFuture` is not autoreleased because it calls the `retain` method on the object as soon as it is initialized.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
            `name` is not autoreleased because it is initialized using `alloc` and a designated `init` initializer.
	
	4. `NSDate *food = [NSDate new];`
            `food` is not autoreleased because it is initialized using `new`.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
            `john` is not autoreleased because it is initialized using `alloc` and a designated `init` initializer.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
            `max` is autoreleased because it calls the `autorelease` method on the object as soon as it is initialized.

3. Explain when you need to use the `NSAutoreleasePool`.
    The NSAutoreleasePool class is used to implement Foundation’s autorelease mechanism. An autorelease pool stores objects that are released when the pool itself is released.

    An NSAutoreleasePool object contains objects that have received an autorelease message and when deallocated sends a release message to each of those objects. An object can be put into the same pool several times and receives a release message for each time it was put into the pool. Thus, sending autorelease instead of release to an object extends the lifetime of that object until the pool itself is released, or longer if the object is retained.

    NSAutoreleasePool objects are automatically created and destroyed in the main thread of applications based on the Application Kit, so your code normally does not have to deal with them. The Application Kit creates a pool at the beginning of the event loop and releases it at the end, thereby periodically releasing any autoreleased objects generated while processing events.For example, if our code contains a for-loop that iterates thousands of times and initializes (and autoreleases) a large object with each iteration of the loop, then none of the autoreleased objects will get released until sometime after the for-loop finishes. This would potentially casue the app to use up a significant amount of memory and might even cause the app to crash. To protect against this we could wrap the body of the for-loop inside  `@autoreleasepool { //body of for-loop }`, which will allow the compiler to drain the pool at the end of each and every interation of the for-loop as needed.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personWithName:(NSString *)name;

@end

@implementation LSIPerson

+ (instancetype)personWithName:(NSString *)name
{
    LSIPerson *person = [[self alloc] initWithName:name];
    return [person autorelease];
}

@end
```
