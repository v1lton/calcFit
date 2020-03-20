//
//  ViewController.swift
//  calcFit
//
//  Created by Wilton Ramos on 20/03/20.
//  Copyright © 2020 Wilton Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //****Attributes****
    var trainingSheet = TrainingSheet()
    let datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    let arrayExercisesToPickerView = ["Agachamento Smith", "Crucifixo Reto", "Flexão Básica", "Paralelas", "Supino Reto", "Supino Inclinado"]
    
    //****IBs****
    //Buttons
    @IBAction func insertButton() {
        if (exerciseTextField.text != "" && repetitionTextField.text != "" && serieTextField.text != ""){
            appendExerciseToTrainingSheet()
            cleanTextFields()
            insertNewCellInTableView()
        } else {
            let alertController = UIAlertController(title: "Campo não inserido", message: "É necessário inserir as informações nos 3 campos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"OK", style: .cancel))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func calculeButton() {
        let result = trainingSheet.totalTime()
        showResult(result: result)
    }
    
    //TableViews
    @IBOutlet var tableView: UITableView!
    
    //TextFields
    @IBOutlet var exerciseTextField: UITextField!
    @IBOutlet var repetitionTextField: UITextField!
    @IBOutlet var serieTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    
    //****Functions****
    //Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        hideKeyboard()
        //DatePicker
        createDatePicker()
        dateTextField.textAlignment = .center
        configurePickerView()
        configureExerciseTextField()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingSheet.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingSheetTableViewCell", for: indexPath) as! TrainingSheetTableViewCell
        cell.exerciseLabel.text = trainingSheet.exercises[indexPath.row].exercise
        cell.repetitionLabel.text = String(trainingSheet.exercises[indexPath.row].repetition)
        cell.serieLabel.text = String(trainingSheet.exercises[indexPath.row].serie)
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trainingSheet.exercises.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayExercisesToPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayExercisesToPickerView[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exerciseTextField.text = arrayExercisesToPickerView[row]
        exerciseTextField.resignFirstResponder()
    }
    
    //My Functions
    func appendExerciseToTrainingSheet() {
        let exercise = exerciseTextField.text!
        let repetition = Int(repetitionTextField.text!)!
        let serie = Int(serieTextField.text!)!
        let exerciseClass = Exercise(Exercise: exercise, Repetition: repetition, Serie: serie)
        trainingSheet.exercises.append(exerciseClass)
    }
    
    func cleanTextFields() {
        exerciseTextField.text = ""
        repetitionTextField.text = ""
        serieTextField.text = ""
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    func insertNewCellInTableView() {
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        dateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
    }
    
    func configureExerciseTextField() {
        exerciseTextField.inputView = pickerView
    }
    
    func showResult(result: Int) {
        if (trainingSheet.exercises.count == 0) {
            let alertController = UIAlertController(title: "Por favor, inserir os exercícios", message: "Você tem que inserir ao menos um exercício", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title:"OK", style: .cancel))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let title = "\(result) minutos"
            let alertController = UIAlertController(title: title, message: "será o tempo necessário", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

