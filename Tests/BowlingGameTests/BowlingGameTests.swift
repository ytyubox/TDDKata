import XCTest
final class BowlingGame {
    private var _score = 0
    private var rolls:[Int] = []
    func roll(_ int: Int) {rolls.append(int)}
    func score() -> Int {
        rolls.reduce(0, +)
    }
    func scoreForFrame(_ frame: Int) -> Int {
        var ball = 0
        var score = 0
        for i in 1...frame {
            if rolls[ball] == 10 {
                ball += 1
                score += 10 + rolls[ball] + rolls[ball+1]
                continue
            }
            let frameScore = rolls[ball] + rolls[ball+1]
            ball += 2
            score += frameScore
            if frameScore == 10 {
                 score += rolls[ball]
            }
        }
        return score
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
    }
    func testSimpleSpare() throws {
        let sut = BowlingGame()
        sut.roll(7)
        sut.roll(3)
        sut.roll(3)
        XCTAssertEqual(sut.scoreForFrame(1), 13)
    }
    func testSimpleStrike() throws {
        let sut = BowlingGame()
        sut.roll(10)
        sut.roll(3)
        sut.roll(3)
        XCTAssertEqual(sut.scoreForFrame(1), 16)
    }
}