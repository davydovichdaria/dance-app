import Foundation

struct TrainersResponse: Codable {
    var trainers: [Trainer]
}

struct Trainer: Codable, Hashable {
    
    static func == (lhs: Trainer, rhs: String) -> Bool {
        return lhs.typeOfClass == rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(typeOfClass)
    }
    
    var name: String
    var typeOfClass: String
}
