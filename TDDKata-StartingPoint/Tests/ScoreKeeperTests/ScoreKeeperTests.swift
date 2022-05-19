//
// Created by 游宗諭 on 2022/5/19.
//

import Foundation
import XCTest
final class ScoreKeeper {
    func getScore() -> String {
        "000-000"
    }
}

class ScoreKeeperTests: XCTestCase {
    private let readme = """
    ## Problem
    We need software to deliver the proper data to the scoreboard for a basketball team. Unfortunately the people using our software are not the brightest lights under the sun, so they need six buttons (each team can score either 1, 2 or 3 points with a single shot).

    ## Your Task
    Write a class `ScoreKeeper` which offers following methods:
    ```
    void scoreTeamA1()
    void scoreTeamA2()
    void scoreTeamA3()
    void scoreTeamB1()
    void scoreTeamB2()
    void scoreTeamB3()
    String getScore()
    ```
    ## Rules
    The returned String always has seven characters. An example would be 000:000
    """
    func test() {
        let sut = ScoreKeeper()
        XCTAssertEqual(sut.getScore(), "000-000")
    }
}
