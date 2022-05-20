//
// Created by 游宗諭 on 2022/5/19.
//

import Foundation
public final class ScoreKeeper {
    public init() {}
    public var score:String {
        let n1 = String(format: "%03d", min(999,(max(teamAScore, 0))))
        let n2 = String(format: "%03d", min(999,(max(teamBScore, 0))))
        return "\(n1)-\(n2)" 
    }
    var teamAScore = 0
    var teamBScore = 0
    public func getScore() -> String {
        return score
    }

    public func scoreTeamA1() {
        teamAScore += 1
    }
    public func scoreTeamA2() {
        teamAScore += 2
    }
    public func scoreTeamA3() {
        teamAScore += 3
        
    }
    public func scoreTeamB1() {
        teamBScore += 1
       
    }
    public func scoreTeamB2() {
        teamBScore += 2
       
    }
    public func scoreTeamB3() {
        teamBScore += 3
    }
}