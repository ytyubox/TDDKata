import XCTest
final class BowlingGame {
    private var rolls:[Int] = []
    private var currentFrame = 0
    private var firStThrowInFrame = false
    private let scorer = Scorer()

    func roll(_ pin: Int) {
        scorer.addThrow(pin)
        adjustCurrentFrame(pin)
    }
    func score() -> Int { 
        scoreForFrame(currentFrame)
     }
    func scoreForFrame(_ frame: Int) -> Int {
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
final class BowlingGameTests: XCTestCase {
    private let readme = 
    """
    Bowling Rules
    The game consists of 10 frames. In each frame the player has two rolls to knock down 10 pins. The score for the frame is the total number of pins knocked down, plus bonuses for strikes and spares.

    A spare is when the player knocks down all 10 pins in two rolls. The bonus for that frame is the number of pins knocked down by the next roll.

    A strike is when the player knocks down all 10 pins on his first roll. The frame is then completed with a single roll. The bonus for that frame is the value of the next two rolls.

    In the tenth frame a player who rolls a spare or strike is allowed to roll the extra balls to complete the frame. However no more than three balls can be rolled in tenth frame.
    """
    func testScoreNoMark() throws {
        let sut = BowlingGame()
        sut.roll(4)
        sut.roll(4)
        XCTAssertEqual(sut.scoreForFrame(1), 8)
        XCTAssertEqual(sut.score(), 8)
    }
    func testScoreForFrame() throws {
        let sut = BowlingGame()
        sut.roll(4)
        sut.roll(4)
        sut.roll(5)
        sut.roll(3)
        XCTAssertEqual(sut.scoreForFrame(1), 8)
        XCTAssertEqual(sut.scoreForFrame(2), 16)
        XCTAssertEqual(sut.score(), 16)
    }
    func testSimpleSpare() throws {
        let sut = BowlingGame()
        sut.roll(7)
        sut.roll(3)
        sut.roll(3)
        sut.roll(0)
        XCTAssertEqual(sut.scoreForFrame(1), 13)
        XCTAssertEqual(sut.scoreForFrame(2), 16)
        XCTAssertEqual(sut.score(), 16)

    }
    func testSimpleStrike() throws {
        let sut = BowlingGame()
        sut.roll(10)
        sut.roll(3)
        sut.roll(3)
        XCTAssertEqual(sut.scoreForFrame(1), 16)
        XCTAssertEqual(sut.scoreForFrame(2), 22)
        XCTAssertEqual(sut.score(), 22)
    }
    func testPerfectGame() throws {
        let sut = BowlingGame()
        for _ in 1...12 {sut.roll(10)}
        XCTAssertEqual(sut.score(), 300)
    }
    func testEndWithStrike() throws {
        let sut = BowlingGame()
        for _ in 1...9 {
            sut.roll(0)
            sut.roll(0)
        }
        sut.roll(2)
        sut.roll(8)
        sut.roll(10)
        XCTAssertEqual(sut.score(), 20)
    }
    func testHeartBreak() throws {
        let sut = BowlingGame()
        for _ in 1...11 {
            sut.roll(10)
        }
        sut.roll(9)
        XCTAssertEqual(sut.score(), 299)
    }
    func testTenthFrameSpare() {
        let sut = BowlingGame()
        for _ in 1...9 {
            sut.roll(10)
        }
        sut.roll(9)
        sut.roll(1)
        sut.roll(1)
        XCTAssertEqual(sut.score(), 270)
    }
    func testSampleGame() {
        let sut = BowlingGame() 
        sut.roll(1);
        sut.roll(4);
        sut.roll(4);
        sut.roll(5);
        sut.roll(6);
        sut.roll(4);
        sut.roll(5);
        sut.roll(5);
        sut.roll(10);
        sut.roll(0);
        sut.roll(1);
        sut.roll(7);
        sut.roll(3);
        sut.roll(6);
        sut.roll(4);
        sut.roll(10);
        sut.roll(2);
        sut.roll(8);
        sut.roll(6);
        XCTAssertEqual(133, sut.score()); 
    }
}