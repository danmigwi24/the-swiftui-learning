//
//  ViewController.swift
//  DailyTask
//
//  Created by Daniel Kimani on 10/11/2023.
//

import UIKit

class SplashViewController: UIViewController {
    private  lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    ///*
    private  lazy var personaImageView: PersonaImageView = {
        let imageView = PersonaImageView()//UIImageView(image: UIImage(named: "personaimage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //*/
    
    /*
    private  lazy var personaImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "personaimage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    */
    private lazy var welcomeTextMessageView: UILabel = {
        let label = UILabel()
        let messageText = "Manage your Task with DayTask"
        //
        let attributedString = NSMutableAttributedString(string: messageText)
        
        let firstRange = NSString(string: messageText)
            .range(of: "Manage your Task with",
                   options: String.CompareOptions.caseInsensitive
            )
        
        attributedString.addAttributes(
            [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 40)
            ],
            range: firstRange
        )
    
        let lastRange = NSString(string: messageText)
            .range(of: "DayTask",
                   options: String.CompareOptions.caseInsensitive
            )
        
        attributedString.addAttributes(
            [
                .foregroundColor: UIColor(named: "AccentColor") ?? UIColor.white,
                .font: UIFont.systemFont(ofSize: 40)
            ],
            range: lastRange
        )
        
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        
        
        return label
    }()
    
    
    private lazy var startButton: UIButton = {
        let button =  UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Let's Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
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
        self.view.addSubview(personaImageView)
        self.view.addSubview(welcomeTextMessageView)
        self.view.addSubview(startButton)
        
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20)
        ])
        //
        NSLayoutConstraint.activate([
            personaImageView.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            personaImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 20),
            //
            view.trailingAnchor.constraint(equalTo: personaImageView.trailingAnchor,constant: 20),
            personaImageView.heightAnchor.constraint(equalToConstant: 330)
        ])
        //
        NSLayoutConstraint.activate([
            welcomeTextMessageView.leadingAnchor.constraint(equalTo: personaImageView.leadingAnchor),
            welcomeTextMessageView.topAnchor.constraint(equalTo: personaImageView.bottomAnchor,constant: 30),
            //
            welcomeTextMessageView.trailingAnchor.constraint(equalTo: personaImageView.trailingAnchor)
        ])
        //
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: personaImageView.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: personaImageView.trailingAnchor),
            //
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: startButton.bottomAnchor,constant: 20),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    
    @objc func startButtonPressed(button:UIButton){
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}

