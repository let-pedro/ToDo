import UIKit

class HomeVC: UIViewController {
    
    private var homeView: HomeView
    private let viewModel: HomeVM
    private var listTask: [Task] = []
    
    //MARK: - Setup
    
    
    init() {
        self.viewModel = HomeVM()
        self.homeView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsMain()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateList()
    }
    
    private func updateList(){
        viewModel.getAllTasks() { success in
            self.listTask = success
        }
    }
    
    
    private func settingsMain(){
        setDelegates()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        title = "Minhas Tarefas"
        
        let addButton = UIButton(type: .system)
        addButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        addButton.addTarget(self, action: #selector(TapButtonCreatedNewList), for: .touchUpInside)
    }
    
    
    //MARK: - main
    
    private func setDelegates(){
        homeView.TasksCollections.delegate = self
        homeView.TasksCollections.dataSource = self
    }
    
    
    private func submitdData(titleTask: String){
        let newTask = Task(title: titleTask)
        viewModel.createTask(datas: newTask) { [self] success in
            guard success == true else {
                self.present(Utilities.Alert(Title: "Erro!", messageAlert: "Erro ao cadastrada Tarefa"), animated: true)
                return
            }
            
            self.present(Utilities.Alert(Title: "Sucesso!", messageAlert: "Tarefa cadastrada com Sucesso"), animated: true)
            self.updateList()
        }
    }
    
    
    
    // MARK: - button action

    
    @objc func TapButtonCreatedNewList(){
        let alert = UIAlertController(
            title: "Nova Tarefa",
            message: "Digita um nome para está Tarefa.",
            preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Nome da Tarefa"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confimar", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 1 else {
                return
            }
            
            let titleField = fields[0]
            guard let titleTask = titleField.text, !titleTask.isEmpty else {
                return
            }
            
            self.submitdData(titleTask: titleTask)
        }))
        present(alert, animated: true)
    }
}

    // MARK: -  Extensions

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTask.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTaskCell
        cell.data = listTask[indexPath.row]
        cell.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.961, alpha: 1).cgColor
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width-34, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTask = listTask[indexPath.item]
        let DetailScene = DetailsVC(id: selectedTask.id)
        DetailScene.task = selectedTask
        present(DetailScene, animated: true)
    }
}
