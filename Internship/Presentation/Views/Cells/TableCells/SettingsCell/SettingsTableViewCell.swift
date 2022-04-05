//
//  SettingsTableViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import UIKit


class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var atributeName: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var measurementUnit: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var valueTextField: UITextField!
    
    
    var originalValue : Int32?
    var delegate : SettingsTableViewCellDelegate?
    static let cellID = "SettingsTableViewCell"
    
    var operableArray : [BodyParameterModel]?
    private var localIndex : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(parameter : [BodyParameterModel],and indexPath : Int) {
        
        valueTextField.delegate = self
        localIndex = indexPath
        self.operableArray = parameter
        atributeName.text = parameter[localIndex].parameterName
        atributeName.font = UIFont.getCustomFont(.SairaRomanMedium, 18)

        measurementUnit.text = parameter[localIndex].measuredIn
        measurementUnit.font = UIFont.getCustomFont(.HelveticaNeue, 18)
        measurementUnit.textColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    
        valueTextField.text = "\(parameter[localIndex].measureValue)"
        valueTextField.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        valueTextField.textColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        statusSwitch.isOn = parameter[localIndex].isToggled
        statusSwitch.onTintColor = UIColor.getCustomOrangeColor()
        
        originalValue = parameter[localIndex].measureValue
        
        atributeName.textColor = .white
        measurementUnit.textColor = .white
        valueTextField.textColor = .white
        valueTextField.borderStyle = .none
        valueTextField.keyboardType = .numberPad
        addDoneButtonOnKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        backgroundColor = .clear
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.didChangeValue(with: localIndex, and: sender.isOn)
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .black
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.valueTextField.inputAccessoryView = doneToolbar
        valueTextField.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        valueTextField.resignFirstResponder()
    }
    
}
extension SettingsTableViewCell : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkValuesAndDate()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValuesAndDate()
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 3
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.delegate?.keyboardIsShown(sender: notification)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.delegate?.keyboardIsHidden(sender: notification)
    }
    private func checkValuesAndDate () {
        
        let currentDateTime = Date()
        let stringValue = valueTextField.text ?? "0"
        let value  = Int(stringValue) ?? 0
        
        if operableArray != nil {
            if operableArray?[localIndex].values == [] && operableArray?[localIndex].dates == []{
                operableArray![localIndex].values.append(Int32(value))
                operableArray![localIndex].dates.append(currentDateTime)
            }else {
                let diffInDays = Calendar.current.dateComponents([.minute], from: operableArray![localIndex].dates.last!, to: currentDateTime).minute
                if (diffInDays ?? 0) < 1{
                    operableArray![localIndex].values.remove(at: operableArray![localIndex].values.count - 1 )
                    operableArray![localIndex].values.append(Int32(value))
                }else{
                    operableArray![localIndex].values.append(Int32(value))
                    operableArray![localIndex].dates.append(currentDateTime)
                }
            }
        }
        if value == originalValue ?? 0 {
            lineView.backgroundColor = .white
        }else {
            lineView.backgroundColor = UIColor.getCustomOrangeColor()
        }
        delegate?.didChangeValue(with: localIndex, and: true)
        delegate?.checkNumbers(with: localIndex, and: Int32(value), operableArray![localIndex].values, operableArray![localIndex].dates)
    }
}

