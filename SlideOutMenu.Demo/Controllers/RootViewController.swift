//
//  ContentView.swift
//  SlideOutMenu.Demo
//
//  Created by Art Arriaga on 2/9/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
//MARK: Instance Properties
    //Constraints to be manipulated during pan.
    var baseRootViewLeadingAnchor: NSLayoutConstraint!
    var baseRootViewTrailingAnchor: NSLayoutConstraint!
    

    //Setting up menu properties.
    fileprivate let menuWidth: CGFloat = 150
    fileprivate var isMenuOpen: Bool = false

    //View that serves as a container for another viewcontroller.
    let baseRootView: UIView = {
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
    
    //View that serves as a container for another viewcontroller.
    let baseMenuView: UIView = {
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
    
    //MARK: View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupGestureRecognizer()
        setupViewControllers()
    }
    
    //MARK: Adding View Controllers
    var homeViewController: UIViewController = UINavigationController(rootViewController: HomeViewController())
    fileprivate func setupViewControllers() {
        let rootView = homeViewController.view!
        rootView.translatesAutoresizingMaskIntoConstraints = false
        baseRootView.addSubview(rootView)
        
        let menuController = MenuController()
        let menuView = menuController.view!
        menuView.translatesAutoresizingMaskIntoConstraints = false
        baseMenuView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: baseRootView.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: baseRootView.leadingAnchor),
            rootView.bottomAnchor.constraint(equalTo: baseRootView.bottomAnchor),
            rootView.trailingAnchor.constraint(equalTo: baseRootView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: baseMenuView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: baseMenuView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: baseMenuView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: baseMenuView.trailingAnchor)
        ])
        
        self.addChild(homeViewController)
        self.addChild(menuController)
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
           performRightViewCleanUp()
           closeMenu()
           
           switch indexPath.row {
           case 0:
               homeViewController = UINavigationController(rootViewController: HomeViewController())
           case 1:
               homeViewController = UINavigationController(rootViewController: SecondContoller())
           case 2:
               homeViewController = ThirdViewController()
           default:
               
               let tabBarController = BaseTabBarController()
               homeViewController = tabBarController
           }
           
           baseRootView.addSubview(homeViewController.view)
           addChild(homeViewController)
           
//           baseRootView.bringSubviewToFront(darkCoverView)
       }
       
       
       
       fileprivate func performRightViewCleanUp() {
           homeViewController.view.removeFromSuperview()
           homeViewController.removeFromParent()
       }
    
//MARK: PanGesture Setup
    fileprivate func setupGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var amountPanned = translation.x
        
        amountPanned = isMenuOpen ? amountPanned + menuWidth : amountPanned
        // ensure panning does not exceed these amounts.
        amountPanned = min(menuWidth, amountPanned)
        amountPanned = max(0, amountPanned)
        
        baseRootViewLeadingAnchor.constant = amountPanned
        baseRootViewTrailingAnchor.constant = amountPanned
        
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
    
//MARK: Navigation w/ Animation
    func openMenu () {
        isMenuOpen = true
        baseRootViewLeadingAnchor.constant = menuWidth
        baseRootViewTrailingAnchor.constant = menuWidth
        animateTransition()
    }

    func closeMenu() {
        isMenuOpen = false
        baseRootViewLeadingAnchor.constant = 0
        baseRootViewTrailingAnchor.constant = 0
        animateTransition()
    }
    

    fileprivate func animateTransition() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: Setup views and Layout
extension RootViewController {
    fileprivate func setupViews() {
        //add views to heirarchy
        self.view.addSubview(baseRootView)
        self.view.addSubview(baseMenuView)
        
        NSLayoutConstraint.activate([
            baseRootView.topAnchor.constraint(equalTo: view.topAnchor),
            baseRootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            baseMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            baseMenuView.trailingAnchor.constraint(equalTo: baseRootView.leadingAnchor),
            baseMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            baseMenuView.widthAnchor.constraint(equalToConstant: menuWidth)
        ])
        
        baseRootViewLeadingAnchor = baseRootView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        baseRootViewLeadingAnchor.isActive = true
        
        baseRootViewTrailingAnchor = baseRootView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        baseRootViewTrailingAnchor.isActive = true
        
    }
}
