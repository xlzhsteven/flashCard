//
//  ViewController.swift
//  FlashCard
//
//  Created by Zhang, Xiaolong on 6/8/14.
//  Copyright (c) 2014 Zhang, Xiaolong. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var question:UITextField!
    @IBOutlet var answer:UITextField!
    @IBOutlet var display:UITextView!
    
    @IBAction func btnsave(){
        var appDel:AppDelegate=UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var cardInfo = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: context) as NSManagedObject
        cardInfo.setValue(""+question.text, forKey: "question")
        cardInfo.setValue(""+answer.text, forKey: "answer")
        context.save(nil)
        question.text=""
        answer.text=""
    }
    @IBAction func btnLoad(){
        var appDel:AppDelegate=UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Card")
        request.returnsObjectsAsFaults=false
        request.predicate = NSPredicate(format: "question = %@", ""+question.text)
        var results:NSArray = context.executeFetchRequest(request, error: nil)
        if results.count>0 {
            var res = results[0] as NSManagedObject
            question.text = res.valueForKey("question") as String
            display.text = res.valueForKey("answer") as String
        } else {
            println("something went wrong")
        }
        
    }
    
    
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

