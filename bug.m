In Objective-C, a subtle bug can arise from the interaction between KVO (Key-Value Observing) and memory management.  If an observer is not removed properly before the observed object is deallocated, a crash can occur. This is because the observer's dealloc method might attempt to access the already-deallocated object, leading to an EXC_BAD_ACCESS error. This is particularly problematic with weak references as they can become nil at unexpected times.

Example:

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
    // ... Accessing observedProperty, potential crash after deallocation
}

- (void)dealloc {
    // Missing removeObserver
}
@end

int main() {
    MyObservedObject *observed = [[MyObservedObject alloc] init];
    MyObserver *observer = [[MyObserver alloc] init];

    [observed addObserver:observer forKeyPath:@