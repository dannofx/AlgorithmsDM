// Chapter 8, Exercise 8-6

var coins = [50, 25, 10, 1]
let n = 59
var solution = [Int](repeating: Int.max - 1, count: n + 1)
var denom = [Int](repeating: 0, count: n + 1)

solution[0] = 0
for i in 1..<solution.count {
    for j in 0..<coins.count {
        if i >= coins[j] {
            let p = solution[i - coins[j]] + 1
            if p < solution[i] {
                solution[i] = p
                denom[i] = coins[j]
            }
        }
    }

}

func printSolution() {
    var i = n
    while i > 0 {
        let coinValue = denom[i]
        print(coinValue)
        i = i - coinValue
    }
}
print("Coins used to change \(n) with set \(coins): ")
printSolution()
