import UIKit
let exampleJSONData = """
 {
   "fundingSources": [
     {
       "id": "74009ff5-6d22-4f16-9904-3003335a2f21",
       "name": "Monzo",
       "balance": {
         "minor_units": 100,
         "currency": "GBP",
         "exponent": 2
       }
     },
     {
       "id": "7d216a27-c705-4111-813b-20d20231046d",
       "name": "Commonwealth Bank",
       "balance": {
         "minor_units": 100,
         "currency": "AUD",
         "exponent": 2
       }
     },
     {
       "id": "4ab00269-71f6-4a24-bdc1-c284be6f0f72",
       "name": "Revolut"
     }
   ]
 }
""".data(using: .utf8)!

let jsonURL = URL(string: "https://jsonkeeper.com/b/SQGA")!

struct FundingsArray:Decodable{
    let fundingSources:[Funding]
}

struct Funding: Decodable {
    let id:String
    let name:String
    let balance:Balance?
}

struct Balance: Decodable {
    let minor_units:Int
    let currency:String
    let exponent:Int
}

let fundings = try JSONDecoder().decode(FundingsArray.self, from: exampleJSONData)

print("\(fundings)")

URLSession.shared.dataTask(with: jsonURL) { data, result, error in
    
}
