```objectivec
@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation MyObservedObject
// ...
@end

@interface MyObserver : NSObject
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == nil) return; //Check for nil object before access
    // ... Accessing observedProperty safely
}

- (void)dealloc {
    [observedObject removeObserver:self forKeyPath:@