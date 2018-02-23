// Sparse Similarity

import Foundation

// MARK: - Types definition

typealias DocId = Int
typealias DocSimilarity = (docPair: DocPair, similarity: Double)

// MARK: - Structures

struct DocPair: Hashable {
    let docId1: DocId
    let docId2: DocId
    
    init(docId1: DocId, docId2: DocId) {
        self.docId1 = docId1
        self.docId2 = docId2
    }
    
    static func ==(lhs: DocPair, rhs: DocPair) -> Bool {
        return (lhs.docId1 == rhs.docId1 && lhs.docId2 == rhs.docId2) ||
                (lhs.docId1 == rhs.docId2 && lhs.docId2 == rhs.docId1)
    }
    
    var hashValue: Int {
        return self.docId1.hashValue ^ self.docId2.hashValue
    }
}

struct Document {
    let id: DocId
    let elements: [Int]
    
    init(id: DocId, elements: [Int]) {
        self.id = id
        self.elements = elements
    }
}

// MARK: - Auxiliar methods

fileprivate func createElementsDictionary(documents: [Document]) -> [Int: [DocId]] {
    var elementsDict = [Int: [DocId]]()
    for document in documents {
        for element in document.elements {
            if elementsDict[element] == nil {
                elementsDict[element] = [DocId]()
            }
            elementsDict[element]!.append(document.id)
        }
    }
    return elementsDict
}

fileprivate func incrementIntersection(docId1: DocId, docId2: DocId, intersections: inout [DocPair: Int]) {
    let docPair = DocPair(docId1: docId1, docId2: docId2)
    if let oldValue = intersections[docPair] {
        intersections[docPair] = oldValue + 1
    } else {
        intersections[docPair] = 1
    }
}

fileprivate func computeIntersections(elementsDict: [Int: [DocId]]) -> [DocPair: Int] {
    var intersections = [DocPair: Int]()
    for docIds in elementsDict.values {
        for i in 0..<docIds.count {
            for j in (i + 1)..<docIds.count {
                incrementIntersection(docId1: docIds[i], docId2: docIds[j], intersections: &intersections)
            }
        }
    }
    return intersections
}

// MARK: - Similarity computation

fileprivate func computeSimilarities(intersections: [DocPair: Int], documentsDict: [DocId: Document]) -> [DocSimilarity] {
    var similarities = [DocSimilarity]()
    for (docPair, interValue) in intersections {
        let doc1 = documentsDict[docPair.docId1]
        let doc2 = documentsDict[docPair.docId2]
        let count1 = doc1?.elements.count ?? 0
        let count2 = doc2?.elements.count ?? 0
        let union = Double(count1 + count2 - interValue)
        let simValue = Double(interValue) / union
        let similarity = DocSimilarity(docPair: docPair, similarity: simValue)
        similarities.append(similarity)
    }
    return similarities
}

func computeSimilarity(documents: [Document]) -> [DocSimilarity] {
    let elementsDict = createElementsDictionary(documents: documents)
    let documentsDict = documents.reduce(into: [DocId: Document]()) { $0[$1.id] = $1}
    let intersections = computeIntersections(elementsDict: elementsDict)
    return computeSimilarities(intersections: intersections, documentsDict: documentsDict)
}

// MARK: - Test

let documents = [
    Document(id: 13, elements: [14, 15, 100, 9, 3]),
    Document(id: 16, elements: [32, 1, 9, 3, 5]),
    Document(id: 19, elements: [15, 29, 2, 6, 8, 7]),
    Document(id: 24, elements: [7, 10]),
    ]
let similarities = computeSimilarity(documents: documents)
print("Documents: ")
for document in documents {
    print(document)
}
print("Similarities: ")
for sim in similarities {
    print("DocId1: \(sim.docPair.docId1), DocId2: \(sim.docPair.docId2), Similarity: \(sim.similarity)")
}

