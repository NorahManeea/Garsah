//
//  WalkThroughViewController.swift
//  Garsah
//
//  Created by Norah Almaneea on 19/05/2022.
//

import UIKit

class WalkThroughViewController: UIViewController {
    
    //MARK: - IBOutlet

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var slides: [WalkThroughSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
            WalkThroughSlide(title: "Buy plants and accessories ", description: "Wide variety of plants are available for you", image: #imageLiteral(resourceName: "Next Button")),
            WalkThroughSlide(title: "Buy plants and accessories ", description: "Wide variety of plants are available for you", image: #imageLiteral(resourceName: "Next Button")),
            WalkThroughSlide(title: "Buy plants and accessories ", description: "Wide variety of plants are available for you", image: #imageLiteral(resourceName: "Next Button"))
        ]

        
    }
 
    //MARK: - Next Button Function
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1{
            let controller = storyboard?.instantiateViewController(identifier: "MainVC") as! ViewController
            controller.modalPresentationStyle = .fullScreen
           present(controller, animated: true, completion: nil)
            
        }else{
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension WalkThroughViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier.WalkThroughCell, for: indexPath) as! WalkThroughCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
}
