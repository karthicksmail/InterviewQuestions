# Question:

There are 100 doors in a long hallway. They are all closed. The first time you walk by each door, you open it. The second time around, you close every second door (since they are all opened). On the third pass you stop at every third door and open it if it’s closed, close it if it’s open. On the fourth pass, you take action on every fourth door. You repeat this pattern for 100 passes.

At the end of 100 passes, what doors are opened and what doors are closed?

# Solution:

## Trivial Solution:

An array of booleans is initialized with `false` (implies closed) representing the state of the doors. It involves two loops. The outer one is for each pass and the inner loop is for the doors. The value in the element is toggled based on the two iterations.

### Complexity
This solution for the problem has a time complexity of O(N<sup>2</sup>) and a memory complexity of O(N).

