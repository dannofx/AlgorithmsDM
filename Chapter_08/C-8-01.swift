// Chapter 8, Challenge 8-1

struct Cell {
    var lastIndex: Int
    var parent: Int
    
    init() {
        self.lastIndex = -1
        self.parent = -1
    }
}

var elephants = [(weight: Int, iq: Int, index: Int)]()
var index = 0
elephants.append((6008, 1300, index))
index += 1
elephants.append((6000, 2100, index))
index += 1
elephants.append((500, 2000, index))
index += 1
elephants.append((1000, 4000, index))
index += 1
elephants.append((1100, 3000, index))
index += 1
elephants.append((6000, 2000, index))
index += 1
elephants.append((8000, 1400, index))
index += 1
elephants.append((6000, 1200, index))
index += 1
elephants.append((2000, 1900, index))
index += 1

func contradict(elephants: inout [(weight: Int, iq: Int, index: Int)]) -> (matrix: [[Cell]], size: Int, i: Int, j: Int){
    elephants.append((Int.max, Int.max, Int.max - 1))
    elephants.sort { $0.weight > $1.weight || ( $0.weight == $1.weight && $0.iq < $1.iq )}
    for ele in elephants {
        print("w: \(ele.0) iq: \(ele.1) i: \((ele.2) + 1) ")
    }
    var m = [[Cell]].init(repeating: [Cell].init(repeating: Cell.init(), count: elephants.count), count: elephants.count)
    var maxSequence = (chain: 0, i: -1, j: -1)
    for i in 1..<elephants.count {
        var chain = 0
        for j in i..<elephants.count {
            let lastIndex = m[i][j - 1].lastIndex
            if lastIndex == -1 {
                m[i][j].parent = j - 1
                m[i][j].lastIndex = j
                chain += 1
            } else {
                let lastElephant = elephants[lastIndex]
                let elephant = elephants[j]
                var notRepeated = elephant.weight != elephants[j - 1].weight
                if j < elephants.count - 1 {
                    notRepeated = notRepeated && elephant.weight != elephants[j + 1].weight
                }
                if elephant.iq > lastElephant.iq &&
                    elephant.weight < lastElephant.weight &&
                    notRepeated{
                    m[i][j].lastIndex = j
                    m[i][j].parent = lastIndex
                    chain += 1
                } else {
                    m[i][j].lastIndex = lastIndex
                }
            }
        }
        if maxSequence.chain < chain {
            maxSequence.chain = chain
            maxSequence.i = i
            maxSequence.j = m[i][m[i].count - 1].lastIndex
        }
    }
    return (m, maxSequence.chain, maxSequence.i, maxSequence.j)
}

func printSequence(elephants: [(weight: Int, iq: Int, index: Int)], matrix: [[Cell]], size: Int, i: Int, j: Int) {
    var cell = matrix[i][j]
    while cell.parent != -1 {
        let elephant = elephants[cell.lastIndex]
        print("Index: \(elephant.index + 1), w: \(elephant.weight), iq: \(elephant.iq)")
        cell = matrix[i][cell.parent]
    }
}

let result = contradict(elephants: &elephants)
print("Size: \(result.size)")
print("Sequence: ")
printSequence(elephants: elephants, matrix: result.matrix, size: result.size, i: result.i, j: result.j)
