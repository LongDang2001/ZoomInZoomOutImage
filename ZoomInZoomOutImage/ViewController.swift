//
//  ViewController.swift
//  ZoomInZoomOutImage
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @ IBOutlet weak var scrollView: UIScrollView!
    @ IBOutlet weak var imageView: UIImageView!
    var image = UIImage(named: "tocngan3")
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSizeForImageView(size: image!.size)
        updateMinZoomScaleForSize(size: view.bounds.size)
        imageView.image = image
    }

    private func updateSizeForImageView(size: CGSize) {
        imageView.center = view.center
        imageView.frame.size = CGSize(width: size.width, height: size.height)
        
    }

    private func updateMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    private func updateConstraintsForSize(size: CGSize) {
        let realHeight = imageView.bounds.height * scrollView.zoomScale
        let readWidth = imageView.bounds.width * scrollView.zoomScale
        let deltaHeight = view.bounds.height - realHeight
        let deltaWidth = view.bounds.width - readWidth
        let yOffset = max(0, deltaHeight/2)
        let xOffset = max(0, deltaWidth/2)
        imageView.frame.origin = CGPoint(x: xOffset, y: yOffset)
//        CGPointMake(xOffset, yOffset)
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateConstraintsForSize(size: view.bounds.size)
    }
}

