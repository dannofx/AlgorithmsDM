// XML Encoding

import Foundation

let END = 0

// MARK: - Keys mapping

class TagMap {
    private var textTagMap: [String: Int]
    private var intTagMap: [Int: String]
    
    init() {
        self.textTagMap = [String: Int]()
        self.intTagMap = [Int: String]()
    }
    
    subscript(key: String) -> Int? {
        get {
            return self.textTagMap[key]
        }
        set(newValue) {
            if let newValue = newValue {
                self.intTagMap[newValue] = key
            } else if let oldValue = self.textTagMap[key] {
                self.intTagMap[oldValue] = nil
            }
            self.textTagMap[key] = newValue
        }
    }
    
    subscript(key: Int) -> String? {
        get {
            return self.intTagMap[key]
        }
        set(newValue) {
            if let newValue = newValue{
                self.textTagMap[newValue] = key
            } else if let oldValue = self.intTagMap[key] {
                self.textTagMap[oldValue] = nil
            }
            self.intTagMap[key] = newValue
        }
    }
}

// MARK: - Elment/Node class

class Element {
    let tag: Int
    var attributes: [Attribute]
    let value: String?
    private(set) var children: [Element]
    unowned let tagMap: TagMap
    
    init(value: String?, textTag: String, tagMap: TagMap) {
        self.value = value
        self.attributes = [Attribute]()
        self.children = [Element]()
        self.tagMap = tagMap
        guard let tag = self.tagMap[textTag] else{
            preconditionFailure()
        }
        self.tag = tag
    }
    
    convenience init(textTag: String, tagMap: TagMap) {
        self.init(value: nil, textTag: textTag, tagMap: tagMap)
    }
    
    func appendChild(_ element: Element) {
        precondition(self.value == nil)
        self.children.append(element)
    }
}

// MARK: - Attribute's structure

struct Attribute {
    let tag: Int
    let value: String
    unowned let tagMap: TagMap
    
    var textTag: String {
        guard let textTag = tagMap[self.tag] else {
            preconditionFailure()
        }
        return textTag
    }
    
    init(textTag: String, value: String, tagMap: TagMap) {
        self.value = value
        self.tagMap = tagMap
        guard let tag = tagMap[textTag] else{
            preconditionFailure()
        }
        self.tag = tag
    }
}

// MARK: - Encoder (public interface)

class ElementEncoder {
    private(set) var encodedText: String
    
    init() {
        self.encodedText = ""
    }
    
    func encode(_ element: Element) -> String {
        self.encodedText = ""
        self.encode(root: element)
        return self.encodedText
    }
}

// MARK: - Encoder private methods

private extension ElementEncoder {
    
    func encode(value: String) {
        self.encodedText.append(value)
        self.encodedText.append(" ")
    }
    
    func encode(value: Int) {
        self.encode(value: "\(value)")
    }
    
    func encode(root: Element) {
        self.encode(value: root.tag)
        for attribute in root.attributes {
            self.encode(value: attribute.tag)
            self.encode(value: attribute.value)
        }
        self.encode(value: END)
        if let value = root.value {
            self.encode(value: value)
        } else {
            for child in root.children {
                self.encode(root: child)
            }
        }
        self.encode(value: END)
    }
}

// MARK: - Test

var tagMap = TagMap()
tagMap["family"] = 1
tagMap["person"] = 2
tagMap["firstName"] = 3
tagMap["lastName"] = 4
tagMap["state"] = 5

var root = Element(textTag: "family", tagMap: tagMap)
let lastNameAtr = Attribute(textTag: "lastName", value: "McDowell", tagMap: tagMap)
let stateAttr = Attribute(textTag: "state", value: "CA", tagMap: tagMap)
root.attributes.append(lastNameAtr)
root.attributes.append(stateAttr)
var child = Element(value: "Some message", textTag: "person", tagMap: tagMap)
let firstNameAttr = Attribute(textTag: "firstName", value: "Gayle", tagMap: tagMap)
child.attributes.append(firstNameAttr)
root.appendChild(child)

let encoder = ElementEncoder()
let encodedText = encoder.encode(root)
print("Encoded text: \(encodedText)")
