//
//  SwooshViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/16/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    let swooshDataSource = SwooshDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.dataSource = swooshDataSource
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
