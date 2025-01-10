# Objective-C KVO Memory Management Bug

This repository demonstrates a common yet subtle bug in Objective-C related to Key-Value Observing (KVO) and memory management.  Failure to properly remove KVO observers before the observed object is deallocated can lead to crashes.

## The Bug
The `bug.m` file shows an example where an observer is added to an object, but the `removeObserver:` method is not called before the observed object is deallocated. This results in a crash when the observer tries to access the already-deallocated object.

## The Solution
The `bugSolution.m` file demonstrates the correct way to handle KVO to avoid this issue.  It explicitly removes the observer using `removeObserver:forKeyPath:context:` in the observer's `dealloc` method and uses a context parameter for efficient observer removal.