//
//  Album.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Album {
  
  var title: String
  var photos: [UIImage]
  
  init(title: String, photos: [UIImage]) {
    self.title = title
    self.photos = photos
  }
  
  class func allAlbums() -> [Album] {
    let dateFormatter = NSDateFormatter()
    dateFormatter.doesRelativeDateFormatting = true
    dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
    dateFormatter.locale = NSLocale.currentLocale()
    let calendar = NSCalendar.currentCalendar()
    let today = NSDate()
    let yesterday = calendar.dateByAddingUnit(.DayCalendarUnit, value: -1, toDate: today, options: nil)!
    let theDayBeforeYesterday = calendar.dateByAddingUnit(.DayCalendarUnit, value: -2, toDate: today, options: nil)!
    let theDayBeforeThat = calendar.dateByAddingUnit(.DayCalendarUnit, value: -3, toDate: today, options: nil)!
    let titles = [dateFormatter.stringFromDate(today), dateFormatter.stringFromDate(yesterday), dateFormatter.stringFromDate(theDayBeforeYesterday), dateFormatter.stringFromDate(theDayBeforeThat)]
    var tutorialBackgroundImages = [UIImage]()
    for i in 1...24 {
      let imageName = String(format: "Tutorial-%02d", i)
      if let image = UIImage(named: imageName) {        
        tutorialBackgroundImages.append(image.decompressedImage)
      }
    }
    var albums = [Album]()
    var offset = 0
    for title in titles {
      let photos = Array(tutorialBackgroundImages[offset..<offset + 6])
      let album = Album(title: title, photos: photos)
      albums.append(album)
      offset += 6
    }
    return albums
  }
  
}
