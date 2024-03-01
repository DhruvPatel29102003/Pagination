//
//  ViewController.swift
//  Pagination
//
//  Created by Droadmin on 18/09/23.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate{
    var slidesView:[SideView] = []
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        slidesView = createSlides()
        setupSlidescrollView(slides: slidesView)
        pageControl.numberOfPages = slidesView.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        // Do any additional setup after loading the view.
        pageControl.addTarget(self, action: #selector(clickToSwipe(_:)), for: .valueChanged)

    }
    
    @IBAction func clickToSwipe(_ sender: Any) {
        let xCoordinate = CGFloat((sender as AnyObject).currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: xCoordinate, y: 0), animated: true)
    }
    func createSlides() -> [SideView] {
        let slide1:SideView = Bundle.main.loadNibNamed("View", owner: self)?.first as! SideView
        slide1.movieImage.image = UIImage(named: "Leo")
        slide1.moviNameLbl.text = "Leo"
        
        let slide2:SideView = Bundle.main.loadNibNamed("View", owner: self)?.first as! SideView
        slide2.movieImage.image = UIImage(named: "Salaar")
        slide2.moviNameLbl.text = "Salaar"
        
        let slide3:SideView = Bundle.main.loadNibNamed("View", owner: self)?.first as! SideView
        slide3.movieImage.image = UIImage(named: "kgf")
        slide3.moviNameLbl.text = "kgf"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlidescrollView(slides: [SideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
       // scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        

        pageControl.currentPage = Int(pageIndex)
    }

}

