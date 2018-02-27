//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// File System

import Foundation

class Entry {
    var parent: Directory?
    var name: String
    let created: Date
    var lastUpdate: Date
    var lastAccess: Date
    
    init(name: String, parent: Directory?) {
        self.name = name
        self.parent = parent
        self.created = Date()
        self.lastUpdate = Date()
        self.lastAccess = Date()
    }
    
    func delete() -> Bool {
        if let parent = self.parent{
            return parent.deleteEntry(self)
        } else {
            return false
        }
    }
    
    var fullPath: String {
        if let parent = self.parent {
            return parent.fullPath + "/" + self.name
        } else {
            return self.name
        }
    }
    
    var size: Int {
        return 0
    }
}

// MARK: File
class File: Entry {
    var content: String
    var fileSize: Int
    
    init(name: String, parent: Directory, content: String, size: Int) {
        self.content = content
        self.fileSize = size
        super.init(name: name, parent: parent)
        self.parent?.addEntry(self)
    }
    
    override var size: Int {
        return self.fileSize
    }
}

// MARK: Directory
class Directory: Entry {
    var entries: [Entry]
    
    override init(name: String, parent: Directory? = nil) {
        entries = [Entry]()
        super.init(name: name, parent: parent)
    }
    
    func addEntry(_ entry: Entry) {
        self.entries.append(entry)
        entry.parent = self
    }
    
    func deleteEntry(_ entry: Entry) -> Bool{
        if let index = self.entries.index(where: { $0 === entry }) {
            self.entries.remove(at: index)
            return true
        }
        return false
    }
    
    override var size: Int {
        var size = 0
        for entry in self.entries {
            size += entry.size
        }
        return size
    }
    
    var numberOfFiles: Int {
        var number = 0
        for entry in self.entries {
            if let directory = entry as? Directory {
                number += directory.numberOfFiles
            } else {
                number += 1
            }
        }
        return number
    }
}


