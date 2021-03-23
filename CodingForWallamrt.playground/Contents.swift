import Foundation

let array = [1,5,12,55,100,23]

func iterateOverArray(array:[Int], number:Int) {
    for n in array {
        print(intAsWord(num: n))
    }
}

func toDictionary(array:[Int]) -> [Int:String] {
    let dict:[Int:String] = Dictionary( uniqueKeysWithValues: array.map{ ($0, intAsWord(num:$0)) })
    return dict
}

func intAsWord (num: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: NSNumber(value: num)) ?? "-1"
}

func compareGetSum(array:[Int], dict:[Int:String]) -> Int {
    let keys = dict.keys
    for n in array {
        for k in keys {
            if n == k {
                print(n+k)
//                return n+k
            }
        }
    }
    return 0
}

iterateOverArray(array: array, number: 0)
let dict = toDictionary(array: array)
print(compareGetSum(array: array, dict: dict))
