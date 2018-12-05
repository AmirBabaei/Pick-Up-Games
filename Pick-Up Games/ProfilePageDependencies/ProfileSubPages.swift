//
//  Profile-Pages.swift
//  Pick-Up Games
//
//  Created by David Otwell on 11/7/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import Foundation

class ProfileSubPages: UIPageViewController {
    
    var UID = String()

    private(set) lazy var subPages: [UIViewController] = {
        let Bio = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileBioSubPage") as! ProfileBioSubPage
        let Friends = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileFriendsSubPage") as! ProfileFriendsSubPage
        let Events = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileEventsSubPage") as! ProfileEventsSubPage
        
        return [Bio, Friends, Events]
    }()
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 450, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = subPages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        
        if let firstSubPage = subPages.first {
            setViewControllers([firstSubPage], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension ProfileSubPages: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let subPageIndex = subPages.index(of: viewController) else {
            return nil
        }
        
        let prevIndex = subPageIndex - 1
        
        guard prevIndex >= 0 else {
            return subPages.last
        }
        
        guard subPages.count > prevIndex else {
            return nil
        }
        
        return subPages[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let subPageIndex = subPages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = subPageIndex + 1
        
        guard subPages.count != nextIndex else {
            return subPages.first
        }
        
        guard subPages.count > nextIndex else {
            return nil
        }
        
        return subPages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = subPages.index(of: pageContentViewController)!
    }
}


