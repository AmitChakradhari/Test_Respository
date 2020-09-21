import Foundation

fileprivate class Node {
    var data: Int
    var front: Node?
    var rear: Node?
    init(data: Int) {
        self.data = data
        front = nil
        rear = nil
    }
}

struct DoublyLinkedList {
    fileprivate var linkedList: Node? = nil
    fileprivate var hashAddress: [Int: Node?] = [:]
    var listCount: Int = 0
    var maxCacheSize: Int = 0
    
    init(listData: [Int], cacheSize: Int = 0) {
        maxCacheSize = cacheSize
        listCount = listData.count
        createLinkedList(listData: listData)
    }
    
    mutating func createLinkedList(listData: [Int]) {
        if (listCount == 0) {
            return
        }
        for data in listData {
            let tempNode = getNode(data: data)
            if (linkedList == nil) {
                linkedList = tempNode
            } else {
                linkedList?.rear = tempNode
                tempNode.front = linkedList
                linkedList = tempNode
            }
        }
    }
    fileprivate func getNode(data: Int) -> Node {
        return Node(data: data)
    }
    fileprivate mutating func insert(node: Node, key: Int) {
        let tempNode = node
        if (listCount == 0) {
            linkedList = tempNode
            listCount += 1
        } else {
            tempNode.front = linkedList
            linkedList?.rear = tempNode
            linkedList = tempNode
            listCount += 1
        }
        hashAddress[key] = tempNode
    }
    fileprivate mutating func delete(node: Node) -> Node? {
        if (linkedList == nil) {
            return nil
        }
        for (key, value) in hashAddress {
            if node.data == value?.data {
                hashAddress[key] = nil
            }
        }
        if (node.front == nil && node.rear == nil) {
            linkedList = nil
        } else if (node.front == nil && node.rear != nil) {
            node.rear?.front = nil
            node.rear = nil
        } else if (node.front != nil && node.rear == nil) {
            linkedList = node.front
            node.front = nil
        } else if (node.front != nil && node.rear != nil) {
            node.front?.rear = node.rear
            node.rear?.front = node.front
            node.rear = nil
            node.front = nil
        }
        listCount -= 1
        return node
    }
    public mutating func setCache(value: Int, for key: Int) {
        if (maxCacheSize <= 0) {
            return
        }
        let tempNode = getNode(data: value)
        if (hashAddress[key] != nil) {
            delete(node: hashAddress[key]!!)
            insert(node: tempNode, key: key)
        } else {
            if (hashAddress.count < maxCacheSize) {
                insert(node: tempNode, key: key)
            } else if (hashAddress.count == maxCacheSize) {
                var lastNode = linkedList
                while lastNode?.front != nil {
                    lastNode = lastNode?.front
                }
                delete(node: lastNode!)
                insert(node: tempNode, key: key)
            }
        }
        printLinkedList()
        print("")
    }
    func printLinkedList() {
        var tempNode = linkedList
        if tempNode == nil {
            print("")
            return
        }
        while tempNode != nil {
            print(tempNode!.data, " ")
            tempNode = tempNode?.front
        }
    }
    public mutating func getCache(key: Int) {
        if(hashAddress[key] == nil) {
            print("no cache")
            return
        }
        if let node = hashAddress[key], let mainNode = node {
            let deletedNode = delete(node: mainNode)
            if let insertNode = deletedNode {
                insert(node: insertNode, key: key)
            }
        }
        printLinkedList()
        print("")
    }
}

func lruCache(cacheSize: Int) -> DoublyLinkedList {
    return DoublyLinkedList(listData: [], cacheSize: cacheSize)
}

var lcache = lruCache(cacheSize: 4)
lcache.setCache(value: 10, for: 1)
lcache.setCache(value: 20, for: 2)
lcache.setCache(value: 30, for: 3)
lcache.setCache(value: 40, for: 4)
lcache.setCache(value: 50, for: 5)

lcache.getCache(key: 3)
