//
//  SignInViewController.swift
//  DailyTask
//
//  Created by Daniel Kimani on 14/11/2023.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    private  lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var startButton: UIButton = {
        let button =  UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Let's Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //view.backgroundColor = .red
        layout()
    }
    
    func layout(){
        self.view.addSubview(logoImageView)
        
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            //
            view.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor,constant: 20),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 71),
            logoImageView.widthAnchor.constraint(equalToConstant: 71),

        ])
    
    }
    
}

