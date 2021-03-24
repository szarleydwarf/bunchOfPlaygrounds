import Foundation

let array = [1,5,12,55,100, 100,23, 44, 31, 42, 2345]

func intAsWord (num: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: NSNumber(value: num)) ?? "-1"
}

func inDictionary(array:[Int]) -> [Int:String] {
    var dict = [Int:String]()
    for n in array {
        dict[n] = intAsWord(num: n)
    }
    return dict
}

var dict = inDictionary(array: array)
print("DICT>> \(dict)")

// search for pairs
let keys = dict.keys
array.forEach({n in
    if keys.contains(n) {
        print("\(n) >>\(n+n)")
        let m = n + n
        dict[m] = intAsWord(num: m)
    }
})

















func iterateOverArray(array:[Int], number:Int) {
    for n in array {
        print(intAsWord(num: n))
    }
}

func toDictionary(array:[Int]) -> [Int:String] {
    let dict:[Int:String] = Dictionary( uniqueKeysWithValues: array.map{ ($0, intAsWord(num:$0)) })
    return dict
}



func compareGetSum(array:[Int], dict:[Int:String]) -> Int {
    let keys = dict.keys
    array.forEach({n in
        if keys.contains(n) {
            print("1. >> \(n+n)")
        }
    })
    
//    for n in array {
//        for k in keys {
//            if n == k {
//                print("2. >> \(n+k)")
////                return n+k
//            }
//        }
//    }
    return 0
}

//iterateOverArray(array: array, number: 0)
//let dict = toDictionary(array: array)
//print(compareGetSum(array: array, dict: dict))
