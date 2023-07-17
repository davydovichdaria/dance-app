import Foundation

protocol ClassesRepository {
    func save(_ classes: [DailyClasses])
    func retrive() -> [DailyClasses]
}

final class ClassesRepositoryImpl: ClassesRepository {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "SignUpClasses"
    
    //MARK: - Public
    func save(_ classes: [DailyClasses]) {
        //Array<Schedule> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        
        do {
            let data = try encoder.encode(classes)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrive() -> [DailyClasses] {
        //Data -> Array<Product>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let classes = try decoder.decode(Array<DailyClasses>.self, from: data)
            return classes
        } catch {
            print(error)
        }
        return []
    }
    
    
}
