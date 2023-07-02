import Foundation

struct ScheduleResponse: Codable {
    let monday: [Schedule]?
    let tuesday: [Schedule]?
    let wednesday: [Schedule]?
    let thursday: [Schedule]?
    let friday: [Schedule]?
    let saturday: [Schedule]?
    let sunday: [Schedule]?
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
