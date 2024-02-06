//
//  PersonaImageView.swift
//  DailyTask
//
//  Created by Daniel Kimani on 10/11/2023.
//

import Foundation
import UIKit

class PersonaImageView : UIView {
     
    private lazy var imageView = {
        let view = UIImageView(image: UIImage(named: "personaimage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = CGRect.zero){
        super.init(frame:frame)
        backgroundColor = .white
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize{
//        get {CGSize(width: 100, height: 100)}
//    }
    
    private func layoutView(){
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            //
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        
        ])
    }
}
