import Foundation

fileprivate class Node {
    var data: Int
    var next: Node?
    init(data: Int, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

public struct LinkedListClass {
    fileprivate var linkedList: Node?
    fileprivate var head: Node?
    var listCount = 0
    public init(listData: [Int]) {
        listCount = listData.count
        createLinkedList(listData: listData)
        printLinkedList()
    }
    mutating func createLinkedList(listData: [Int]) {
        for (idx, data) in listData.enumerated() {
            if (idx == 0) {
                linkedList = getNode(data: data)
                head = linkedList
            } else {
                let tempNode = getNode(data: data)
                head?.next = tempNode
                head = head?.next
            }
            
        }
    }
    func printLinkedList() {
        var printResult = ""
        var currentHead = linkedList
        while (currentHead != nil) {
            printResult += String(currentHead!.data)
            if let _ = currentHead?.next {
                printResult += " -> "
            }
            currentHead = currentHead?.next
        }
        print(printResult)
    }
    fileprivate func getNode(data: Int) -> Node {
        return Node(data: data)
    }
    public mutating func insert(data: Int, at position: Int? = nil) {
        var head = linkedList
        if listCount == 0 {
            linkedList = getNode(data: data)
            listCount += 1
            return
        }
        if let position = position {
            if position < 0 {
                return
            }
            if position >= listCount {
                while (head?.next != nil) {
                    head = head?.next
                }
                head?.next = getNode(data: data)
            } else if (position == 0){
                let tempNode: Node? = getNode(data: data)
                tempNode?.next = linkedList
                linkedList = tempNode
            }
            else if (position == 1){
                linkedList?.next = getNode(data: data)
            } else {
                var tempCount = 1
                var previosNode: Node?
                while (tempCount != position) {
                    previosNode = head
                    head = head?.next
                    tempCount += 1
                }
                let currentNode = getNode(data: data)
                currentNode.next = head
                previosNode?.next = currentNode
            }
            
        } else {
            while (head?.next != nil) {
                head = head?.next
            }
            head?.next = getNode(data: data)
        }
        listCount += 1
        printLinkedList()
        
    }
    public mutating func delete(data: Int, firstElement: Bool = false) {
        var previosNode: Node?
        var currentNode: Node?
        var nextNode: Node?
        var tempCount = 1
        if (firstElement) {
            if (listCount == 0) {
                print("-1")
                return
            }
            if (linkedList?.next == nil) {
                print(linkedList!.data)
                linkedList = nil
                return
            } else {
                let tempHead = linkedList
                linkedList = linkedList?.next
                print(tempHead!.data)
                tempHead?.next = nil
                return
            }
        }
        if (linkedList?.next == nil) {
            if (linkedList?.data == data) {
                linkedList = nil
                listCount -= 1
                printLinkedList()
            }
        } else {
            while (tempCount <= listCount) {
                if (tempCount == 1) {
                    previosNode = nil
                    currentNode = linkedList
                    nextNode = currentNode?.next
                    if (currentNode?.data == data) {
                        linkedList = nextNode
                        currentNode?.next = nil
                        listCount -= 1
                        printLinkedList()
                        break
                    }
                } else {
                    previosNode = currentNode
                    currentNode = nextNode
                    nextNode = nextNode?.next
                    if (currentNode?.data == data) {
                        previosNode?.next = nextNode
                        currentNode?.next = nil
                        listCount -= 1
                        printLinkedList()
                        break
                    }
                }
                tempCount += 1
            }
        }
    }
    public func findMiddle() -> Int? {
        if listCount > 0 {
            var head = linkedList
            var head2 = linkedList
            while head2?.next != nil {
                head = head?.next
                head2 = head2?.next
                if head2?.next == nil {
                    break
                } else {
                    head2 = head2?.next
                }
            }
            print(head?.data ?? 0)
            return head?.data
        }
        return nil
    }
    public mutating func reverseLinkedList1() {
        //sliding window method
        if (listCount == 0) {
            return
        }
        var previos: Node? = nil
        var current: Node? = nil
        var next = linkedList
        while(next != nil) {
            previos = current
            current = next
            next = next?.next
            current?.next = previos
        }
        linkedList = current
        printLinkedList()
    }
    public mutating func reverseLinkedList2() {
        //recursion
        if (listCount == 0) {
            return
        }
        var head: Node? = nil
        func reverseRecursion(_ node: Node?) {
            
            while (node?.next != nil && node?.next?.next != nil) {
                head = node?.next?.next
                reverseRecursion(node?.next)
            }
            if (node?.next != nil && node?.next?.next == nil) {
                node?.next?.next = node
                node?.next = nil
            }
        }
        reverseRecursion(linkedList)
        if (head != nil) {
            linkedList = head
        }
        printLinkedList()
    }
    public mutating func reverseKGroups(groupSize: Int) {
        
        func reverseK(headNode: Node?) -> Node? {
            var current: Node? = nil
            var previos: Node? = nil
            var next: Node? = headNode
            var size = 0
            while (next != nil && size < groupSize) {
                previos = current
                current = next
                next = next?.next
                current?.next = previos
                size += 1
            }
            if (next != nil) {
                headNode?.next = reverseK(headNode: next)
            }
            return current
        }
        linkedList = reverseK(headNode: linkedList)
        printLinkedList()
    }
    public func findIntersection(newList: LinkedListClass) {
        let length1 = listCount
        let length2 = newList.linkedListLength
        var list1: Node? = linkedList
        var list2: Node? = newList.linkedList
        var diffLength = 0
        if length1 == length2 {
            diffLength = 0
        } else if length1 > length2{
            diffLength = length1 - length2
            while (diffLength != 0) {
                list1 = list1?.next
                diffLength -= 1
            }
        } else {
            diffLength = length2 - length1
            while (diffLength != 0) {
                list2 = list2?.next
                diffLength -= 1
            }
        }
        while (list1 != nil) {
            if (list1?.data == list2?.data) {
                print(list1!.data)
                break
            }
            list1 = list1?.next
            list2 = list2?.next
        }
        if (list1 == nil) {
            print(-1)
        }
    }
    public func findLoop() {
        var slowPtr = linkedList
        var fastPtr = linkedList
        var loopNode: Node? = nil
        while (fastPtr?.next != nil && fastPtr?.next?.next != nil) {
            slowPtr = slowPtr?.next
            fastPtr = fastPtr?.next?.next
            if (slowPtr?.data == fastPtr?.data) {
                loopNode = slowPtr
                break
            }
        }
        if (fastPtr?.next == nil || fastPtr?.next?.next == nil) {
            print(-1)
            return
        }
        if (loopNode != nil) {
            var newPtr = linkedList
            while (newPtr?.next?.data != slowPtr?.next?.data) {
                newPtr = newPtr?.next
                slowPtr = slowPtr?.next
            }
            print(slowPtr!.next!.data)
            slowPtr?.next = nil
        }
    }
    public mutating func merge(with newLinkedList: LinkedListClass) {
        let newList: Node? = newLinkedList.linkedList
        if(listCount == 0) {
            return
        }
        if (newList == nil) {
            printLinkedList()
            return
        }
        func mergeList(first: Node?, second: Node?) -> Node? {
            var tempNode: Node? = nil
            if (first == nil) {
                tempNode = second
                return tempNode
            } else if (second == nil) {
                tempNode = first
                return tempNode
            }
            if (first!.data <= second!.data) {
                tempNode = first
                tempNode?.next = mergeList(first: first?.next, second: second)
            } else if (first!.data >= second!.data) {
                tempNode = second
                tempNode?.next = mergeList(first: first, second: second?.next)
            }
            return tempNode
        }
        linkedList = mergeList(first: linkedList, second: newList)
        printLinkedList()
    }
    func implementQueue() {
        var queueList: LinkedListClass = LinkedListClass(listData: [])
        var tempHead = linkedList
        while(tempHead != nil) {
            if (tempHead?.data == 1) {
                tempHead = tempHead?.next
                queueList.insert(data: tempHead?.data ?? 0, at: queueList.linkedListLength)
            } else if (tempHead?.data == 2) {
                queueList.delete(data: queueList.linkedList?.data ?? 0)
            }
            tempHead = tempHead?.next
        }
    }
    func findNextGreatest(arrayList: [Int]) {
        var stack = LinkedListClass(listData: [])
        var i = 0
        while(i <= arrayList.count) {
            if (i == 0) {
                stack.insert(data: arrayList[0])
                i += 1
                continue
            }
            if (i == arrayList.count) {
                while (stack.linkedList?.data !=  nil ) {
                    print("no greater element for \(stack.linkedList!.data)")
                    stack.delete(data: 0, firstElement: true)
                }
                break
            }
            if (i < arrayList.count) {
                if (arrayList[i] > stack.linkedList!.data) {
                    while (stack.linkedList?.data !=  nil && arrayList[i] > stack.linkedList!.data) {
                        print("next greater element for \(stack.linkedList!.data) is \(arrayList[i])")
                        stack.delete(data: 0, firstElement: true)
                    }
                    stack.insert(data: arrayList[i],at: 0)
                    i += 1
                } else {
                    stack.insert(data: arrayList[i],at: 0)
                    i += 1
                }
            } else {
                print("no greater element for \(arrayList[i-1])")
                i += 1
            }
        }
    }
}

extension LinkedListClass {
    var linkedListLength: Int {
        return listCount
    }
}

//var linkedList = LinkedListClass(listData: [1,2,1,3,2,1,4,2])
//linkedList.findNextGreatest(arrayList: [899,5,3,8,2,34,13,24,56])

