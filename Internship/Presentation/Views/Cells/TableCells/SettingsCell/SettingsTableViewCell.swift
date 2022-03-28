//
//  SettingsTableViewCell.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 14/03/2022.
//

import UIKit

protocol SettingsTableViewCellDelegate {
    func didChangeValue(with operableArray : [BodyParameterModel])
    func checkNumbers(with operableArray : [BodyParameterModel])
}

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var atributeName: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var measurementUnit: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
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
        measurementUnit.text = parameter[localIndex].measuredIn
        if parameter[localIndex].measureValue == nil {
            valueTextField.text = "0"
        }else {
            valueTextField.text = parameter[localIndex].measureValue
        }
        valueTextField.text = parameter[localIndex].measureValue
        statusSwitch.isOn = parameter[localIndex].isToggled
        print(parameter[localIndex].isToggled)
       
        atributeName.textColor = .white
        measurementUnit.textColor = .white
        valueTextField.textColor = .white
        valueTextField.borderStyle = .none
        addDoneButtonOnKeyboard()
        backgroundColor = .clear
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        operableArray?[localIndex].isToggled = statusSwitch.isOn
        delegate?.didChangeValue(with: operableArray!)
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
        print ("Done")
        valueTextField.resignFirstResponder()
    }
    
    
}
extension SettingsTableViewCell : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        operableArray?[localIndex].measureValue = valueTextField.text
        
        delegate?.checkNumbers(with: operableArray!)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didChangeValue(with: operableArray!)
    }
}

