import Foundation

class Node {
    var data: Int
    var left: Node?
    var right: Node?
    init(data: Int) {
        self.data = data
        left = nil
        right = nil
    }
}

struct SimpleTree {
    var rootNode: Node
    
    init (root: Int) {
        rootNode = Node(data: root)
    }
    
    func leftView() {
        var height = 1
        var leftViewResult = ""
        
        func printLeftView(node: Node?, currentHeight: Int) {
            if (node == nil) {
                return
            } else {
                if(currentHeight + 1 > height) {
                    height = currentHeight + 1
                    leftViewResult += " \(node!.data)"
                }
                printLeftView(node: node?.left, currentHeight: currentHeight + 1)
                printLeftView(node: node?.right, currentHeight: currentHeight + 1)
            }
        }
        
        printLeftView(node: rootNode, currentHeight: height)
        print(leftViewResult)
    }
    
    func isBST() -> Bool {
        var isBST = true
        
        func checkBST(currentNode: Node?) {
            guard let node = currentNode else { return }
            isBST = isBST && (node.left?.data ?? node.data - 1 < node.data) && (node.right?.data ?? node.data + 1 > node.data)
            if (!isBST) {
                return
            } else {
                checkBST(currentNode: node.left)
                checkBST(currentNode: node.right)
            }
        }
        checkBST(currentNode: rootNode)
        return isBST
    }
    func bottomView() {
        var bottomViewResult = ""
        var hd: [Int: (value: Int, height: Int)] = [:]
        
        func printBottomView(node: Node?, currentHd: Int, currentHeight: Int) {
            guard let currentNode = node else { return }
            if let hdValue = hd[currentHd] {
                if currentHeight >= hdValue.height {
                    hd[currentHd] = (currentNode.data, currentHeight)
                }
            } else {
                hd[currentHd] = (currentNode.data, currentHeight)
            }
            
            printBottomView(node: currentNode.left, currentHd: currentHd - 1, currentHeight:  currentHeight + 1)
            printBottomView(node: currentNode.right, currentHd: currentHd + 1, currentHeight:  currentHeight + 1)
        }
        printBottomView(node: rootNode, currentHd: 0, currentHeight: 1)
        for value in hd.values {
            bottomViewResult += " \(value.value)"
        }
        print(bottomViewResult)
    }
    func verticalOrder() {
        
        typealias tupleNode = (node: Node?, hd: Int)
        class LinkedListNode {
            var node: tupleNode
            var next: LinkedListNode?
            init(node: tupleNode) {
                self.node = node
                next = nil
            }
        }
        
        struct LinkedList {
            var linkedList: LinkedListNode?
            
            init(listData: LinkedListNode) {
                linkedList = listData
            }
            mutating func insert(node: LinkedListNode) {
                var tempHead: LinkedListNode? = linkedList
                while tempHead?.next != nil {
                    tempHead = tempHead?.next
                }
                tempHead?.next = node
            }
            mutating func deleteFirstNode() {
                let tempHead = linkedList
                linkedList = linkedList?.next
                tempHead?.next = nil
            }
        }
        
        var verticalOrderResult = ""
        var nodeDict: [Int: [Node]] = [:]
        var linkedListStruct = LinkedList(listData: LinkedListNode(node: (node: rootNode, hd: 0)))
        
        while linkedListStruct.linkedList != nil {
            let linkedList = linkedListStruct.linkedList
            if let leftNode = linkedList?.node.node?.left {
                linkedListStruct.insert(node: LinkedListNode(node: (node: leftNode, hd: linkedList!.node.hd - 1)))
            }
            if let rightNode = linkedList?.node.node?.right {
                linkedListStruct.insert(node: LinkedListNode(node: (node: rightNode, hd: linkedList!.node.hd + 1)))
            }
            if let currentNode = linkedList?.node.node, let currentHd = linkedList?.node.hd {
                if nodeDict[currentHd] != nil {
                    var nodeArray = nodeDict[currentHd]
                    nodeArray?.append(currentNode)
                    nodeDict[currentHd] = nodeArray ?? []
                } else {
                    nodeDict[currentHd] = [currentNode]
                }
            }
            linkedListStruct.deleteFirstNode()
        }
        
        for key in nodeDict.keys.sorted() {
            nodeDict[key]?.compactMap {
                verticalOrderResult += " \($0.data)"
            }
            verticalOrderResult += "\n"
        }
        print(verticalOrderResult)
    }
    func convertToDoublyLinkedList() {
        class DoublyLinkedListNode {
            var data: Int
            var next: DoublyLinkedListNode?
            var prev: DoublyLinkedListNode?
            init(data: Int) {
                self.data = data
                next = nil
                prev = nil
            }
        }
        
        func linkedList(node: Node) -> (start: DoublyLinkedListNode, end: DoublyLinkedListNode) {
            
            let doublyNode = DoublyLinkedListNode(data: node.data)
            var listStart: DoublyLinkedListNode = doublyNode
            var listEnd: DoublyLinkedListNode = doublyNode
            
            if let leftNode = node.left {
                let leftList = linkedList(node: leftNode)
                listStart = leftList.start
                doublyNode.prev = leftList.end
                leftList.end.next = doublyNode
            }
            
            if let rightNode = node.right {
                let rightList = linkedList(node: rightNode)
                listEnd = rightList.end
                doublyNode.next = rightList.start
                rightList.start.prev = doublyNode
            }
            
            return(listStart, listEnd)
        }
        var listStart: DoublyLinkedListNode? = linkedList(node: rootNode).start
        var listResult = ""
        while listStart != nil {
            listResult += " \(listStart!.data)"
            listStart = listStart?.next
        }
        print(listResult)
    }
}

