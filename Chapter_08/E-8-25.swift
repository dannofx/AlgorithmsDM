// Chapter 8, Exercise 8-25

let input = [0,1,5,-10,6,2,-3,2,-10,5,2]

func maxSum(input: [Int]) -> Int {
    var m = [[Int]].init(repeating: [Int].init(repeating: 0, count: input.count), count: input.count)
    m[0][0] = input[0]
    for i in 1..<input.count {
        m[i][0] = input[i] + input[i - 1]
    }
    var max = 0
    for i in 0..<input.count {
        for j in i..<input.count {
            var currentSum = 0
            if i == j {
                m[i][j] = input[i]
            } else {
                m[i][j] = m[i][j - 1] + input[j]
            }
            currentSum = m[i][j]
            if max < currentSum {
                max = currentSum
            }
        }
    }
    return max
}

let max = maxSum(input: input)
print("Max sum: \(max)")
