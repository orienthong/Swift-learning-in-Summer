//
//  CandyStickerBrowserViewController.swift
//  Stickerlicious
//
//  Created by 洪浩东 on 8/4/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import Messages

class CandyStickerBrowserViewController: MSStickerBrowserViewController {
    var stickers = [MSSticker]()
    let stickerNames = ["CandyCane", "Caramel", "ChocolateBar","ChocolateChip", "DarkChocolate", "GummiBear", "JawBreaker", "Lollipop", "SourCandy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStickers()
        stickerBrowserView.backgroundColor = #colorLiteral( red: 0.9490196078, green: 0.7568627451, blue: 0.8196078431, alpha: 1)
    }
    
}
extension CandyStickerBrowserViewController {
    private func loadStickers(_ chocoholic: Bool = false) {
//        stickers = stickerNames.map({name in
//            let url = Bundle.main().urlForResource(name, withExtension: "png")!
//            return try! MSSticker (contentsOfFileURL: url, localizedDescription: name)
//        })
        stickers = stickerNames.filter( { name in
            return chocoholic ? name.contains("Chocolate") : true
        }).map({ name in let url = Bundle.main().urlForResource(name,withExtension: "png")!
            return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
        })
    }
}
//MARK: MSStickerBrowserViewDataSource
extension CandyStickerBrowserViewController {
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
}
extension CandyStickerBrowserViewController: Chocoholicable {
    func setChocoholic(_ chocoholic: Bool) {
        loadStickers(chocoholic)
        stickerBrowserView.reloadData()
    }
}
