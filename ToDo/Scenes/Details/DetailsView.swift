import UIKit

class DetailsView: UIView {

    lazy var emojiField : UITextField = {
        let Field = UITextField(frame: .zero)
        Field.layer.cornerRadius = 8
        Field.font = UIFont.systemFont(ofSize: 50)
        Field.textAlignment = .center
        Field.layer.cornerRadius = 50
        Field.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.961, alpha: 1).cgColor
        Field.translatesAutoresizingMaskIntoConstraints = false
        return Field
    }()
    
    lazy var titleField : UITextField = {
        let Field = UITextField(frame: .zero)
        Field.layer.cornerRadius = 8
        Field.placeholder = "Titulo"
        Field.keyboardType = .default
        Field.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.961, alpha: 1).cgColor
        Field.translatesAutoresizingMaskIntoConstraints = false
        return Field
    }()
    
    
    lazy var DescriptionField : UITextField = {
        let Field = UITextField(frame: .zero)
        Field.layer.cornerRadius = 8
        Field.placeholder = "Descrição da Tarefa"
        Field.keyboardType = .default
        Field.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.961, alpha: 1).cgColor
        Field.translatesAutoresizingMaskIntoConstraints = false
        return Field
    }()
    
    lazy var dateField : UITextField = {
        let Field = UITextField(frame: .zero)
        Field.layer.cornerRadius = 8
        Field.placeholder = "Data de finalização"
        Field.keyboardType = .default
        Field.textColor = .blue
        Field.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.961, alpha: 1).cgColor
        Field.translatesAutoresizingMaskIntoConstraints = false
        return Field
    }()
    
    lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var terminatedField : UISwitch = {
        let _switch = UISwitch()
        _switch.tintColor = .blue
        _switch.isOn = false
        _switch.translatesAutoresizingMaskIntoConstraints = false
        return _switch
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type:  .system)
        button.frame = CGRect(x: 0, y: 0, width: 160, height: 51)
        button.setTitle("Deletar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 160.0, height: 51.0)
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var setupButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deleteButton,saveButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        root()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsView {
    
    private func addSubviews(){
        addSubview(emojiField)
        addSubview(titleField)
        addSubview(DescriptionField)
        addSubview(dateField)
        addSubview(terminatedField)
        addSubview(setupButtonsStackView)
        
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            emojiField.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            emojiField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiField.heightAnchor.constraint(equalToConstant: 100),
            emojiField.widthAnchor.constraint(equalToConstant: 100),
            
            titleField.topAnchor.constraint(equalTo: emojiField.bottomAnchor, constant: 30),
            titleField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            titleField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            titleField.heightAnchor.constraint(equalToConstant: 30),
            
            DescriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 30),
            DescriptionField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            DescriptionField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            DescriptionField.heightAnchor.constraint(equalToConstant: 100),
            
            dateField.topAnchor.constraint(equalTo: DescriptionField.bottomAnchor, constant: 30),
            dateField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            dateField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            dateField.heightAnchor.constraint(equalToConstant: 30),
            
            terminatedField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 30),
            terminatedField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            terminatedField.heightAnchor.constraint(equalToConstant: 30),

            setupButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            setupButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            setupButtonsStackView.heightAnchor.constraint(equalToConstant: 51),
            setupButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    private func root(){
        backgroundColor = .white
    }
}
