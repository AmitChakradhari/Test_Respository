# Test repository

__Single Concepts__
1. Arrays & Hashing (Data Mapping)

**Group Anagrams**: Teaches you how to design a clever hash key (like character counts or sorted strings) to group related data.

**Top K Frequent Elements**: Introduces the concept of Bucket Sort or using a Min/Max Heap to track the "top N" of something.

**Product of Array Except Self**: A masterclass in using Prefix and Suffix arrays to solve problems without division in $O(N)$ time.

**Longest Consecutive Sequence**: Shows you how to use a HashSet for $O(1)$ lookups to build sequences intelligently, avoiding $O(N^2)$ sorting limits.

2. Two Pointers & Sliding Window (Linear Iteration)

**3Sum**: Teaches you how to reduce a complex combination problem into a simpler one by sorting the array and using two pointers squeezing inward.

**Container With Most Water**: A classic "Greedy Two-Pointer" problem. You learn how to make logical decisions on which pointer to move based on the constraints (height vs. width).

**Longest Repeating Character Replacement**: The quintessential Sliding Window problem. It teaches you how to dynamically expand and shrink a window based on a running condition (e.g., character frequencies).

3. Stacks & Queues

**Daily Temperatures**: This is your introduction to the Monotonic Stack pattern—a crucial concept for finding the "next greater" or "next smaller" element efficiently.

**Evaluate Reverse Polish Notation**: Teaches you how to use a stack to evaluate mathematical expressions and parse data recursively.

4. Binary Search

**Search in Rotated Sorted Array**: Teaches you how to apply Binary Search even when the array isn't perfectly sorted, by finding the pivot and deciding which half is uniformly sorted.

**Koko Eating Bananas**: Introduces Binary Search on an Answer Space. Instead of searching for an index, you binary search for the value of the answer between a known minimum and maximum bound.

5. Linked Lists

**Reorder List**: A mega-problem that tests three core linked list skills at once: finding the middle (Fast/Slow pointers), reversing a linked list, and merging two lists.

**Copy List with Random Pointer**: Teaches you how to deep-copy a graph-like structure using a Hash Map to track original nodes to their cloned counterparts.
6. Trees & Tries

**Lowest Common Ancestor of a BST**: Teaches you how to leverage the inherent properties of a Binary Search Tree (left is smaller, right is larger) to traverse efficiently.

**Construct Binary Tree from Preorder and Inorder Traversal**: A fantastic exercise in Divide and Conquer. You learn how array ranges correspond to subtrees.

**Implement Trie (Prefix Tree)**: Gives you hands-on experience building a specialized tree structure that is essential for autocomplete and dictionary problems.

7. Graphs

**Number of Islands**: The perfect foundational problem for Matrix Traversal using DFS (Depth First Search) or BFS (Breadth First Search) to find connected components.

**Course Schedule**: A mandatory problem. It forces you to build an Adjacency List and teaches you Topological Sorting and Cycle Detection in a directed graph.

8. Dynamic Programming & Backtracking

**Combination Sum**: The best foundational problem for Backtracking. You learn how to explore all possible paths, build temporary lists, and "backtrack" by removing elements when a path fails.

**Coin Change**: A classic 1D Dynamic Programming (Knapsack) problem. It teaches you how to break a large goal (amount) into smaller overlapping subproblems.

**Longest Palindromic Substring**: Teaches you how to "expand from the center" and introduces 2D DP concepts.

__Mix of Concepts:__
1. **Hash Map + Doubly Linked ListLRU Cache (Medium/Hard)**
The Mix: 
You need $O(1)$ lookups, which screams Hash Map. But you also need to track the "least recently used" item and update orders in $O(1)$ time, which arrays can't do without shifting elements. The solution is pointing Hash Map keys directly to nodes inside a Doubly Linked List.Why solve it: It is the quintessential system design data structure problem. Mastering this guarantees you understand how to manage pointers and memory manually while keeping fast access times.

2. **Hash Map + Dynamic ArrayInsert Delete GetRandom $O(1)$ (Medium)**
The Mix: A Hash Map gives you $O(1)$ insert and delete, but you can't easily get a random element from it. An Array lets you get a random element in $O(1)$ using an index, but deletion is $O(N)$.The Aha Moment: You mix them by storing the values in an Array, and using the Hash Map to store the index of each value. To delete in $O(1)$, you swap the target element with the last element in the array, pop the end, and update the Hash Map.

3. **Depth-First Search (DFS) + Memoization (Dynamic Programming)Longest Increasing Path in a Matrix (Hard - but very accessible)**
The Mix: You need to explore paths on a grid, which requires DFS/Backtracking. However, because paths overlap, a pure DFS will result in a Time Limit Exceeded (TLE) error.The Aha Moment: You must add 2D Dynamic Programming (Memoization). Once a cell computes its longest path, you cache it. It forces you to realize that DP is often just DFS with a memory bank.

4. **Tries (Prefix Trees) + BacktrackingWord Search II (Hard)**
The Mix: You have a grid of letters and a list of words to find. Doing standard DFS/Backtracking for every single word is too slow.The Aha Moment: You insert all the target words into a Trie. As your DFS explores the grid, it walks down the Trie simultaneously. If the current string on the board isn't a prefix in the Trie, the DFS immediately halts, pruning millions of useless recursive branches.

5. **Sorting + Min-Heap (Priority Queue)Meeting Rooms II (Medium) / Minimum Number of Arrows to Burst Balloons (Medium)**
The Mix: You are given intervals (start and end times). First, you must Sort the data to process it linearly. But as you iterate, you need to constantly know "which meeting ends earliest?"The Aha Moment: You dump the end times into a Min-Heap. Sorting handles the incoming data, while the Heap handles the active data state, bringing the complexity to a clean $O(N \log N)$.

6. **Binary Search on Answer + Greedy SimulationCapacity To Ship Packages Within D Days (Medium) / Koko Eating Bananas (Medium)**
The Mix: You aren't searching for a number in an array; you are searching for an abstract capacity. You combine Binary Search (to guess the capacity between a minimum and maximum possible value) with a Greedy Algorithm (iterating through the array to see if your guessed capacity actually works within the given days).Why solve it: It completely changes how you view Binary Search. It becomes an optimization tool rather than just a lookup tool.

7. **Graph Traversal (BFS) + Dynamic ProgrammingCheapest Flights Within K Stops (Medium)**
The Mix: Finding the shortest path in a weighted graph is traditionally done with Dijkstra's Algorithm (Priority Queue + BFS). However, the "Within K Stops" constraint breaks standard Dijkstra because a longer, cheaper route might take too many stops.The Aha Moment: You must blend BFS (to track the number of stops via level-by-level traversal) with a 1D DP Array (to track the minimum cost to reach each city at the current stop limit).

8. **Stack + Hash MapValid Parentheses (Easy/Medium) & Next Greater Element I (Medium)**
The Mix: You use a Monotonic Stack to process elements that are waiting for a matching condition (like an open bracket waiting to be closed, or a number waiting for a strictly larger number). As matches are found, you pop them off the stack and store the relationship in a Hash Map for instant lookups later.

