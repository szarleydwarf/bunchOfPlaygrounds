import Foundation
/*
 NETWORK STATUS CODES
 100 - information
 200 - everything is ok
 300 - Redirection - file was moved to other place
 400 - client side error
 500 - server side error
 
 JSON:
 Can either be a dictionary or an array
 dictionary will have string keys, and the values will be one of the following:
 1. Numbers
 2. String
 3. Bool
 4. JSON Object
 5. Null
 
 Network requests
 
 GET - gets information
 POST - Creating a new object
 PATCH - Update an object
 PUT - relatively similar to POST
 DELETE - Deletes the object
 
 CRUD
 C - create
 R - read
 U - update
 D - delete
 */

    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/50") else { return }
    print("About to do a network call")
    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//      guard let data = data,
//        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
//      let pokemon = Pokemon(json: jsonObject)
//      print(pokemon)
      guard let data = data else { return }
      let pokemon = try? JSONDecoder().decode(CodablePokemon.self, from: data)
      print(pokemon)
    }.resume()


struct Pokemon {
  let name: String
//  let imageURLString: String
  
  init?(json: [String: Any]) {
    guard let name = json["name"] as? String/*,
      let spritesDictionary = json["sprites"] as? [String: Any],
      let frontSpriteImageURL = spritesDictionary["front_default"] as? String*/ else { return nil }
//    let otherFront = (json["sprites"] as? [String: Any])?["front_default"] as? String
    self.name = name
//    self.imageURLString = frontSpriteImageURL
  }
}

struct CodablePokemon: Decodable {
  let name: String
  let baseExperience: Int
  let imageURL: URL
  let abilities: [Ability]
  
  enum CodingKeys: String, CodingKey {
    case name
    case baseExperience = "base_experience"
    case sprites
    case abilities
  }
  
  enum SpritesCodingKeys: String, CodingKey {
    case frontImageURL = "front_default"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let spritesContainer = try container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
    self.name = try container.decode(String.self, forKey: .name)
    self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
    self.imageURL = try spritesContainer.decode(URL.self, forKey: .frontImageURL)
    self.abilities = try container.decode([Ability].self, forKey: .abilities)
  }
}

struct Ability: Decodable {
  let isHidden: Bool
  let ability: AbilityContainer
  
  enum CodingKeys: String, CodingKey {
    case isHidden = "is_hidden"
    case ability
  }
}

struct AbilityContainer: Decodable {
  let name: String
}
