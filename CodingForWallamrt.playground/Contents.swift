import Foundation

let array = [1,5,12,55,100,23]

func iterateOverArray(array:[Int], number:Int) {
    for n in array {
        print(intAsWord(num: n))
    }
}

func toDictionary(array:[Int]) {
    let dic = array.map{ ($0, intAsWord(num:$0)) }
    print("DIC >> \(dic)")
}

func intAsWord (num: Int) -> String {
    let numberValue = NSNumber(value: num)
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: numberValue) ?? "-1"
}

iterateOverArray(array: array, number: 0)
toDictionary(array: array)
