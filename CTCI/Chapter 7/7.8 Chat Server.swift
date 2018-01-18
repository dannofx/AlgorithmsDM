// Chat Server

import Foundation

class Message {
    let id: Int
    let content: String
    let date: Date
    init(content: String) {
        self.id = 1 // aleatory selection of id insuring unicity
        self.content = content
        self.date = Date()
    }
}

class Conversation {
    private(set) var participants: [User]
    private(set) var messages: [Message]
    let id: Int
    
    init(id: Int) {
        self.id = id
        participants = [User]()
        messages = [Message]()
    }
    
    func addMessage(message: Message) -> Bool {
        // Add a message to the conversation
        return false
    }
    
}

class GroupChat: Conversation {
    func addParticipant(_ participant: User) {
        // Adds a participant
    }
    
    func removeParticipant(_ participant: User) {
        // Removes a participant
    }
}

class PrivateChat: Conversation {
    
    init(user1: User, user2: User) {
        let id = 1 // aleatory selection of id insuring unicity
        super.init(id: id)
    }
    
    func getTheOtherParticipant(_ user: User) -> User {
        // get the other participant of the conversation
        return User(id: 1, accountName: "Example") // It's just a placeholder user
    }
}

enum UserStatusType {
    case offline
    case idle
    case away
    case available
    case busy
}

struct UserStatus {
    var description: String
    var type: UserStatusType
    
    init(type: UserStatusType, description: String) {
        self.type = type
        self.description = description
    }
    
}

class User {
    let id: Int
    let accountName: String
    private(set) var status: UserStatus
    private(set) var privateChats: [Int: PrivateChat]
    private(set) var groupChats: [Int: GroupChat]
    
    init(id: Int, accountName: String) {
        self.id = id
        self.accountName = accountName
        self.status = UserStatus(type: .available, description: "Default")
        self.privateChats = [Int: PrivateChat]()
        self.groupChats = [Int: GroupChat]()
    }
    
    func sendMessage(toUserId id: Int, message: String) {}
    func sendMessage(toGroupId id: Int, message: String) {}
    func addContact(_ user: User) {}
    func receivedAddRequest(_ addRequest: AddRequest) {}
    func sendAddRequest(_ addRequest: AddRequest) {}
    func removeAddrequest(_ addRequest: AddRequest) {}
    func requestAddUser(userId: Int) {}
    func addConversation(privateChat: PrivateChat) {}
    func addConversation(groupChat: GroupChat) {}
    
}

enum AddRequestStatus {
    case Unread
    case Read
    case Accepted
    case Rejected
}

struct AddRequest {
    let fromUser: User
    let toUser: User
    let date: Date
    var status: AddRequestStatus
    
    init(fromUser: User, toUser: User, date: Date, status: AddRequestStatus) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.date = date
        self.status = status
    }
}

class UserManager {
    let userManager: UserManager = {
       return UserManager()
    }()
    
    private var usersById: [Int: User]
    private var usersByAccount: [String: User]
    private var onlineUsers: [Int: User]
    
    private init() {
        self.usersById = [Int: User]()
        self.usersByAccount = [String: User]()
        self.onlineUsers = [Int: User]()
    }
    
    func addUser(fromUser: User, accountName: String) {
        // Adds a new user
    }
    
    func approveAddRequest(_ request: AddRequest) {
        // The add request was accepted
    }
    
    func rejectAddRequest(_ request: AddRequest) {
        // The add request was rejected
    }
    
    func userSignedOn(_ id: Int) {
        // The user signed on
    }
    
    func userSignedOff(_ id: Int) {
        // The userd signed off
    }
    
}
