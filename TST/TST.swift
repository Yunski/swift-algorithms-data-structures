//
//  TST.swift
//  Insta3DStickers
//
//  Created by Yun Teng on 7/14/16.
//  Copyright © 2016 yunskicentral. All rights reserved.
//

/// Ternary Search Trie - symbol table mapping string keys to values
public class TST<T> {
    /**
     the number of key-value pairs in the symbol table.
     */
    public var count: Int {
        get {
            return self.n
        }
    }
    private var n: Int = 0
    private var root: Node<T>?
    
    /**
     check if the symbol table contains the given key
     
     - Returns: true if symbol table contains key and false otherwise
     
     - Parameter: key: String key
     */
    
    public func contains(_ key: String) -> Bool {
        return get(key) != nil
    }
    
    /**
     retrieve value associated with the given key
     
     - Returns: value associated with key if the key exists, otherwise nil if they
     key does not exist
     
     - Parameter: key: String key
     */
    
    public func get(_ key: String) -> T? {
        guard key.characters.count > 0 else {
            print("key must have length >= 0")
            return nil
        }
        if let found = get(root, key, 0) {
            return found.val
        }
        return nil
    }
    
    private func get(_ x: Node<T>?, _ key: String, _ d: Int) -> Node<T>? {
        if x == nil {
            return nil
        }
        let index = key.index(key.startIndex, offsetBy: d)
        if key[index] < x!.key {
            return get(x!.left, key, d)
        } else if key[index] > x!.key {
            return get(x!.right, key, d)
        } else if d < key.characters.count - 1 {
            return get(x!.mid, key, d+1)
        }
        return x
    }
    
    /**
     Insert key-value pair into symbol table
     
     - Parameters:
        - key: key to be inserted
        - val: value to be inserted with key
     */
    
    public func put(_ key: String, _ val: T) {
        if !contains(key) {
            n += 1
        }
        root = put(root, key, val, 0)
    }
    
    private func put(_ x: Node<T>?, _ key: String, _ val: T, _ d: Int) -> Node<T>? {
        var x: Node<T>? = x
        let index = key.index(key.startIndex, offsetBy: d)
        if x == nil {
            x = Node(key[index])
        }
        
        if key[index] < x!.key {
            x!.left = put(x!.left, key, val, d)
        } else if key[index] > x!.key {
            x!.right = put(x!.right, key, val, d)
        } else if d < key.characters.count - 1 {
            x!.mid = put(x!.mid, key, val, d + 1)
        } else {
            x!.val = val
        }
        return x
    }
    
    /**
     returns all keys in the symbol table as an Array
     
     - Returns: an array containing all keys in the symbol table
     */
    
    public func keys() -> [String] {
        var list = [String]()
        collect(root, "", &list)
        return list
    }
    
    /**
     returns all keys in the symbol table starting with a prefix as an Array
     
     - Returns: an array containing all keys in the symbol table that start with the given prefix
     
     - Parameter: pref: prefix
     */
    
    public func keys(withPrefix pref: String) -> [String] {
        var list = [String]()
        let x = get(root, pref, 0)
        if x == nil {
            return list
        }
        if x!.val != nil {
            list.append(pref)
        }
        collect(x!.mid, pref, &list)
        return list
    }
    
    /**
     returns all values in the symbol table as an Array
     
     - Returns: an array containing all values in the symbol table
     
     - Parameter : pref: prefix
     */
    
    public func values() -> [T] {
        var vals = [T]()
        let keys = self.keys()
        for key in keys {
            vals.append(get(key)!)
        }
        return vals
    }
    
    /**
     returns all values in the symbol table associated with keys starting with the given prefix as an Array
     
     - Returns: an array containing all values in the symbol table that are associated with keys starting with the given prefix
     
     - Parameter pref: prefix
     */
    
    public func values(withPrefix pref: String) -> [T] {
        let keys = self.keys(withPrefix: pref)
        var vals = [T]()
        for key in keys {
            vals.append(get(key)!)
        }
        return vals
    }
    
    private func collect(_ x: Node<T>?, _ prefex: String, _ list: inout [String]) {
        var prefex = prefex
        if x == nil {
            return
        }
        collect(x!.left, prefex, &list)
        if x!.val != nil {
            list.append(prefex + String(x!.key))
        }
        prefex.append(x!.key)
        collect(x!.mid, prefex, &list)
        let last = prefex.index(prefex.endIndex, offsetBy: -1)
        prefex.remove(at: last)
        collect(x!.right, prefex, &list)
    }
}
