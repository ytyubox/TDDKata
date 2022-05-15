public final class BowlingGame {
    public init() {}
    private var rolls:[Int] = []
    private var currentFrame = 0
    private var firStThrowInFrame = false
    private let scorer = Scorer()

    public func roll(_ pin: Int) {
        scorer.addThrow(pin)
        adjustCurrentFrame(pin)
    }
    public func score() -> Int { 
        scoreForFrame(currentFrame)
     }
    public func scoreForFrame(_ frame: Int) -> Int {
        scorer.scoreForFrame(frame)
    }
    private func adjustCurrentFrame(_ pin: Int) {
        if firStThrowInFrame == true, adjustFrameForStrike(pin) == false {
            firStThrowInFrame = false
        } else {
            firStThrowInFrame = true
            advanceFrame()
        }
    }
    private func adjustFrameForStrike(_ pin: Int) -> Bool {
        if pin == 10 {
            advanceFrame()
            return true
        } else {
            return false
        }
    }
    private func advanceFrame() {
        currentFrame = min(10, currentFrame + 1)
    }
    private final class Scorer {
        private var rolls: [Int] = Array(repeating: 0, count: 21)
        private var currentThrows = 0
        private var ball = 0
        func addThrow(_ pins: Int) {
            rolls[currentThrows] = pins
            currentThrows += 1
        }
        func scoreForFrame(_ theFrame: Int) -> Int {
            ball = 0
            var score = 0
            for _ in 0..<theFrame {
                if strike() {
                    score += 10 + nextTwoBall()
                } else if spare() {
                    score += 10 + nextBall()
                } else {
                    score += twoBallInFrame()
                }
            }
            return score
        }
        private func strike() -> Bool {
            if rolls[ball] == 10 {
                ball += 1
                return true
            }else {
                return false
            }
        }
        private  func spare() -> Bool {
            if rolls[ball] + rolls[ball+1] == 10 {
                ball += 2
                return true
            }else {
                return false
            }
        }
        private func nextTwoBall() -> Int{
            return rolls[ball] + rolls[ball+1]
        }
        private func nextBall() -> Int{
            return rolls[ball] 
        }
        private func twoBallInFrame() -> Int {
            let score = rolls[ball] + rolls[ball + 1]
            ball += 2
            return score
        }
    }
}