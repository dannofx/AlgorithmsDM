// Basketball

import Foundation

enum Game {
    case onlyOneShot
    case twoOfThreeShots
    
    var name: String {
        switch self {
        case .onlyOneShot:
            return "Make one shot and wins"
        default:
            return "Make at least two of three shots and wins"
        }
    }
}

func calculateBetterGame(shotOdds: Double) -> Game{
    // ss: Sucessful shot
    // fs: Failed shot
    // p: Probability to make a shot
    //Probability to win with the sencond game:
    // ss,ss,fs + ss,fs,ss + fs,ss,ss + ss,ss,ss
    // p*p*(1-p) + p*p*(1-p) + p*p*(1-p) + p*p*P
    // p^2*(3-2p)
    // When will be more convenient choose the second game?
    // When this happens:
    // p < p^2*(3-2p)
    // This also can be expressed as:
    // 0 < -2*p^2 + 3p - 1
    // We can solve the equation to get the range
    // where the the result is superior to 0
    // And it will be 0.5 and 1.0 for the values of p.
    // So, any probability between 0.5 and 1.0 (non inclusive)
    // will give us a better chance with the second game
    return 0.5 < shotOdds && shotOdds < 1.0 ? .twoOfThreeShots : .onlyOneShot
    
}

let shotOdds = 0.7
let game = calculateBetterGame(shotOdds: shotOdds)
print("Better game with \(shotOdds) probability of make a shot:")
print("A:\(game.name)")

