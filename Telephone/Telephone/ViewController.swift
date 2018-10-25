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
        infoTextLabel.text?.append(sender.titleLabel?.text ?? "")
        hideEraseButton(false)
    }
    
    @IBAction func eraseTouched(_ sender: UIButton) {
        if let subStringWithoutLast = infoTextLabel.text?.dropLast() {
            infoTextLabel.text = String(subStringWithoutLast);
        }
        if let empty = infoTextLabel.text?.isEmpty {
            hideEraseButton(empty)
        }
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.ended) {
            changeZeroButtonTitleWith(Constants.zeroSymbol)
            infoTextLabel.text?.append(Constants.plusSymbol)
            hideEraseButton(false)
        } else if (sender.state == UIGestureRecognizer.State.began) {
            changeZeroButtonTitleWith(Constants.plusSymbol)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideEraseButton(true)
        callButton.layer.cornerRadius = roundedCornerRadius(callButton.frame.size.width)
        for button in numButtons {
            button.layer.cornerRadius = roundedCornerRadius(button.frame.size.width)
        }
    }
    
    // MARK: Helpers
    
    func hideEraseButton(_ state: Bool) {
        eraseButton.isHidden = state
    }
    
    func changeZeroButtonTitleWith(_ title: String) {
        numButtons[Constants.zeroButtonIndex].titleLabel?.text = title
    }
    
    func roundedCornerRadius(_ frameWidth: CGFloat) -> CGFloat {
        return frameWidth / 2;
    }
}
