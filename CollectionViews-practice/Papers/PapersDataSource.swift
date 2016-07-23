//
//  PapersDataSource.swift
//  Wallpapers
//
/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/


import UIKit

class PapersDataSource {
  
  private var papers: [Paper] = []
  private var immutablePapers: [Paper] = []
  private var sections: [String] = []
  
  var count: Int {
    return papers.count
  }
  
  var numberOfSections: Int {
    return sections.count
  }
  
  // MARK: Public
  
  init() {
    papers = loadPapersFromDisk()
    immutablePapers = papers
  }
  
  func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath]) {
    var indexes: [Int] = []
    for indexPath in indexPaths {
      indexes.append(absoluteIndexForIndexPath(indexPath))
    }
    var newPapers: [Paper] = []
    for (index, paper) in papers.enumerate() {
      if !indexes.contains(index) {
        newPapers.append(paper)
      }
    }
    papers = newPapers
  }
  
  func indexPathForNewRandomPaper() -> NSIndexPath {
    let index = Int(arc4random_uniform(UInt32(immutablePapers.count)))
    let paperToCopy = immutablePapers[index]
    let newPaper = Paper(copying: paperToCopy)
    papers.append(newPaper)
    papers.sortInPlace { $0.index < $1.index }
    return indexPathForPaper(newPaper)
  }
  
  func indexPathForPaper(paper: Paper) -> NSIndexPath {
    let section = sections.indexOf(paper.section)!
    var item = 0
    for (index, currentPaper) in papersForSection(section).enumerate() {
      if currentPaper === paper {
        item = index
        break
      }
    }
    return NSIndexPath(forItem: item, inSection: section)
  }
  
  func movePaperAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
    if indexPath == newIndexPath {
      return
    }
    let index = absoluteIndexForIndexPath(indexPath)
    let paper = papers[index]
    paper.section = sections[newIndexPath.section]
    let newIndex = absoluteIndexForIndexPath(newIndexPath)
    papers.removeAtIndex(index)
    papers.insert(paper, atIndex: newIndex)
  }
  
  func numberOfPapersInSection(index: Int) -> Int {
    let papers = papersForSection(index)
    return papers.count
  }
  
  func paperForItemAtIndexPath(indexPath: NSIndexPath) -> Paper? {
    if indexPath.section > 0 {
      let papers = papersForSection(indexPath.section)
      return papers[indexPath.item]
    } else {
      return papers[indexPath.item]
    }
  }
  
  func titleForSectionAtIndexPath(indexPath: NSIndexPath) -> String? {
    if indexPath.section < sections.count {
      return sections[indexPath.section]
    }
    return nil
  }
  
  // MARK: Private
  
  private func absoluteIndexForIndexPath(indexPath: NSIndexPath) -> Int {
    var index = 0
    for i in 0..<indexPath.section {
      index += numberOfPapersInSection(i)
    }
    index += indexPath.item
    return index
  }
  
  private func loadPapersFromDisk() -> [Paper] {
    sections.removeAll(keepCapacity: false)
    if let path = NSBundle.mainBundle().pathForResource("Papers", ofType: "plist") {
      if let dictArray = NSArray(contentsOfFile: path) {
        var papers: [Paper] = []
        for item in dictArray {
          if let dict = item as? NSDictionary {
            let caption = dict["caption"] as! String
            let imageName = dict["imageName"] as! String
            let section = dict["section"] as! String
            let index = dict["index"] as! Int
            let paper = Paper(caption: caption, imageName: imageName, section: section, index: index)
            if !sections.contains(section) {
              sections.append(section)
            }
            papers.append(paper)
          }
        }
        return papers
      }
    }
    return []
  }
  
  private func papersForSection(index: Int) -> [Paper] {
    let section = sections[index]
    let papersInSection = papers.filter { (paper: Paper) -> Bool in
      return paper.section == section
    }
    return papersInSection
  }
  
}
