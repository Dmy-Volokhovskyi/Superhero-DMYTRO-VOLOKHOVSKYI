//
//  ProfileViewModel.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 22/02/2022.
//

import UIKit

class ProfileViewModel {
    
    var profileManager = ProfileManager.sharedInstance
    var profile  = ProfileManager.sharedInstance.userProfile
    let barButtonTitle = "Profile"
    var userName = "Name"
    let placeholderText = "Enter Your Name"
    let instructionText = "Select an option to display on the main screen"
    let addOptionsButtonText = "Add Options"
    let girlImage = UIImage(named: "girlBackgroundCut")
    let manlImage = UIImage(named: "manBackgroundCut")
    let whiteBackgroundColor = UIColor(named: "whiteBackground")
    let saveButtonTitle = "Save"
    let zeroValueMasage = "Zero Values Detected"
    let chooseAdviceMassage = "Chosen Fields mush have value."
    let confirmationMassage = "OK"
    let choseImageMassage = "Chosen Fields mush have value."
    let cameraOption = "Camera"
    let galeryOption = "Gallery"
    let deleteButtonText = "Delete"
    let cancelButtonText = "Cancel"
    let warningMassage = "Warning"
    let noCameraAcessMassage = "You don't have permission to access camera"
    let noGalleryAcessmassage = "You don't have permission to access gallery"
    let selectButtonTitle = "Select"
    let selectOptionTile = "Select Option"
    
    var profileImage = UIImageView ()
    
    var nameToSave : String?
    var nameHasChanged = false
    var dataHasChanged = false
    var didChangeImage = false
    
    var parameters: [BodyParameter]?
    var dateArray : [Date] = []
    var valuesArray : [Int32] = []
    var bodyparameterViewModel: [BodyParameterModel] = []
    
    var selectedParametersArray : [BodyParameterModel] = []
    
    
    var cameraImage : UIImage {
        let cameraImage = UIImage(named: "Camera")
        cameraImage?.withTintColor(.white)
        return cameraImage!
    }
    
    init() {
        profileManager.loadProfileInformation()
        fetchParameters()
        selectedParametersArray = selectedParameters()
        BodyParameterStorage.sharedInstance.compareArray = selectedParameters()
        profileImage.image = ProfileManager.sharedInstance.getUnwreppedImage()
    }
    
    func getbackgroundImage () -> UIImage? {
        if profile?.sex == "SUPERGIRL"{
            return girlImage
        }else {
            return manlImage
        }
    }
    
    private func fetchParameters() {
        guard let profile = profile else { return }
        
        parameters = Array(_immutableCocoaArray: profile.parameters!)
        
        if let parameters = parameters {
            bodyparameterViewModel = parameters.map({ parameter -> BodyParameterModel in
                createBodyParameterModel(with: parameter)
            })
        }
    }
    
    private func selectedParameters() -> [BodyParameterModel] {
        var fileterParameters: [BodyParameterModel] = []
        fileterParameters = bodyparameterViewModel.filter({ item in
            item.isChosen == true
        })
        return fileterParameters
    }
    
    private func createBodyParameterModel(with parameter: BodyParameter) -> BodyParameterModel {
        return BodyParameterModel(model: parameter)
    }
    
    func reloadData() {
        selectedParametersArray = selectedParameters()
    }
    
    func saveOptionsArray(parameters : [BodyParameterModel], and name : String?, and profileImage : UIImageView?) {
        var imageDataToSave : Data?
        if let profileImage = profileImage {
            imageDataToSave = Data()
            imageDataToSave = profileImage.image?.pngData()
        }else {
            imageDataToSave = ProfileManager.sharedInstance.userProfile?.profileImage
        }
        for parameter in bodyparameterViewModel {
            updateArrayValues(with: parameter)
        }
        for parameter in selectedParametersArray {
            updateArrayValues(with: parameter)
        }
        ProfileManager.sharedInstance.saveParameterChanges(newParameters: self.parameters, and: name, and: imageDataToSave)
    }
    
    private func updateArrayValues (with parameter : BodyParameterModel) {
        parameters = parameters.map { bodyParameter in
            if let bodyParameter = parameters?.first(where: { $0.parameterName == parameter.parameterName }) {
                bodyParameter.measureValue = parameter.measureValue
                bodyParameter.isChosen = parameter.isChosen
                bodyParameter.isToggled = parameter.isToggled
                bodyParameter.dates = parameter.dates
                bodyParameter.values = parameter.values
            }
            return bodyParameter
        }
    }
    
    func checkIfDifferent() -> Bool{
        let difference = selectedParametersArray.difference(from: BodyParameterStorage.sharedInstance.compareArray)
        if difference.insertions.isEmpty && difference.removals.isEmpty {
            dataHasChanged = false
            return false
        }else {
            dataHasChanged = true
            return true
        }
    }
    
    func checkForZeroValues(withAn arrayToCheck : [BodyParameterModel]) -> Bool{
        for item in arrayToCheck {
            if item.measureValue <= 0 {
                return true
            }
        }
        return false
    }
    
    func updateButtonState() -> Bool  {
        if nameHasChanged || dataHasChanged || didChangeImage {
            return true
        }else {
            return false
        }
    }
    
    func deleteItem (with bodyParameter : BodyParameterModel) {
        if let delete = bodyparameterViewModel.firstIndex(where: { $0.parameterName == bodyParameter.parameterName }) {
            bodyparameterViewModel[delete].isChosen = false
            bodyparameterViewModel[delete].isToggled = false
            dataHasChanged = checkIfDifferent()
        }
    }
}

