//
//  Mnemonic.swift
//  BlackWallet
//
//  Created by Yehor Sorokin on 14.02.24.
//

import Foundation

struct Mnemonic {
    
    static var emptyMnemonic = Mnemonic()
    
    var word1: String = ""
    var word2: String = ""
    var word3: String = ""
    var word4: String = ""
    var word5: String = ""
    var word6: String = ""
    var word7: String = ""
    var word8: String = ""
    var word9: String = ""
    var word10: String = ""
    var word11: String = ""
    var word12: String = ""
    
    init() {
    }
    
    init (from str: String) {
        guard str.count > 0 else {
            fatalError("\n\n\nCould not init mnemonic init (from str: String)\n\n\n")
        }
        let s = str.split(separator: " ").map { String($0) }
        word1 = s[0]
        word2 = s[1]
        word3 = s[2]
        word4 = s[3]
        word5 = s[4]
        word6 = s[5]
        word7 = s[6]
        word8 = s[7]
        word9 = s[8]
        word10 = s[9]
        word11 = s[10]
        word12 = s[11]
    }
    
    static func ==(lhs: Mnemonic, rhs: Mnemonic) -> Bool {
        return lhs.word1 == rhs.word1 && lhs.word2 == rhs.word2 && lhs.word3 == rhs.word3 && lhs.word4 == rhs.word4 && lhs.word5 == rhs.word5 && lhs.word6 == rhs.word6 && lhs.word7 == rhs.word7 && lhs.word8 == rhs.word8 && lhs.word9 == rhs.word9 && lhs.word10 == rhs.word10 && lhs.word11 == rhs.word11 && lhs.word12 == rhs.word12
    }
    
    static func !=(lhs: Mnemonic, rhs: Mnemonic) -> Bool {
        !(lhs == rhs)
    }
}
