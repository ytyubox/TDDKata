import XCTest
final class BowlingGame {
    private var _score = 0
    private var rolls:[Int] = []
    func roll(_ int: Int) {rolls.append(int)}
    func score() -> Int {
        rolls.reduce(0, +)
    }
    func testScoreForFrame(_ frame: Int) -> Int {
        var ball = 0
        var score = 0
        for i in 1...frame {
            score += rolls[ball] + rolls[ball+1]
            ball += 2
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
        sut.roll(9)
        XCTAssertEqual(sut.score(), 13)
    }
    func testScoreForFrame() throws {
        let sut = BowlingGame()
        sut.roll(4)
        sut.roll(9)
        sut.roll(5)
        sut.roll(3)
        XCTAssertEqual(sut.testScoreForFrame(1), 13)
        XCTAssertEqual(sut.testScoreForFrame(2), 21)
    }
}