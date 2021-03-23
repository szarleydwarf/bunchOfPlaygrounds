import UIKit

// closure taking and returning params
var su:(Int, Int) -> Int = { x, y in
    return x + y
}
print(su(2, 3))

struct Person {
    let name: String
    let age: Int
}
struct PeopleViewModel {
    var people: [Person]
    
    lazy var oldest: Person? = {
        print("oldest person calculated")
        return people.max(by: { $0.age < $1.age })
    }()
}

var viewModel = PeopleViewModel(people: [
    Person(name: "Antoine", age: 30),
    Person(name: "Jaap", age: 3),
    Person(name: "Lady", age: 3),
    Person(name: "Maaike", age: 27)
])

print(viewModel.oldest)
// Prints: "oldest person calculated"
// Prints: Person(name: "Antoine", age: 30)

viewModel.people.append(Person(name: "Jan", age: 69))
print(viewModel.oldest)
// Prints: Person(name: "Antoine", age: 30)
print(viewModel.people[0...2])

struct Persona {
    let lastName:String
    let firsName:String
}


func checkPassword(_ password: String) throws -> Bool {
    enum PasswordError: Error {
        case obvious
    }
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

print(try checkPassword("password"))

func printPerson (list:[Persona]) -> String{
//    let r = list.reduce([String](), { $0.firstName + $0.lastName } )
//    return r
//    let people = list.reduce([String](), {($0.firstName + $0.lastName)})
//    return people
    return ""
}

var str = "LOL"
print(str)
let color = Set(["red", "green", "blue", "red", "blue"])
print(color)
var name = (first: "Taylor", last: "Swift", age: 25, balance: 3_000_120.66)
print(name.2)
print(name.balance)

let c = 1...7
outer: for n in c {
    print("N > \(n)")
    for i in c {
        let m = n * i
        print("\(n) * \(i) = \(m)")
        if m >= 20 {
            print("Breaking out")
            break
        }
    }
    if n % 2 == 1 {
        print("SKIPPING")
        continue
    }
}
