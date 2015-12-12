# Course2-14
Multithreading - GCD, NSOperationQueue

This is a project for multithreading work demonstation. The main logic is to compute sum of first `n` prime numbers and to make
that computation harder we use multiplier and display that in the `UITableView`. You can find way to parallelize the
computation using `GCD` (Grand Central Dispatch) and `NSOperationQueue` and store computed values in the `NSCache`. 
Your task is to add dependencies using `NSOperation` to prevent computing sum of `i`-th number before competion of `i-1`-th 
sum
