//
// Created by 游宗諭 on 2022/5/19.
//

import Foundation
import XCTest
import ScoreKeeper

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
        sut.scoreTeamA1()
        XCTAssertEqual(sut.getScore(), "001-000")
        sut.scoreTeamA2()
        XCTAssertEqual(sut.getScore(), "003-000")
         sut.scoreTeamA3()
        XCTAssertEqual(sut.getScore(), "006-000")
         sut.scoreTeamA1()
        XCTAssertEqual(sut.getScore(), "007-000")
        sut.scoreTeamA2()
        XCTAssertEqual(sut.getScore(), "009-000")
         sut.scoreTeamA3()
        XCTAssertEqual(sut.getScore(), "012-000")

        sut.scoreTeamB1()
        XCTAssertEqual(sut.getScore(), "012-001")
        sut.scoreTeamB2()
        XCTAssertEqual(sut.getScore(), "012-003")
         sut.scoreTeamB3()
        XCTAssertEqual(sut.getScore(), "012-006")
         sut.scoreTeamB1()
        XCTAssertEqual(sut.getScore(), "012-007")
        sut.scoreTeamB2()
        XCTAssertEqual(sut.getScore(), "012-009")
         sut.scoreTeamB3()
        XCTAssertEqual(sut.getScore(), "012-012")
    }

    func test_ScoreCountShouldAlways7Digits() {
        let sut = ScoreKeeper()
        for _ in 1 ... 999 {
            sut.scoreTeamA1()
        }
        XCTAssertEqual(sut.score, "999-000")
        sut.scoreTeamA1()
        XCTAssertEqual(sut.score, "999-000")
        sut.scoreTeamA2()
        XCTAssertEqual(sut.score, "999-000")
        sut.scoreTeamA3()
        XCTAssertEqual(sut.score, "999-000")
        for _ in 1 ... 999 {
            sut.scoreTeamB1()
        }
         XCTAssertEqual(sut.score, "999-999")
        sut.scoreTeamB1()
        XCTAssertEqual(sut.score, "999-999")
        sut.scoreTeamB2()
        XCTAssertEqual(sut.score, "999-999")
        sut.scoreTeamB3()
        XCTAssertEqual(sut.score, "999-999")
    }
}