func heapSort(arr: [Int]) -> Array<Int> {
    let arrLength = arr.count
    var heapArray: [Int] = arr
    func swapArrElement(arr: inout [Int], index1: Int, index2: Int) {
        let temp = arr[index1]
        arr[index1] = arr[index2]
        arr[index2] = temp
    }
    func heapify(arry: inout [Int], length: Int, rootIndex: Int ) {
        var largest: Int = rootIndex
        let l = 2 * rootIndex + 1
        let r = 2 * rootIndex + 2
        if (l < length && arry[l] > arry[largest]) {
            largest  = l
        }
        if (r < length && arry[r] > arry[largest]) {
            largest = r
        }
        if (largest != rootIndex) {
            swapArrElement(arr: &arry, index1: rootIndex, index2: largest)
            heapify(arry: &arry, length: length, rootIndex: largest)
        }
    }
    var l: Int = (arrLength/2) - 1
    while (l >= 0) {
        heapify(arry: &heapArray, length: arrLength, rootIndex: l)
        l -= 1
    }
    
    var length = arrLength - 1
    while (length > 0) {
        swapArrElement(arr: &heapArray, index1: 0, index2: length)
        heapify(arry: &heapArray, length: length, rootIndex: 0)
        length -= 1
    }
    print(heapArray)
    return heapArray
}

//heapSort(arr: [5,15,1,3,8,2,10])
//
//let simpleTree = SimpleTree(root: 20)
//var rootNode = simpleTree.rootNode
//
//var eightNode = Node(data: 8)
//var twentyTwoNode = Node(data: 22)
//var fiveNode = Node(data: 5)
//var threeNode = Node(data: 3)
//var twentyFiveNode = Node(data: 25)
//var tenNode = Node(data: 10)
//var fourteenNode = Node(data: 14)
//
//rootNode.left = eightNode
//rootNode.right = twentyTwoNode
//eightNode.left = fiveNode
//eightNode.right = threeNode
//threeNode.left = tenNode
//threeNode.right = fourteenNode
//twentyTwoNode.right = twentyFiveNode
//
//simpleTree.convertToDoublyLinkedList()

