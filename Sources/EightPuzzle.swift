import Glibc

struct EightPuzzle {
   static func manhattan(x1: UInt8, y1: UInt8, x2: UInt8, y2: UInt8) -> UInt8 {
       return abs(x1 - x2) + abs(y1 - y2)
   }
}
