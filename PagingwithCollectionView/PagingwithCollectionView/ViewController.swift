//
//  ViewController.swift
//  PagingwithCollectionView
//
//  Created by Droadmin on 20/09/23.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    var currentScrollOffset: CGPoint = .zero
    
    @IBOutlet weak var pageControl: UIPageControl!
    var colorView:[UIColor] = [.red,.black,.blue,.green,.brown]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(pageControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillLayoutSubviews() {
             
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.colorView.backgroundColor = colorView[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 100, height: collectionView.frame.size.height * 0.5)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // let cellWidth = collectionView.frame.size.width - 93 // Total width of the cell including spacing
        return 30
        //return collectionView.frame.size.width - cellWidth
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // let cellWidth = collectionView.frame.size.width - 93 // Total width of the cell including spacing
        let cellPadding = (100) / 2
        return UIEdgeInsets(top: 0, left: CGFloat(cellPadding), bottom: 0, right: CGFloat(cellPadding))
        
    }
    func itemWidth(_ scrollView: UIScrollView) -> CGFloat {
        return collectionView.frame.size.width - 100
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentScrollOffset = scrollView.contentOffset
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee
        //Current scroll distance is the distance between where the user tapped and the destination for the scrolling (If the velocity is high, this might be of big magnitude)
        let currentScrollDistance = target.x - currentScrollOffset.x
        //Make the value an integer between -1 and 1 (Because we don't want to scroll more than one item at a time)
        let coefficent = Int(max(-1, min(currentScrollDistance/0.5, 1)))
        let currentIndex = Int(round(currentScrollOffset.x/itemWidth(scrollView)))
        let adjacentItemIndex = (currentIndex + coefficent )
        let adjacentItemIndexFloat = CGFloat(adjacentItemIndex)
        let adjacentItemOffsetX = adjacentItemIndexFloat * (itemWidth(scrollView) + 30)
        targetContentOffset.pointee = CGPoint(x: adjacentItemOffsetX, y: target.y)
        pageControl.currentPage = adjacentItemIndex
    }
    
}
