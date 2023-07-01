import Foundation

struct ScheduleResponse: Codable {
    let monday: [Schedule]
}

class Schedule: Codable {
    var time: String
    var duration: Int
    var mark: String
    var name: String
    var type: String
    var teacher: String
    var room: String
}
