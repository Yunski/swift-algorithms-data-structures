//
//  TSTTests.swift
//  swift-algorithm-data-structures
//
//  Created by Yun Teng on 7/26/16.
//  Copyright © 2016 yunskicentral. All rights reserved.
//

import XCTest

class TSTTests: XCTestCase {
    var words: [String]!
    var wordsSorted: [String]!
    var wordFilter: [String]!
    var tst: TST<Int>!
    var prefix: String!
    
    override func setUp() {
        super.setUp()
        let path = Bundle(for: TSTTests.self).pathForResource("words", ofType: "txt")
        do {
            var n = 0
            let text = try String(contentsOfFile: path!)
            words = text.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
            words = words.filter{ !$0.isEmpty }
            tst = TST<Int>()
            for word in words {
                tst.put(word, n)
                n += 1
            }
            prefix = "arch"
            wordsSorted = words.sorted{ $0 < $1 }
            wordFilter = wordsSorted.filter{ $0.hasPrefix(prefix) }
        } catch { fatalError("FAILED TO READ FILE") }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDataIntegrity() {
        XCTAssert(words.count == 437, "failed reading of text file")
        XCTAssert(tst.count == 437, "failed insertion of data into TST")
    }
    
    func testTSTKeysWithPrefix() {
        let tstFilter = tst.keys(withPrefix: prefix)
        XCTAssert(wordFilter.count == tstFilter.count, "tst keys(withPrefix: _) failed")
        
        for i in 0..<wordFilter.count {
            XCTAssert(wordFilter[i] == tstFilter[i])
        }
    }
    
    func testTSTValuesWithPrefix() {
        let tstFilterValues = tst.values(withPrefix: prefix)
        for i in 0..<wordFilter.count {
            let n = words.index(of: wordFilter[i])
            XCTAssert(n == tstFilterValues[i])
        }
    }
    
    func testTSTKeys() {
        let keys = tst.keys()
        for i in 0..<wordsSorted.count {
            XCTAssert(wordsSorted[i] == keys[i])
        }
    }
    
    func testTSTValues() {
        let values = tst.values()
        for i in 0..<wordsSorted.count {
            let n = words.index(of: wordsSorted[i])
            XCTAssert(n == values[i])
        }
    }
    
    func testTSTSearchMiss() {
        let prefix = "zzzzz"
        let keys = tst.keys(withPrefix: prefix)
        XCTAssert(keys.count == 0)
    }
    
    func testTSTIllegalGet() {
        let key = ""
        let found = tst.get(key)
        XCTAssert(found == nil)
    }
    
    func testTSTPerformance() {
        self.measure {
            _ = self.tst.keys(withPrefix: self.prefix)
        }
    }
    
    func testFilterPerformance() {
        self.measure {
            _ = self.words.filter{ $0.hasPrefix(self.prefix) }
        }
    }
}
