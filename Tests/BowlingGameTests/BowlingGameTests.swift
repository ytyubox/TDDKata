import XCTest
final class BowlingGame {
    private var rolls:[Int] = []
    func roll(_ int: Int) {rolls.append(int)}
    func score() -> Int { 
        scoreForFrame(11)
     }
    func scoreForFrame(_ frame: Int) -> Int {
        var ball = 0
        var score = 0
        for _ in 1...frame {
            if rolls.count <= ball {break}
            if rolls[ball] == 10 {
                ball += 1
                score += 10 + nextTwoBall(ball)
                continue
            }
            let frameScore = rolls[ball] + rolls[ball+1]
            if frameScore == 10 {
                score += frameScore + nextBall(ball)
            }
            else {
                score += frameScore
            }
            ball += 2
            
        }
        return score
    }
    private func nextTwoBall(_ ball: Int) -> Int{
        rolls[ball+1] + rolls[ball+2]
    }
    private func nextBall(_ ball: Int) -> Int{
        rolls[ball+1] 
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
}