//
//  PhoneBook.swift
//  Telephone
//
//  Created by Stanimir Hristov on 10/31/18.
//  Copyright © 2018 Stanimir Hristov. All rights reserved.
//

import Foundation

protocol PhoneBookDelegate: class {
    func numberDidUpdate()
}

class PhoneBook {
// First way - With Delegate
    
//    weak var delegate: PhoneBookDelegate? {
//        didSet {
//            delegate?.numberDidUpdate()
//        }
//    }
    
    var number: String? {
        didSet {
            NotificationCenter.default.post(name: .modelUpdated, object: nil)
            //delegate?.numberDidUpdate()
        }
    }
    
    static let shared = PhoneBook()
    private init () { }
}

extension Notification.Name {
    static let modelUpdated = Notification.Name("modelUpdated")
}
