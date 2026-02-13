import Foundation
internal import Combine

enum AnimalType: String, CaseIterable, Codable {
    case chickens = "Chickens"
    case pigs = "Pigs"
    case rams = "Rams"
    case cows = "Cows"
    case rabbits = "Rabbits"
    case sheep = "Sheep"
    case other = "Other"
    
    var imageName: String {
        switch self {
        case .chickens: return "chickenImg"
        case .pigs: return "pigImg"
        case .rams: return "ramImg"
        case .cows: return "cowImg"
        case .rabbits: return "rabbitImg"
        case .sheep: return "sheepImg"
        case .other: return "chickenImg"
        }
    }
}

enum AnimalSex: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
}

enum AnimalStatus: String, CaseIterable, Codable {
    case inBreeding = "In breeding"
    case onFeed = "On feed"
    case forSale = "For sale"
    
    var color: String {
        switch self {
        case .inBreeding: return "green"
        case .onFeed: return "blue"
        case .forSale: return "red"
        }
    }
}

struct Animal: Identifiable, Codable {
    let id: UUID
    var type: AnimalType
    var quantity: Int
    var breed: String
    var sex: AnimalSex
    var status: AnimalStatus
    
    init(id: UUID = UUID(), type: AnimalType, quantity: Int, breed: String, sex: AnimalSex, status: AnimalStatus) {
        self.id = id
        self.type = type
        self.quantity = quantity
        self.breed = breed
        self.sex = sex
        self.status = status
    }
}

class AnimalStore: ObservableObject {
    @Published var animals: [Animal] = []
    
    static let shared = AnimalStore()
    
    func addAnimal(_ animal: Animal) {
        animals.append(animal)
    }
    
    func deleteAnimal(_ animal: Animal) {
        animals.removeAll { $0.id == animal.id }
    }
}
