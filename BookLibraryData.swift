//
//  BookLibraryData.swift
//  Bookly
//
//  Created by Artem Nazarov on 1/24/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import Foundation
import UIKit

class BookDataStructure:NSObject,NSCoding {
    
    var title: String
    var author: String
    var image: UIImage
    var price: Int
    var curentPage: Int
    var pageAmount:Int
    var inTheMiddleOfReading:Bool
    var pdfFile:String
    var finishedReading: Bool
    
    init(title:String,author:String,image:UIImage,price:Int,curentPage:Int,pageAmount:Int,inTheMiddleOfReading:Bool,pdfFile:String,finishedReading:Bool) {
        self.author = author
        self.curentPage = curentPage
        self.image = image
        self.price = price
        self.title = title
        self.pageAmount = pageAmount
       self.inTheMiddleOfReading = inTheMiddleOfReading
        self.pdfFile = pdfFile
        self.finishedReading = finishedReading

    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let price = aDecoder.decodeInteger(forKey: "price")
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let author = aDecoder.decodeObject(forKey: "author") as! String
        let curentPage = aDecoder.decodeInteger(forKey: "curentPage") 
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        let pageAmount = aDecoder.decodeInteger(forKey: "pageAmount")
        let inTheMiddleOfReading = aDecoder.decodeBool(forKey: "middle")
        let pdfFile = aDecoder.decodeObject(forKey: "pdfFile") as! String
        let finishedReading = aDecoder.decodeBool(forKey: "finishedReading")
        self.init(title:title,author:author,image:image,price:price,curentPage:curentPage,pageAmount:pageAmount,inTheMiddleOfReading:inTheMiddleOfReading,pdfFile:pdfFile,finishedReading:finishedReading)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(price, forKey: "price")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(author, forKey: "author")
        aCoder.encode(curentPage, forKey: "curentPage")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(pageAmount, forKey: "pageAmount")
        aCoder.encode(inTheMiddleOfReading, forKey: "middle")
        aCoder.encode(pdfFile, forKey: "pdfFile")
        aCoder.encode(finishedReading, forKey: "finishedReading")
    }
    
}


