//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by 洪浩东 on 8/23/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

//扩展“Model 层最好就是负责纯粹的数据结构，如果有数据的操作可以放到扩展中完成。”

extension Album {
    func ae_tableRepresentation() -> (titles: [String], values: [String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}
