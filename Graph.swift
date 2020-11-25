import Foundation

public struct GraphNode: Hashable {
    var value: Int
    var connections: [GraphNode]
    var visited: Bool
    init(value: Int) {
        self.value = value
        visited = false
        connections = []
    }
}

fileprivate class Node {
    var data: GraphNode
    var next: Node?
    init(data: GraphNode, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

public struct StackClass {
    fileprivate var linkedList: Node?
    fileprivate var head: Node?
    var listCount = 0
    public init(listData: [GraphNode]) {
        listCount = listData.count
        createLinkedList(listData: listData)
        printLinkedList()
    }
    mutating func createLinkedList(listData: [GraphNode]) {
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
            printResult += String(currentHead!.data.value)
            if let _ = currentHead?.next {
                printResult += " -> "
            }
            currentHead = currentHead?.next
        }
        print(printResult)
    }
    fileprivate func getNode(data: GraphNode) -> Node {
        return Node(data: data)
    }
    public mutating func push(data: GraphNode) {
        var head = linkedList
        if listCount == 0 {
            linkedList = getNode(data: data)
            listCount += 1
            return
        }
        while (head?.next != nil) {
            head = head?.next
        }
        head?.next = getNode(data: data)
        listCount += 1
        printLinkedList()
        
    }
    public mutating func pop() -> GraphNode? {
        var head = linkedList
        if (listCount == 0) {
            print("-1")
            return nil
        } else if (head?.next == nil) {
            let returnedNode = head?.data
            head = nil
            printLinkedList()
            listCount -= 1
            return returnedNode
        } else {
            while (head?.next?.next != nil) {
                head = head?.next
            }
            let returnedNode = head?.data
            head?.next = nil
            printLinkedList()
            listCount -= 1
            return returnedNode
        }
    }
}

extension StackClass {
    var stackLength: Int {
        return listCount
    }
}

var stack = StackClass(listData: [])



func dfs(graph: [Int]) {
    //0 1 0 2 0 3 2 4
    var rootNode: GraphNode? = nil
    for (idx, num) in graph.enumerated() {
        if (idx % 2 == 0) {
            var firstNode = GraphNode(value: num)
            rootNode = firstNode
            var secondNode = GraphNode(value: graph[idx + 1])
            firstNode.connections.append(secondNode)
            secondNode.connections.append(firstNode)
        }
    }
    guard let mainNode = rootNode else { return }
    var stack = StackClass(listData: [])
    func traverseNodes(node: GraphNode) {
        var recurseNode = true
        var tempNode = node
        while recurseNode && !tempNode.visited{
            print(node.value, "value")
            stack.push(data: tempNode)
            tempNode.visited = true
            if (tempNode.connections.count > 0) {
                tempNode = tempNode.connections[0]
            } else {
                recurseNode = false
            }
        }
    }
    traverseNodes(node: mainNode)
    while stack.linkedList != nil {
        if let deletedNode = stack.pop(), let firstNonVisited =  deletedNode.connections.firstIndex(where: { graphNode in
            graphNode.visited == false
        }) {
            traverseNodes(node: deletedNode.connections[firstNonVisited])
        }
    }
}

dfs(graph: [0, 1, 0, 2 0 3 2 4])
