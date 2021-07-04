
struct A {
    public var a: Int
    public var b: Int
    
    mutating func s() {
        self.a = 5
    }
}
var a = A(a: 1, b: 2)

func samePointer() {

    withUnsafePointer(to: a) {
        print($0)
    }
    withUnsafePointer(to: a) {
        print($0)
    }
}

func differentPointer() {
    withUnsafePointer(to: &a) {
        print($0)
    }
    a.a = 2
    withUnsafePointer(to: a) {
        print($0)
    }
}



