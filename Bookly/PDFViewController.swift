//
//  PDFViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 01.02.17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate, UIPageViewControllerDataSource {
    
   
    
    var pageController: UIPageViewController!
    
    var pdfDocument: CGPDFDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(cancleHandler))
        
        self.loadLocalPDF()
        
    }
    
    func cancleHandler ()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadLocalPDF() {
        
         let pdfAsData = UserDefaults.standard.object(forKey: purchasedLibraryArray[libararyId].pdfFile) as! Data
        let dataProvider = CGDataProvider(data: pdfAsData as CFData)
       
        self.pdfDocument = CGPDFDocument(dataProvider!)
        
        self.navigationItem.title = purchasedLibraryArray[libararyId].title
        self.preparePageViewController()
    }
    
   
    
    func preparePageViewController() {
        pageController = self.storyboard?.instantiateViewController(withIdentifier: "UIPageViewController") as! UIPageViewController
        
        self.pageController.dataSource = self
        
        self.addChildViewController(pageController)
        
        pageController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(pageController.view)
        
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFPageViewController") as! PDFPageViewController
        
        pageVC.pdfDocument = pdfDocument
        pageVC.pageNumber = pagesReadGenerally
        
        pageController.setViewControllers([pageVC], direction: .forward, animated: true, completion: nil)
        
    }
    
    let brain = LimitsBrain()
    
   
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageVC = viewController as! PDFPageViewController
        
        if pageVC.pageNumber! > 1 {
            
            let previousPageVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFPageViewController") as! PDFPageViewController
            
            previousPageVC.pdfDocument = pdfDocument
            previousPageVC.pageNumber =  pageVC.pageNumber! - 1
            
            purchasedLibraryArray[libararyId].curentPage -= 1
            pagesReadGenerally -= 1
            

            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
            userDefaults.set(encodedData, forKey: "purchasedArray")
            userDefaults.set(pagesReadGenerally, forKey: "pagesReadGenerally")
            userDefaults.synchronize()

            return previousPageVC
            }
        
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageVC = viewController as! PDFPageViewController
        
        let previousPageVC = self.storyboard?.instantiateViewController(withIdentifier: "PDFPageViewController") as! PDFPageViewController
            previousPageVC.pdfDocument = pdfDocument
            previousPageVC.pageNumber =  pageVC.pageNumber! + 1
        
        pagesReadGenerally += 1
        purchasedLibraryArray[libararyId].curentPage += 1
       
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
        userDefaults.set(pagesReadGenerally, forKey: "pagesReadGenerally")
        userDefaults.set(encodedData, forKey: "purchasedArray")
        userDefaults.synchronize()

        

        return previousPageVC
        }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        self.loadLocalPDF()
    }

    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        dump(error)
    }

}
