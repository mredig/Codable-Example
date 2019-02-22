import Cocoa

//This is a simple example demonstrating hierarchical data, ignoring CodingKeys (derived from chapter "Archiving" in Swift Design Patterns by Paul Hudson

struct User: Codable {
	var name: String
	var address: Address
	var lastLogin: Date
}

struct Address: Codable {
	var street: String
	var city: String
	var state: String
}

let userAddress = Address(street: "123 No Where", city: "Los Angles", state: "New York")
let userSettings = User(name: "Taylor Swift", address: userAddress, lastLogin: Date(timeIntervalSinceNow: 0))


//JSON
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
let data = try encoder.encode(userSettings)

let str = String(data: data, encoding: .utf8) ?? ""
print(str)


let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let loadedSettings = try decoder.decode(User.self, from: data)
print(loadedSettings)

//PLIST/XML
let plistEncoder = PropertyListEncoder()
plistEncoder.outputFormat = .xml
let plistData = try plistEncoder.encode(userSettings)

let plistStr = String(data: plistData, encoding: .utf8) ?? ""
print(plistStr)

let plistDecoder = PropertyListDecoder()
let loadedFromPlist = try plistDecoder.decode(User.self, from: plistData)
print(loadedFromPlist)
