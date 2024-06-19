//
//  ViewController.swift
//  Counter
//
//  Created by Игорь on 18.06.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var increaseButton: UIButton!
    @IBOutlet private weak var decreaseButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!
    @IBOutlet private weak var counterLabel: UILabel!
    
    private var counter = 0 {
        didSet {
            counter = max(0, counter)
            counterLabel.text = "Значение счётчика: \(counter)"
        }
    }
    
    private enum HistoryStatus: String {
        case increase = "значение изменено на +1"
        case decrease = "значение изменено на -1"
        case error = "попытка уменьшить значение счётчика ниже 0"
        case reset = "значение сброшено"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTextView.isEditable = false
    }

    @IBAction private func reset() {
        updateCounter(to: 0, with: .reset)
    }
    
    @IBAction private func increase() {
        updateCounter(to: counter + 1, with: .increase)
    }
    
    @IBAction private func decrese() {
        if counter > 0 {
            updateCounter(to: counter - 1, with: .decrease)
        } else {
            updateHistory(with: .error)
        }
    }
    
    private func updateCounter(to newValue: Int, with status: HistoryStatus) {
        counter = newValue
        updateHistory(with: status)
    }
    
    private func getCurrentDate() -> String {
        return Date().formatted(.dateTime)
    }
    
    private func updateHistory(with status: HistoryStatus) {
        let dateAndTime = getCurrentDate()
        
        historyTextView.text += "\n[\(dateAndTime)]: \(status.rawValue)"
        scrollHistoryToBottom()
    }
    
    private func scrollHistoryToBottom() {
        let range = NSRange(location: historyTextView.text.count - 1, length: 0)
        
        historyTextView.scrollRangeToVisible(range)
    }
}

