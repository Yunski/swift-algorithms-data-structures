//
//  Node.swift
//  Insta3DStickers
//
//  Created by Yun Teng on 7/15/16.
//  Copyright © 2016 yunskicentral. All rights reserved.
//

class Node<T> {
    var key: Character
    var left, mid, right: Node?
    var val: T?
    
    init(_ key: Character) {
        self.key = key
    }
}
