import UIKit

class DetailsVC: UIViewController {

    private var detailsView: DetailsView
    private let viewModel: DetailsVM
    var task: Task!
    
    //MARK: - Setup
    
    init(id: Int) {
        self.viewModel = DetailsVM(IDTask: id)
        self.detailsView = DetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsMain()
    }
    
    private func settingsMain(){
        showData()
        buttonCall()
    }
    
    
    
    //MARK: - main
    
    private func showData(){        
        detailsView.emojiField.text = task.emoji
        detailsView.titleField.text = task.title
        detailsView.DescriptionField.text = task.description
        detailsView.dateField.text =  task.date
        detailsView.terminatedField.isOn = task.terminated
        
        detailsView.datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        detailsView.dateField.inputView = detailsView.datePicker
    }
    
    
    
    // MARK: - button action
    
    
    private func buttonCall(){
        detailsView.deleteButton.addTarget(self, action: #selector(TapButtonDelete), for: .touchUpInside)
        detailsView.saveButton.addTarget(self, action: #selector(TapButtonSave), for: .touchUpInside)
    }
    
    @objc func TapButtonDelete(){
        let alert = UIAlertController(
            title: "Deletar",
            message: "Deseja deletar essa tarefa",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confimar", style: .default, handler: { _ in
            self.viewModel.deleteTask() { success in
                guard success == true else {
                    self.present(Utilities.Alert(Title: "Erro!", messageAlert: "Erro ao excluir tarefa"), animated: true)
                    return
                }
                
                self.present(Utilities.Alert(Title: "Sucesso!", messageAlert: "Tarefa  excluir"), animated: true)
            }
        }))
        present(alert, animated: true)
    }
    
    @objc func TapButtonSave(){
        var objectTask = task
        objectTask?.emoji = detailsView.emojiField.text!
        objectTask?.title = detailsView.titleField.text!
        objectTask?.description = detailsView.DescriptionField.text!
        objectTask?.date = detailsView.dateField.text!
        objectTask?.terminated = detailsView.terminatedField.isOn
        
        viewModel.updateTask(datas: objectTask!) { success in
            guard success == true else {
                self.present(Utilities.Alert(Title: "Erro!", messageAlert: "Erro ao atualizar tarefa"), animated: true)
                return
            }
            
            self.present(Utilities.Alert(Title: "Sucesso!", messageAlert: "Atualização feita com sucesso "), animated: true)
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        detailsView.dateField.text = formatter.string(from: sender.date)
    }
}
