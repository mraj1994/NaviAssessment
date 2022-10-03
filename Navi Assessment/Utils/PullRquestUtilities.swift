//
//  PullRquestUtilities.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import UIKit


//Class can used for adding extra utilities
class PRUtils {
    
    func stateBGColour(forState: PullRequestType) -> UIColor {
        switch forState {
        case .closed:
            return UIColor.systemGreen
        case .all:
            return .gray
        }
    }
}
