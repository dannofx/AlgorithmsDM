import Foundation

// You have an scientific article you want to publish, you can just send
// this article to one journal and you want to send it to the best.
//
// A way to know which one is the best is to know the reference rank 
//for that journal, a reference rank is the number of references that the 
//articles belonging to the journal have received from articles in other 
//journals.
//
// You will receive a hashmap with the name of a journal as a key, 
// and the value will be an array with all the articles published 
// by the journal. You will also receive another hashmap with the name 
// of an article as a key and the value will be a list of names of other
// articles tha are referenced in the article related to the key.



func createOwnership(journals: [String: [String]]) -> [String: String] {
  var ownership = [String: String]()
  for (journal, articles) in journals {
    for article in articles {
      ownership[article] = journal
    }
  }
  return ownership
}

func createReferences(articles: [String: [String]], ownership: [String: String]) -> [String: Int] {
  var journalReferences = [String: Int]()
  for (article, references) in articles {
    for reference in references {
      let journal = ownership[reference]!
      if ownership[article] == journal {
        continue
      }
      if journalReferences[journal] == nil {
        journalReferences[journal] = 0
      }
      journalReferences[journal] = journalReferences[journal]! + 1
    }
  }
  return journalReferences
}

func findBestJournal(journals: [String: [String]], articles: [String: [String]]) -> String? {
  let ownership = createOwnership(journals: journals)
  let journalReferences = createReferences(articles: articles, ownership: ownership)
  var bestJournal: String? = nil
  var maxCount = 0
  for (journal, count) in journalReferences {
    if count >= maxCount {
      bestJournal = journal
      maxCount = count
    }
  }
  return bestJournal
}

let journals = ["A": ["A1", "A2", "A3"],
                "B": ["B1", "B2"],
                "C": ["C1"]]

let articles = ["A1": ["A1", "A2", "A3", "C1"],
                "A2": ["A1", "C1"],
                "A3": ["A2", "C1"],
                "B1": ["B2", "A1"],
                "B2": ["C1"],
                "C1": ["B1"]
               ]

if let bestJournal = findBestJournal(journals: journals, articles: articles) {
  print(bestJournal)
} else {
  print("No one")
}