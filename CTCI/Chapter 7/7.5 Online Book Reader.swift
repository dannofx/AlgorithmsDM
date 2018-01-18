// Online Book Reader

import Foundation

class Display {
    var activeBook: Book?
    var activeUser: User?
    var pageNumber: Int
    
    init() {
        self.pageNumber = 0
    }
    
    func display(user: User) {
        // Display a user
        self.activeUser = user
        self.refreshUsername()
    }
    
    func display(book: Book) {
        // Display a book
        self.activeBook = book
        self.pageNumber = 0
        self.refreshTitle()
        self.refreshDetails()
        self.refreshDetails()
    }
    
    func clearUser() {
        // Clears the current user
        self.activeUser = nil
        self.refreshUsername()
    }
    
    func clearBook() {
        // Clears the current book
        self.activeBook = nil
        self.pageNumber = 0
        self.refreshTitle()
        self.refreshDetails()
        self.refreshDetails()
    }
    
    func turnPageForward() {
        self.pageNumber += 1
        self.refreshPage()
    }
    
    func turnPageBackward() {
        self.pageNumber -= 1
        self.refreshPage()
    }
    
    func refreshUsername() {
        // Refresh the username display
    }
    
    func refreshTitle() {
        // Updates the title
    }
    
    func refreshPage() {
        // Refresh the page
    }
    
    func refreshDetails() {
        // Refresh the details of the book
    }
    
}

class Book {
    let id: Int
    let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

class User {
    let id: Int
    let name: String
    private(set) var registerDate: Date
    private(set) var renewalDate: Date
    
    init(id: Int, name: String, registerDate: Date) {
        self.id = id
        self.name = name
        self.registerDate = registerDate
        self.renewalDate = registerDate.addingTimeInterval(30000)
    }
    
    func renewMembership() {
        // Renews the membership of the user
    }
    
    
    
}

class UserManager {
    private(set) var users: [Int: User]
    
    init() {
        self.users = [Int: User]()
    }
    
    func addUser(id: Int, name: String) -> User {
        let user = User(id: id, name: name, registerDate: Date())
        self.users[id] = user
        return user
    }
    
    func removeUser(_ user: User) -> Bool {
        if self.users[user.id] === user {
            self.users[user.id] = nil
            return true
        } else {
            return false
        }
    }
    
    func removeUser(withId id: Int) -> User? {
        if let user = self.users[id] {
            self.users[id] = nil
            return user
        } else {
            return nil
        }
    }
    
    func findUser(withId id: Int) -> User? {
        return self.users[id]
    }
}

class Library {
    private(set) var books: [Int: Book]
    
    init() {
        self.books = [Int: Book]()
    }
    
    func addBook(id: Int, title: String) -> Book {
        let book = Book(id: id, title: title)
        self.books[id] = book
        return book
    }
    
    func removeBook(_ book: Book) -> Bool {
        if self.books[book.id] === book {
            self.books[book.id] = nil
            return true
        } else {
            return false
        }
    }
    
    func removeBook(withId id: Int) -> Book? {
        if let book = self.books[id] {
            self.books[id] = nil
            return book
        } else {
            return nil
        }
    }
    
    func findBook(withId id: Int) -> Book? {
        return self.books[id]
    }
    
}

class OnlineReaderSystem {
    let library: Library
    let userManager: UserManager
    let display: Display
    
    init() {
        self.library = Library()
        self.userManager = UserManager()
        self.display = Display()
    }
    
    var activeBook: Book? {
        didSet {
            if let activeBook = activeBook {
                self.display.display(book: activeBook)
            } else {
                self.display.clearBook()
            }
        }
    }
    
    var activeUser: User? {
        didSet {
            if let activeUser = activeUser {
                self.display.display(user: activeUser)
            } else {
                self.display.clearUser()
            }
        }
    }
    
}
