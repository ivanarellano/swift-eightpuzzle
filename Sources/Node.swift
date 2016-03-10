class NodeBacking<Element> {

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

    var prev: Node<Element>? {
        get {
            return prevBacking.data
        }
        set {
            prevBacking = NodeBacking(data: newValue)
        }
    }
}
