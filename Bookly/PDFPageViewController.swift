//
//  PDFPageViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 01.02.17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

class PDFPageView: UIView {
    var pdfDocument: CGPDFDocument? = nil
    var pageNumber: Int? = nil
    override func draw(_ rect: CGRect) {
        if pdfDocument != nil {
            let ctx = UIGraphicsGetCurrentContext()
            
            UIColor.white.set()
            
            ctx?.fill(rect)
            
            _ = ctx?.ctm
            _ = ctx?.scaleBy(x: 1, y: -1)
            _ = ctx?.translateBy(x: 0, y: -rect.size.height)
            
            let page = pdfDocument?.page(at: pageNumber!)
            
            let pageRect = page?.getBoxRect(CGPDFBox.cropBox)
            
            let ratioW = rect.size.width / (pageRect?.size.width)!
            let ratioH = rect.size.height / (pageRect?.size.height)!
            
            let ratio = min(ratioW, ratioH)
            
            let newWidth = (pageRect?.size.width)! * ratio
            let newHeight = (pageRect?.size.height)! * ratio
            
            let offsetX = (rect.size.width - newWidth)
            let offsetY = (rect.size.height - newHeight-100)
            
            ctx?.scaleBy(x: newWidth / (pageRect?.size.width)!, y: newHeight / (pageRect?.size.height)!)
            ctx?.translateBy(x: -(pageRect?.origin.x)! + offsetX, y: -(pageRect?.origin.y)! + offsetY)
            
            ctx?.drawPDFPage(page!)
        }
    }
}

class PDFPageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    
    var pdfDocument: CGPDFDocument? = nil
    var pageNumber: Int? = nil
    
    @IBOutlet weak var page: PDFPageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        numberOfPagesLabel.text = "Page \(purchasedLibraryArray[libararyId].curentPage)"
        
        // Do any additional setup after loading the view.
        self.preparePDFPage()
        
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if purchasedLibraryArray[libararyId].pageAmount < purchasedLibraryArray[libararyId].curentPage && purchasedLibraryArray[libararyId].inTheMiddleOfReading{
            let alert = UIAlertController(title: "Congradulations!", message: "You have finished reading your book. You can read it over when the schedule time is up.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {(action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
            purchasedLibraryArray[libararyId].curentPage -= 1
            
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: purchasedLibraryArray)
            userDefaults.set(encodedData, forKey: "purchasedArray")
            userDefaults.synchronize()
            }
            
        

    }
    
    func preparePDFPage() {
        page.pdfDocument = self.pdfDocument
        page.pageNumber = self.pageNumber
        
        page.setNeedsDisplay()

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return page
    }

}
