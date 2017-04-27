//
//  MenuViewController.swift
//  Film Locations
//
//  Created by Laura on 4/27/17.
//  Copyright © 2017 Codepath Spring17. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    var firstViewController: UIViewController?
    var secondViewController: UIViewController?
    
    private var activeViewController: UIViewController? {
        didSet{
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    private var toggleButtonImage: UIImage {
        get {
            return toggleButton.currentImage!
        }
        set {
            toggleButton.setImage(newValue, for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activeViewController = firstViewController
        toggleButton.setImage(UIImage(named: "listToggleIcon"), for: UIControlState.normal)
    }
    
    func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            // called before removing child view controller's view form hierarchy
            inactiveVC.willMove(toParentViewController: nil)
            
            inactiveVC.view.removeFromSuperview()
            
            // called after removing child view controller's view from hierarchy
            inactiveVC.removeFromParentViewController()
        }
    }
    
    func updateActiveViewController() {
        if let activeVC = activeViewController {
            // called before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            
            // call before adding child view contoller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    
    private func updateToggleButtonIcon(with image: String) {
        toggleButtonImage = UIImage(named: image)!
    }
    
    @IBAction func toggleActiveView(_ sender: UIButton) {
        if activeViewController == firstViewController {
            activeViewController = secondViewController
            updateToggleButtonIcon(with: "mapToggleIcon")
        }
        else {
            activeViewController = firstViewController
            updateToggleButtonIcon(with: "listToggleIcon")
        }
    }
    
    
}
