import Foundation

class User {

    var name: String
    var image: String
    var leftClasses: String
    var login: String
    var password: String
    
    init(name: String = "Daria Davydovich", image: String = "Daria Davydovich", leftClasses: String = "6", login: String = "test", password: String = "test") {
        self.name = name
        self.image = image
        self.leftClasses = leftClasses
        self.login = login
        self.password = password
    }
}

class UserService {
    
    private var testUser = User()
    
    var user: [User]
    
    init() {
        self.user = [testUser]
    }
    
    func fetchUser() -> User{
        return self.user[0]
    }
}
