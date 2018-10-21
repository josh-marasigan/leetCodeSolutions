//
//  ViewController.swift
//  8162018
//
//  Created by Josh Marasigan on 8/16/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var colorIndex = 0
    private lazy var colors: [UIColor] = {
       var colors = [UIColor]()
        colors.append(UIColor.magenta)
        colors.append(UIColor.purple)
        colors.append(UIColor.green)
        return colors
    }()
    
    private lazy var square: UIView = {
        let view = UIView()
        view.backgroundColor = colors[colorIndex]
        
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 250, height: 250)
        view.layer.bounds = CGRect(origin: origin, size: size)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGesture()
        self.configUI()
    }

    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.square.addGestureRecognizer(tap)
    }
    
    private func configUI() {
        self.view.addSubview(self.square)
    }
    
    @objc private func onTap() {
        colorIndex += 1
        if colorIndex < self.colors.count {
            self.square.backgroundColor = colors[colorIndex]
        } else {
            colorIndex = 0
            self.square.backgroundColor = colors[colorIndex]
        }
    }
}

