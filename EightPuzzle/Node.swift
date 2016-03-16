/* https://github.com/JadenGeller/Linky/blob/master/Sources/Node.swift */

class NodeBacking<Element>: Comparable {
    
    var data: Element
    
    init(data: Element) {
        self.data = data
    }
}

struct Node<Element> {
    
    private var dataBacking: NodeBacking<Element>
    private var nextBacking: NodeBacking<Node<Element>?>
    private var prevBacking: NodeBacking<Node<Element>?>
    
    init(data: Element) {
        self.init(
            data: data,
            next: nil,
            prev: nil
        )
    }
    
    init(data: Element, prev: Node<Element>?) {
        self.init(
            data: data,
            next: nil,
            prev: prev
        )
    }
    
    init(data: Element, next: Node<Element>?, prev: Node<Element>?) {
        dataBacking = NodeBacking(data: data)
        nextBacking = NodeBacking(data: next)
        prevBacking = NodeBacking(data: prev)
    }
    
    mutating private func setValueWithCopy(data: Element){
        if !isUniquelyReferencedNonObjC(&dataBacking) {
            dataBacking = NodeBacking(data: data)
        }
        else {
            dataBacking.data = data
        }
    }
    
    var data: Element {
        get {
            return dataBacking.data
        }
        set {
            setValueWithCopy(newValue)
        }
    }
    
    var next: Node<Element>? {
        get {
            return nextBacking.data
        }
        set {
            nextBacking = NodeBacking(data: newValue)
        }
    }
    
    var prev: Node<Element>? {
        get {
            return prevBacking.data
        }
        set {
            prevBacking = NodeBacking(data: newValue)
        }
    }
}

func <<Element>(lhs: NodeBacking<Element>, rhs: NodeBacking<Element>) -> Bool {
    return lhs < rhs
}

func ==<Element>(lhs: NodeBacking<Element>, rhs: NodeBacking<Element>) -> Bool {
    return lhs == rhs
}