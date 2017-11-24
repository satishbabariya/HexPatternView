//
//  ViewController.swift
//  HexPatternView
//
//  Created by satish.babariya@gmail.com on 11/24/2017.
//  Copyright (c) 2017 satish.babariya@gmail.com. All rights reserved.
//

import UIKit
import HexPatternView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let patternView : HexPatternView = HexPatternView.init()
        view.addSubview(patternView)
        patternView.translatesAutoresizingMaskIntoConstraints = false
        patternView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        patternView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        patternView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        patternView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0.7022017837, blue: 0.9288000464, alpha: 1)
        patternView.setRhombusPattern()
        patternView.color = UIColor.white
        patternView.alpha = 0.1
        patternView.cellWidthMax = 70
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

