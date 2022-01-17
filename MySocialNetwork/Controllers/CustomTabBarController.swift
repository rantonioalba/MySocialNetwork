//
//  CustomTabBarController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import UIKit

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate {

    var navHomeController:UIViewController!

    var viewSelector: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        
        self.viewSelector = UIView()
        self.tabBar.addSubview(self.viewSelector)
        
        tabBar.backgroundImage = UIImage()
        
        tabBar.isTranslucent = false
        
        tabBar.barTintColor = UIColor.white
        
        tabBar.unselectedItemTintColor = UIColor.lightGray
        
//        tabBar.tintColor = UIColor(red: 215/255.0, green: 81/255.0, blue: 108/255.0, alpha: 1.0)
        
        tabBar.tintColor = UIColor.black
        
    }
    
    func setupView()  {
        //homeController
        let homeController = HomeController(nibName: "HomeController", bundle: .main)
        
        homeController.viewModel = HomeViewModel()
        
        navHomeController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(navHomeController.view)
        
        addChild(navHomeController)
        
        navHomeController.didMove(toParent: self)
        
        homeController.tabBarItem.image = UIImage(named: "home")
        
        navHomeController.tabBarItem.image = UIImage(named: "home")
        
        //messagesController
        let messagesController =  MessagesController(nibName: "MessagesController", bundle: .main)
        messagesController.viewModel = MessagesViewModel()
        let navMessagesController = UINavigationController(rootViewController: messagesController)
        
        navMessagesController.tabBarItem.image = UIImage(named: "message")
        navMessagesController.tabBarItem.title = ""
        messagesController.tabBarItem.title = ""
        
        //ChartsController
        let chartsController = ChartsController(nibName: "ChartsController", bundle: .main)
        
        let viewModel = ChartsViewModel()
        
        chartsController.viewModel = viewModel
        
        let navChartsController = UINavigationController(rootViewController: chartsController)
        
//        navChartsController.tabBarItem.tag = 2
        navChartsController.tabBarItem.image = UIImage(named: "plus_circle")
        
        
        //NotificationsController
        let notificationsController = NotificationsController(nibName: "NotificationsController", bundle: .main)
        
        let navNotificationsController = UINavigationController(rootViewController: notificationsController)
        navNotificationsController.tabBarItem.image = UIImage(named: "notification_bell")
        navNotificationsController.tabBarItem.title = ""
        notificationsController.tabBarItem.title = ""
        
        //ProfileController
        let profileController = ProfileController(nibName: "ProfileController", bundle: .main)
        
        let navProfileController = UINavigationController(rootViewController: profileController)
        navProfileController.tabBarItem.image = UIImage(named: "profile_round")
        
        
        self.viewSelector.frame = CGRect(x: 0.0, y: 0.0, width: (self.tabBar.frame.size.width)/5.0, height: 2.5)
        self.viewSelector.backgroundColor = UIColor(red: 215/255.0, green: 81/255.0, blue: 108/255.0, alpha: 1.0)
        
        viewControllers = [navHomeController,navMessagesController,navChartsController,navNotificationsController,navProfileController]
        
    }
    
    private func moveSelectorBar(index:Int!){
        let position:CGFloat = (CGFloat)((self.tabBar.frame.size.width)/5.0) * ((CGFloat)(index))
        UIView.animate(withDuration: 0.23, animations: {
            self.viewSelector.frame = CGRect(x: position, y: self.viewSelector.frame.origin.y, width: self.viewSelector.frame.size.width, height: self.viewSelector.frame.size.height)
        })
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.moveSelectorBar(index: tabBarController.viewControllers?.firstIndex(of: viewController))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
