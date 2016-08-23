//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    private var coverImage: UIImageView!
    private var indicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init(frame: CGRect, albumCover: String) {
        super.init(frame: frame)
        backgroundColor = UIColor.blackColor()
        coverImage = UIImageView(frame: CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10))
        addSubview(coverImage)
        coverImage.addObserver(self, forKeyPath: "image", options: [.New, .Old], context: nil)
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
        addSubview(indicator)
        NSNotificationCenter.defaultCenter().postNotificationName("BLDownloadImageNotification", object: self, userInfo: ["imageView": coverImage, "coverUrl": albumCover])
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        coverImage.removeObserver(self, forKeyPath: "image")
    }
    
    func highlightAlbum(didHighlightView didHighlightView: Bool){
        if didHighlightView == true {
            backgroundColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.blackColor()
        }
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }
}
