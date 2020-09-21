import Foundation

fileprivate indirect enum NodeEnum {
    case data(Int)
    case next(Node?)
}

fileprivate struct Node {
    let data: NodeEnum
    var next: NodeEnum?
}

public struct LinkedListEnum {
    fileprivate var linkedList: Node?
    var listLength: Int = 0
    public init(listData: [Int]) {
        listLength = listData.count
        createLinkedList(listData: listData)
    }
    
    mutating func createLinkedList(listData: [Int]) {
        let reversedList = listData.reversed()
        for (index,data) in reversedList.enumerated() {
            var currentNode = getNode(data: data)
            if (index == 0) {
                linkedList = currentNode
            } else {
                currentNode.next = NodeEnum.next(linkedList)
                linkedList = currentNode
            }
        }
        printLinkedList()
    }
    
    func printLinkedList() {
        var printResult = ""
        func getNodeElement(nodeEnum: NodeEnum?) -> Node? {
            if let nodeElement = nodeEnum {
                switch nodeElement {
                case .next(let optionalNode):
                    if case .some(let wrappedNode) = optionalNode {
                        return wrappedNode
                    }
                default:
                    return nil
                }
            }
            return nil
        }
        func getNodeData(node: Node) -> Int {
            switch node.data {
            case .data(let intValue):
                return intValue
            default:
                return 0
            }
        }
        var currentList = linkedList
        while (currentList != nil) {
            printResult = printResult + String(getNodeData(node: currentList!))
            if (getNodeElement(nodeEnum: currentList?.next) != nil) {
                printResult += " -> "
            }
            currentList = getNodeElement(nodeEnum: currentList!.next)
        }
        print(printResult)
    }
    
    fileprivate func getNode(data: Int) -> Node {
        return Node(data: NodeEnum.data(data), next: NodeEnum.next(nil))
    }
    
}
