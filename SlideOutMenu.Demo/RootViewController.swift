//
//  ContentView.swift
//  SlideOutMenu.Demo
//
//  Created by Art Arriaga on 2/9/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    //Constraints to be manipulated during pan.
    var pinkViewsLeadingAnchor: NSLayoutConstraint!
    var pinkViewsTrailingAnchor: NSLayoutConstraint!
    

    //Setting up menu properties.
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpen: Bool = false
    
    let pinkView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = "Some \nbase \ncontroller"
        v.addSubview(label)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        return v
    }()
    
    let greenView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = "Some menu with \nselectable options"
        v.addSubview(label)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupGestureRecognizer()
    }
    

    fileprivate func setupGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var amountPanned = translation.x
        
        amountPanned = isMenuOpen ? amountPanned + menuWidth : amountPanned
        // ensuring panning does not exceed these amounts so that when the user pans, they do not see the background view and panning stops once they reach these min/max ammounts.
        amountPanned = min(menuWidth, amountPanned)
        amountPanned = max(0, amountPanned)
        
        pinkViewsLeadingAnchor.constant = amountPanned
        pinkViewsTrailingAnchor.constant = amountPanned
        
        if gesture.state == .ended {
            handleEnd(gesture)
        }
    }
    
    fileprivate let panThresholdVelocity: CGFloat = 500
    @objc fileprivate func handleEnd(_ gesture: UIPanGestureRecognizer) {
        let gestureTranslationAmount = gesture.translation(in: view)
        let userPanningVelocity = gesture.velocity(in: view)

        if isMenuOpen {
            if userPanningVelocity.x < -panThresholdVelocity {
                closeMenu()
                return
            }
            if abs(gestureTranslationAmount.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if userPanningVelocity.x > panThresholdVelocity {
                openMenu()
                return
            }
            if gestureTranslationAmount.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }

    }
    
    func openMenu () {
        isMenuOpen = true
        pinkViewsLeadingAnchor.constant = menuWidth
        pinkViewsTrailingAnchor.constant = menuWidth
        animateTransition()
    }

    func closeMenu() {
        isMenuOpen = false
        pinkViewsLeadingAnchor.constant = 0
        pinkViewsTrailingAnchor.constant = 0
        animateTransition()
    }
    
    
    fileprivate func animateTransition() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
}


extension RootViewController {
    fileprivate func setupViews() {
        //add views to heirarchy
        self.view.addSubview(pinkView)
        self.view.addSubview(greenView)
        
        NSLayoutConstraint.activate([
            pinkView.topAnchor.constraint(equalTo: view.topAnchor),
            pinkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            greenView.topAnchor.constraint(equalTo: view.topAnchor),
            greenView.trailingAnchor.constraint(equalTo: pinkView.leadingAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            greenView.widthAnchor.constraint(equalToConstant: menuWidth)
        ])
        
        pinkViewsLeadingAnchor = pinkView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        pinkViewsLeadingAnchor.isActive = true
        
        pinkViewsTrailingAnchor = pinkView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        pinkViewsTrailingAnchor.isActive = true
        
    }
}
