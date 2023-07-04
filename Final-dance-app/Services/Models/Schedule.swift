import Foundation

struct ScheduleResponse: Codable {
    var schedule: [Schedule]
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
