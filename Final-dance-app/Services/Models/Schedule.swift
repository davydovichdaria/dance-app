import Foundation

struct ScheduleResponse: Codable {
    var schedule: [Schedule]
}

class Schedule: Codable, Hashable{
    
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.time == rhs.time && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
        hasher.combine(name)
    }
    
    var time: String
    var duration: Int
    var mark: String
    var name: String
    var type: String
    var teacher: String
    var room: String
}

class DailyClasses: Codable {
    var lesson: Schedule
    var day: String
    var count: Int = 0
    
    init(lesson: Schedule, day: String) {
        self.lesson = lesson
        self.day = day
    }
}
