//
//  BugSection.swift
//  ScaryBugs
//
//  Created by 洪浩东 on 7/22/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

class BugSection {
    let howScary: ScaryFactor
    var bugs = [ScaryBug]()
    
    init(howScary: ScaryFactor) {
        self.howScary = howScary
    }
}
func ==(lhs: BugSection, rhs: BugSection) -> Bool {
    var isEqual = false
    if (lhs.howScary == rhs.howScary && lhs.bugs.count == rhs.bugs.count) {
        isEqual = true
    }
    return isEqual
}