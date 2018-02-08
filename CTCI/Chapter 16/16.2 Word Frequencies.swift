// Word Frequencies

import Foundation

//func createBook(_ n: Int) -> [String] {
//    let maxWordLen = 3
//    let aValue = Int(("a" as UnicodeScalar).value)
//    var book = [String]()
//    for _ in 0..<n {
//        let wordLen = (Int(arc4random()) % maxWordLen) + 1
//        var word = [Character]()
//        for _ in 0..<wordLen {
//            let value = aValue + Int(arc4random()) % 3
//            word.append(Character(UnicodeScalar(value)!))
//        }
//        book.append(String(word))
//    }
//    return book
//}

func createDictionary(_ book: [String]) -> [String: Int] {
    var dictionary = [String: Int]()
    for word in book {
        let lcWord = word.lowercased()
        dictionary[lcWord] = (dictionary[lcWord] ?? 0) + 1
    }
    return dictionary
}

func getFrequency(dictionary: [String: Int], query: String) -> Int{
    let lcQuery = query.lowercased()
    return dictionary[lcQuery] ?? 0
}

let book = ["c", "aaa", "ac", "a", "aa", "c", "cba", "cc", "a", "cac", "ac", "cbb", "c", "cb", "ba", "bba", "bbc", "ab", "b", "b", "abc", "c", "cc", "cb", "aaa", "a", "aca", "aab", "bb", "cac"]
print("Book: \(book)")
var queries = ["aab", "aaa", "c", "z"]
let dictionary = createDictionary(book)
for query in queries {
    let frequency = getFrequency(dictionary: dictionary, query: query)
    print("Coincidences for word \"\(query)\": \(frequency)")
}


