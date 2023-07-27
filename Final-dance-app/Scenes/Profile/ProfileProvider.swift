import Foundation

protocol ProfileProvider {
    func loadClasses() -> [DailyClasses]
    func saveClasses(classes: [DailyClasses])
}

class ProfileProviderImpl: ProfileProvider {
    
    let classesArchiver: ClassesRepository
    
    init(classesArchiver: ClassesRepository) {
        self.classesArchiver = classesArchiver
    }
    
    func loadClasses() -> [DailyClasses] {
        classesArchiver.retrive()
    }
    
    func saveClasses(classes: [DailyClasses]) {
        classesArchiver.save(classes)
    }
}
