//
//  ViewController.swift
//  Telephone
//
//  Created by Stanimir Hristov on 10/25/18.
//  Copyright © 2018 Stanimir Hristov. All rights reserved.
//

import UIKit

struct Constants {
    static let zeroButtonIndex = 10
    static let zeroSymbol = "0"
    static let plusSymbol = "+"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    @IBOutlet var numButtons: [UIButton]!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var eraseButton: UIButton!
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if let title = sender.currentTitle {
            PhoneBook.shared.number = (PhoneBook.shared.number ?? "") + title
        }
    }
    
    @IBAction func eraseTouched(_ sender: UIButton) {
        PhoneBook.shared.number = "\(PhoneBook.shared.number?.dropLast() ?? "")"
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.began) {
            changeZeroButtonTitleWith(Constants.plusSymbol)
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            changeZeroButtonTitleWith(Constants.zeroSymbol)
            PhoneBook.shared.number?.append(Constants.plusSymbol)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // First way - with delegate
        //PhoneBook.shared.delegate = self
        
        NotificationCenter.default.addObserver(forName: .modelUpdated,
                                               object: nil,
                                               queue: nil) { [weak self] _ in
                                                        self?.updateView()
        }
        
        PhoneBook.shared.number = nil
        
        callButton.layer.cornerRadius = callButton.frame.size.width / 2
        for button in numButtons {
            button.layer.cornerRadius = button.frame.size.width / 2
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateView() {
        infoTextLabel?.text = formatPhoneNumber(text: PhoneBook.shared.number, with: " ")
        eraseButton?.isHidden = PhoneBook.shared.number?.isEmpty ?? true
    }
    
    // MARK: Helpers
    func changeZeroButtonTitleWith(_ title: String) {
        numButtons[Constants.zeroButtonIndex].titleLabel?.text = title
    }
    
    func formatPhoneNumber(text: String?, with separator: String) -> String? {
        guard let textUnwrapped = text else {
            return text
        }
        
        var formattedText = ""
        for (index, character) in textUnwrapped.enumerated() {
            if index != 0 && index % 3 == 0 {
                formattedText.append(separator)
            }
            
            formattedText.append(String(character))
        }
        
        return formattedText
    }
}

// First way - With Delegate

//extension ViewController: PhoneBookDelegate {
//    func numberDidUpdate() {
//        infoTextLabel.text = PhoneBook.shared.number
//        eraseButton.isHidden = PhoneBook.shared.number?.isEmpty ?? true
//    }
//}
