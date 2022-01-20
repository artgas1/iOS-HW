//
//  ViewController.swift
//  hw6
//
//  Created by Egor Fedyaev on 12.01.2022.
//

import UIKit
import MyLogger1
import MyLogger2
import MyLogger3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
    }

    func addUI() {
        view.backgroundColor = .white
        
        let buttons = [UIButton(), UIButton(), UIButton(), UIButton()]
        let buttonTitles = ["Log Framework", "Log Package", "Log Pod", "Log Carthage"]
        let selectors = [#selector(frameworkButtonPressed), #selector(packageButtonPressed), #selector(podButtonPressed), #selector(carthageButtonPressed)]
        
        for (index, button) in buttons.enumerated() {
            button.setTitle(buttonTitles[index], for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: selectors[index], for: .touchUpInside)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 400),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func frameworkButtonPressed() {
        MyLogger1.log(s: "Hello world")
    }
    
    @objc func packageButtonPressed() {
        MyLogger2.log(s: "Hello world")
    }
    
    @objc func podButtonPressed() {
        MyLogger3.log(s: "Hello world")
    }
    
    @objc func carthageButtonPressed() {
        // file not found ((
    }
}

