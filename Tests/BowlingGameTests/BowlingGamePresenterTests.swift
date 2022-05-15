import BowlingGame
import XCTest

final class BowlingGamePresenter {
    init(view: BowlingGameView) {
        self.view = view
    }
    let view: BowlingGameView
    func present(_ bowlingGame: BowlingGame) {
        let score = bowlingGame.score()
        view.display( BowlingGameViewState(hdcpScore: score, maxPossible: 300 - score))
    }
}

protocol BowlingGameView {
    func display(_ bowlingGameViewState:BowlingGameViewState) 
}
struct BowlingGameViewState {
    var hdcpScore: Int 
    var maxPossible: Int 
}
class BowlingGameSpy:BowlingGameView {
    private(set) var state: BowlingGameViewState!
    func display(_ bowlingGameViewState: BowlingGameViewState) {
        self.state = bowlingGameViewState
    }
}


final class BowlingGamePresenterTests: XCTestCase {
    func test() throws {
        let spy = BowlingGameSpy()
        let sut = BowlingGamePresenter(view: spy) 
        sut.present(BowlingGame())
        XCTAssertEqual(spy.state.hdcpScore, 0)
        XCTAssertEqual(spy.state.maxPossible, 300)
    }
    func testPerfectGame() throws {
        let spy = BowlingGameSpy()
        let sut = BowlingGamePresenter(view: spy) 
        sut.present(perfectBowlingGame())
        XCTAssertEqual(spy.state.hdcpScore, 300)
        XCTAssertEqual(spy.state.maxPossible, 0)
    }

    func perfectBowlingGame() -> BowlingGame {
        let game = BowlingGame()
        for _ in 0...12 {
            game.roll(10)
        }
        return game
    } 
}