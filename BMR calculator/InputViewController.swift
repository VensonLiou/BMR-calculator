//
//  InputViewController.swift
//  BMR calculator
//
//  Created by 劉玟慶 on 2019/4/15.
//  Copyright © 2019 劉玟慶. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {

 
    @IBOutlet weak var birthdayWarning: UILabel!
    @IBOutlet weak var heightWarning: UILabel!
    @IBOutlet weak var weightWarning: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var fatTitle: UILabel!
    @IBOutlet weak var fatSliderOutlet: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButtonOutlet: UIButton!
    @IBOutlet weak var checked: UIButton!
    
    let MINIMUM_AGE = 15
    let MAXIMUM_AGE = 80
    let MINIMUM_HEIGHT = 60.0
    let MAXIMUM_HEIGHT = 275.0
    let MINIMUM_WEIGHT = 20.0
    let MAXIMUM_WEIGHT = 300.0
    var bmr: Double = 0.0
    var isAllValueValid = false
    var isBirthdayValid = false
    var isWeightValid = false
    var isHeightValid = false
    var gender = "Male"
    var isAdvancedOption = false
    var fat:Float = 50.0
    var age = 0
    var height: Double = 0.0
    var weight: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        birthdayWarning.isHidden = true
        heightWarning.isHidden = true
        weightWarning.isHidden = true
        fatTitle.isHidden = true
        fatLabel.isHidden = true
        fatSliderOutlet.isHidden = true
        calculateButtonOutlet.isEnabled = false
        checked.isHidden = true
        // add done button to number pads
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneClick))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneButton)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        heightTextField.inputAccessoryView = doneToolbar
        weightTextField.inputAccessoryView = doneToolbar
    }
    
    func setFat(_ fat: Float)
    {
        self.fat = fat
        fatLabel.text = String(format: "%.1f", fat) + "%"
        fatSliderOutlet.value = fat
    }
    
    func updateAllValid()
    {
        isAllValueValid = isBirthdayValid && isHeightValid && isWeightValid
        checked.isHidden = !isAllValueValid
        calculateButtonOutlet.isEnabled = isAllValueValid
    }
    
    func calculateAge(_ birthday: Date)
    {
        let now = Date()
        let nowDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: now)
        let birthdayDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: birthday)
        age = nowDateComponents.year! - birthdayDateComponents.year!
        if nowDateComponents.month! < birthdayDateComponents.month!
        {
            age -= 1
        }
        else if nowDateComponents.month! == birthdayDateComponents.month!
        {
            if nowDateComponents.day! < birthdayDateComponents.day!
            {
                age -= 1
            }
        }
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -80, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -80, up: false)
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.25
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
    @IBAction func heightEditingChange(_ sender: UITextField)
    {
        height = 0.0
        if let inputHeightText = heightTextField?.text, let height = Double(inputHeightText)
        {
            self.height = height
        }
        if height > MAXIMUM_HEIGHT || height < MINIMUM_HEIGHT
        {
            isHeightValid = false
            heightWarning.isHidden = false
            updateAllValid()
        }
        else
        {
            isHeightValid = true
            heightWarning.isHidden = true
            updateAllValid()
        }
    }
    
    @IBAction func weightEditingChange(_ sender: UITextField)
    {
        weight = 0.0
        if let inputWeightText = weightTextField?.text, let weight = Double(inputWeightText)
        {
            self.weight = weight
        }
        if weight > MAXIMUM_WEIGHT || weight < MINIMUM_WEIGHT
        {
            isWeightValid = false
            weightWarning.isHidden = false
            updateAllValid()
        }
        else
        {
            isWeightValid = true
            weightWarning.isHidden = true
            updateAllValid()
        }
    }
    
    @objc func doneClick()
    {
        view.endEditing(true)
    }
    
    @IBAction func genderSegmentedAction(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            gender = "Male"
        }
        else
        {
            gender = "Female"
        }
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker)
    {
        calculateAge(datePicker.date)
        if age > MAXIMUM_AGE || age < MINIMUM_AGE
        {
            isBirthdayValid = false
            birthdayWarning.isHidden = false
            updateAllValid()
        }
        else
        {
            isBirthdayValid = true
            birthdayWarning.isHidden = true
            updateAllValid()
        }
    }
    
    
    @IBAction func advancedOptionAction(_ sender: UISwitch)
    {
        if sender.isOn
        {
            isAdvancedOption = true
            fatTitle.isHidden = false
            fatLabel.isHidden = false
            fatSliderOutlet.isHidden = false
            setFat(50.0)
        }
        else
        {
            isAdvancedOption = false
            fatTitle.isHidden = true
            fatLabel.isHidden = true
            fatSliderOutlet.isHidden = true
        }
        
    }
    
    @IBAction func fatSliderAction(_ sender: UISlider)
    {
        setFat(sender.value)
    }
    
    @IBAction func calculateClick(_ sender: UIButton)
    {
        if isAdvancedOption
        {
            bmr = 370.0 + 21.6 * (1.0 - Double(fat) / 100.0) * weight
        }
        else
        {
            if gender == "Male"
            {
                bmr = 13.397 * weight + 4.799 * height - 5.677 * Double(age) + 88.362
            }
            else
            {
                bmr = 9.247 * weight + 3.098 * height - 4.330 * Double(age) + 447.593
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
        vc?.isAdvancedOption = isAdvancedOption
        vc?.gender = gender
        vc?.bmr = bmr
        vc?.bodyFat = fat
        navigationController?.pushViewController(vc!, animated: true)
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
