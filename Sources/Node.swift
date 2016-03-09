class NodeBacking<Element> {
    
    var data: Element

    init(data: Element) {
        self.data = data
    }
}

struct Node<Element> {
    
    private var dataBacking: NodeBacking<Element>
    private var nextBacking: NodeBacking<Node<Element>?>

    init(data: Element) {
        dataBacking = NodeBacking(data: data)
        nextBacking = NodeBacking(data: nil)
    }
    
    var data: Element {
        /* Use this with Mac OS
        mutating get {
            if !isUniquelyReferencedNonObjC(&dataBacking) {
                dataBacking = NodeBacking(data: dataBacking.data)
            }
             */
        get {
            return dataBacking.data
        }
        set {
            dataBacking.data = data
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
}
