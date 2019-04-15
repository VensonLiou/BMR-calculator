//
//  ResultViewController.swift
//  BMR calculator
//
//  Created by 劉玟慶 on 2019/4/14.
//  Copyright © 2019 劉玟慶. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var isAdvancedOption = false
    var gender = ""
    var bmr = 0.0
    var bodyFat: Float = 0.0
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var bmrResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resultImage.image = UIImage(named: getFatLevelImage())
        bmrResult.text = String(format: "%.2f", bmr)
    }

    func getFatLevelImage() -> String
    {
        var level = 0
        if isAdvancedOption
        {
            if gender == "Male"
            {
                if bodyFat > 25
                {
                    level = 1
                }
                else if bodyFat > 18 && bodyFat <= 25
                {
                    level = 2
                }
                else if bodyFat > 14 && bodyFat <= 18
                {
                    level = 3
                }
                else if bodyFat > 6 && bodyFat <= 14
                {
                    level = 4
                }
                else if bodyFat >= 0 && bodyFat <= 6
                {
                    level = 5
                }
            }
            else
            {
                if bodyFat > 32
                {
                    level = 1
                }
                else if bodyFat > 25 && bodyFat <= 32
                {
                    level = 2
                }
                else if bodyFat > 21 && bodyFat <= 25
                {
                    level = 3
                }
                else if bodyFat > 14 && bodyFat <= 21
                {
                    level = 4
                }
                else if bodyFat >= 0 && bodyFat <= 14
                {
                    level = 5
                }
            }
        }
        else
        {
            level = 5
        }
        return gender + String(level)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
