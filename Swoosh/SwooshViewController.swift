//
//  SwooshViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/16/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var image: UIImage?
    var refreshController: UIRefreshControl!
    
    let swooshDataSource = SwooshDataSource()
    let store = ShotStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        store.fetchImageForShot(shot) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
