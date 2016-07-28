//: Playground - TST

import UIKit

var words: [String]!
var wordsSorted: [String]!
var wordFilter: [String]!
var tst: TST<Int>!
var prefix: String!

let path = Bundle.main.pathForResource("words", ofType: "txt")
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

let tstFilter = tst.keys(withPrefix: prefix)
for i in 0..<tstFilter.count {
    print(tstFilter[i])
}

