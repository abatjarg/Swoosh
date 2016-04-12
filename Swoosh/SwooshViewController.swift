//
//  SwooshViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/16/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class SwooshViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var image: UIImage?
    var refreshController: UIRefreshControl!
    
    let swooshDataSource = SwooshDataSource()
    let store = ShotStore()
    
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Center // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
        }
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
        }
        
        collectionView.dataSource = swooshDataSource
        collectionView.delegate = self
        
        self.refreshController = UIRefreshControl()
        self.refreshController.addTarget(self, action: #selector(SwooshViewController.refresh), forControlEvents: .ValueChanged)
        
        self.collectionView.addSubview(refreshController)
        refresh()
        
    }
    
    func refresh() {
        store.fetchRecentShots() {
            (shotsResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch shotsResult {
                case let .Success(shots):
                    self.swooshDataSource.shots = shots
                    self.refreshController.endRefreshing()
                case let .Failure(error):
                    self.swooshDataSource.shots.removeAll()
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let shot = swooshDataSource.shots[indexPath.row]
        
        store.fetchTeaserImageForShot(shot) {
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                let shotIndex = self.swooshDataSource.shots.indexOf(shot)!
                let shotIndexPath = NSIndexPath(forRow: shotIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(shotIndexPath) as? SwooshCollectionViewCell {
                    cell.updateWithImage(shot.image)
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = (self.collectionView.bounds.size.width - (2*3) - 4) / 4
        return CGSize(width: size, height: size)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowShot" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let shot = swooshDataSource.shots[selectedIndexPath.row]
                let destinationVC = segue.destinationViewController as! SwooshShotDetailViewController
                destinationVC.shot = shot
                destinationVC.store = store
            }
        }
    }

}