var bookLibraryArray: [BookDataStructure] = [
    
    BookDataStructure(title: "To Kill a Mockingbird", author: "Harper Lee", image: UIImage(named:"To_Kill_a_Mockingbird")!, price: 900, curentPage: 1, pageAmount: 895, inTheMiddleOfReading: false, pdfFile: "To Kill a Mockingbird.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Great Gatsby", author: "F. Scott Fitzgerald", image: UIImage(named:"TheGreatGatsby_1925jacket")!, price: 450, curentPage: 1, pageAmount: 433, inTheMiddleOfReading: false, pdfFile: "The Great Gatsby.pdf", finishedReading: false),
    
    BookDataStructure(title: "Macbeth", author: "William Shakespeare", image: UIImage(named:"2e9daf4f2ae13490d09228cd7eb575a7")!, price: 350, curentPage: 1, pageAmount: 340, inTheMiddleOfReading: false, pdfFile: "Macbeth.pdf", finishedReading: false),
    
    BookDataStructure(title: "Hamlet", author: "William Shakespeare", image: UIImage(named:"40163996e5493bdb29a2c2335657bb59")!, price: 420, curentPage: 1, pageAmount: 420, inTheMiddleOfReading: false, pdfFile: "Hamlet.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Catcher In The Rye", author: "J.D. Salinger", image: UIImage(named:"Rye_catcher")!, price: 480, curentPage: 1, pageAmount: 472, inTheMiddleOfReading: false, pdfFile: "The Catcher In The Rye.pdf", finishedReading: false),
    
    BookDataStructure(title: "Romeo and Juliet", author: "William Shakespeare", image: UIImage(named:"romeo-and-juliet")!, price: 300, curentPage: 1, pageAmount: 279, inTheMiddleOfReading: false, pdfFile: "Romeo and Juliet.pdf", finishedReading: false),
    
    BookDataStructure(title: "Animal Farm", author: "George Orwell", image: UIImage(named:"9780143416319")!, price: 300, curentPage: 1, pageAmount: 299, inTheMiddleOfReading: false, pdfFile: "Animal Farm.pdf", finishedReading: false),
    
    BookDataStructure(title: "1984", author: "George Orwell", image: UIImage(named:"orwell1984preywo - Unknown")!, price: 2050, curentPage: 1, pageAmount: 2044, inTheMiddleOfReading: false, pdfFile: "1984.pdf", finishedReading: false),
    
    BookDataStructure(title: "Lord Of The Flies", author: "William Golding", image: UIImage(named:"lord-of-the-flies-cover-image")!, price: 520, curentPage: 1, pageAmount: 517, inTheMiddleOfReading: false, pdfFile: "Lord Of The Flies.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Scarlet Letter", author: "Nathaniel Hawthorne", image: UIImage(named:"Scarlet Letter, The - Nathaniel Hawthorne")!, price: 520, curentPage: 1, pageAmount: 519, inTheMiddleOfReading: false, pdfFile: "The Scarlet Letter.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Odyssey", author: "Homer", image: UIImage(named:"the-odyssey")!, price: 740, curentPage: 1, pageAmount: 735, inTheMiddleOfReading: false, pdfFile: "The Odyssey.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Diary Of A Young Girl", author: "Anne Frank", image: UIImage(named:"519HKX9M69L._SY344_BO1,204,203,200_")!, price: 900, curentPage: 1, pageAmount: 888, inTheMiddleOfReading: false, pdfFile: "The Diary Of A Young Girl.pdf", finishedReading: false),
    
    BookDataStructure(title: "Of Mice and Men", author: "John Steinbeck", image: UIImage(named:"OfMiceAndMen")!, price: 340, curentPage: 1, pageAmount: 332, inTheMiddleOfReading: false, pdfFile: "Of Mice and Men.pdf", finishedReading: false),
    
    BookDataStructure(title: "Adventures of Huckleberry Finn", author: "Mark Twain", image: UIImage(named:"Adventures of Huckleberry Finn, The - Mark Twain")!, price: 1050, curentPage: 1, pageAmount: 1036, inTheMiddleOfReading: false, pdfFile: "Adventures of Huckleberry Finn.pdf", finishedReading: false),
    
    BookDataStructure(title: "Frankenstein", author: "Mary Wollstonecraft Shelley", image: UIImage(named:"frankenstein")!, price: 950, curentPage: 1, pageAmount: 939, inTheMiddleOfReading: false, pdfFile: "Frankenstein.pdf", finishedReading: false),
    
    BookDataStructure(title: "Wuthering Heights", author: "Emily Bronte", image: UIImage(named:"wuthering-heights")!, price: 1450, curentPage: 1, pageAmount: 1448, inTheMiddleOfReading: false, pdfFile: "Wuthering Heights.pdf", finishedReading: false),
    
    BookDataStructure(title: "Julius Caesar", author: "William Shakespeare", image: UIImage(named:"julius-caesar")!, price: 290, curentPage: 1, pageAmount: 289, inTheMiddleOfReading: false, pdfFile: "Julius Caesar.pdf", finishedReading: false),
    
    BookDataStructure(title: "Midsummer Night's Dream", author: "William Shakespeare", image: UIImage(named:"Midsummer Night's Dream")!, price: 215, curentPage: 1, pageAmount: 215, inTheMiddleOfReading: false, pdfFile: "Midsummer Night's Dream.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Grapes of Wrath", author: "John Steinbeck", image: UIImage(named:"The Grapes of Wrath")!, price: 1290, curentPage: 1, pageAmount: 1285, inTheMiddleOfReading: false, pdfFile: "The Grapes of Wrath.pdf", finishedReading: false),
    
    BookDataStructure(title: "Brave New World", author: "Aldous Leonard Huxley", image: UIImage(named:"Brave New World")!, price: 560, curentPage: 1, pageAmount: 559, inTheMiddleOfReading: false, pdfFile: "Brave New World.pdf", finishedReading: false),
    
    BookDataStructure(title: "Night", author: "Elie Wiesel", image: UIImage(named:"eliewiesel-nightfulltext 3 26 2014 3 23 04 pm - Unknown")!, price: 450, curentPage: 1, pageAmount: 442, inTheMiddleOfReading: false, pdfFile: "Night.pdf", finishedReading: false),
    
    BookDataStructure(title: "Pride and Prejudice", author: "Jane Austen", image: UIImage(named:"pride-and-prejudice-book-cover")!, price: 1400, curentPage: 1, pageAmount: 1393, inTheMiddleOfReading: false, pdfFile: "Pride and Prejudice.pdf", finishedReading: false),
    
    BookDataStructure(title: "Beowulf", author: "Samuel Harden Church", image: UIImage(named:"424d95ae8a63aacfe6f5eda0fc35f8e8")!, price: 300, curentPage: 1, pageAmount: 293, inTheMiddleOfReading: false, pdfFile: "Beowulf.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Outsiders", author: "S. E. Hinton", image: UIImage(named:"The_Outsiders_book")!, price: 350, curentPage: 1, pageAmount: 350, inTheMiddleOfReading: false, pdfFile: "The Outsiders.pdf", finishedReading: false),
    
    BookDataStructure(title: "Great Expectations", author: "Charles Dickens", image: UIImage(named:"708939_orig")!, price: 2250, curentPage: 1, pageAmount: 2235, inTheMiddleOfReading: false, pdfFile: "Great Expectations.pdf", finishedReading: false),
    
    BookDataStructure(title: "Tale of Two Cities", author: "Charles Dickens", image: UIImage(named:"Tale of Two Cities")!, price: 1750, curentPage: 1, pageAmount: 1716, inTheMiddleOfReading: false, pdfFile: "Tale of Two Cities.pdf", finishedReading: false),
    
    BookDataStructure(title: "The Crucible", author: "Arthur Miller", image: UIImage(named:"The Crucible")!, price: 500, curentPage: 1, pageAmount: 446, inTheMiddleOfReading: false, pdfFile: "The Crucible.pdf", finishedReading: false),
    
    BookDataStructure(title: "Fahrenheit 451", author: "Ray Bradbury", image: UIImage(named:"Fahrenheit 451")!, price: 460, curentPage: 1, pageAmount: 453, inTheMiddleOfReading: false, pdfFile: "Fahrenheit 451.pdf", finishedReading: false),
    
    BookDataStructure(title: "Jane Eyre", author: "Charlotte Bronte", image: UIImage(named:"Jane Eyre")!, price: 2300, curentPage: 1, pageAmount: 2295, inTheMiddleOfReading: false, pdfFile: "Jane Eyre.pdf", finishedReading: false),
    
  
]


var purchasedLibraryArray: [BookDataStructure] = []

