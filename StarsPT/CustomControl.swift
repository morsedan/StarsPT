//
//  CustomControl.swift
//  StarsPT
//
//  Created by morse on 6/7/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    var value: Int = 1
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    private var labels: [UILabel] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        
        let space: CGFloat = 8.0
        
        var workingX: CGFloat = space
//        var workingY: CGFloat = 0
        var tagNumber = 1
        
        for _ in 1...componentCount {
            let label = UILabel(frame: CGRect(x: workingX, y: 0, width: componentDimension, height: componentDimension))
            addSubview(label)
            label.tag = tagNumber
            label.font = UIFont(name: "bold system font", size: 32.0)
            label.textAlignment = .center
            label.text = "✧"
            if label.tag == 1 {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
            
            labels.append(label)
            workingX += space
            workingX += componentDimension
            tagNumber += 1
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        for label in labels {
            let lastStarIndex = label.tag
            if label.frame.contains(touchPoint) {
                if label.tag >= self.value {
                    self.value = label.tag
                    for tag in 0..<(lastStarIndex) {
                        label.performFlare()
                        labels[tag].textColor = componentActiveColor
                    }
                } else {
                    self.value = label.tag
                    for tag in lastStarIndex...labels.count - 1 {
                        labels[tag].textColor = componentInactiveColor
                        
                    }
                }
            }
        }
    }
    
    
    
    // MARK: - Touch Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        updateValue(at: touch)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDown, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        updateValue(at: touch)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event)}
        
        guard let touch = touch else { return }
        updateValue(at: touch)
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.9, y: 1.9) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.3) { unflare() }})
    }
}
