import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties

    private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
                self.labelPassword.textColor = .white
            } else {
                self.view.backgroundColor = .white
                self.labelPassword.textColor = .black
            }
        }
    }

    // MARK: - Outlets

    private lazy var buttonChangBackground: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Change Background Color", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onBut), for: .touchUpInside)
        return button
    }()

    private lazy var labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Brute Force"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.textAlignment = .center
        textField.placeholder = "password"
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var buttonPassword: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Generate password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generatePassword), for: .touchUpInside)
        return button
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .green
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()


    // MARK: - Action

    @objc
    private func onBut(_ sender: Any) {
        isBlack.toggle()
    }

    @objc
    private func generatePassword() {
        let passwordLength = 3
        let password = PasswordGenerator.generatePassword(lenght: passwordLength)
        self.labelPassword.text = "Идет подбор пароля..."
        self.textFieldPassword.isSecureTextEntry = true
        self.textFieldPassword.text = password
        self.spinner.startAnimating()

        DispatchQueue.global().async { [weak self] in
            self?.bruteForce(passwordToUnlock: password)
        }
    }

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    // MARK: - Configure

    private func configureView() {
        [buttonChangBackground, labelPassword, textFieldPassword, buttonPassword, spinner]
            .forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            labelPassword.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            labelPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            labelPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 100),
            textFieldPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            textFieldPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),

            buttonPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 100),
            buttonPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            buttonPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            buttonPassword.heightAnchor.constraint(equalToConstant: 50),

            buttonChangBackground.topAnchor.constraint(equalTo: buttonPassword.bottomAnchor, constant: 100),
            buttonChangBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            buttonChangBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            buttonChangBackground.heightAnchor.constraint(equalToConstant: 50),

            spinner.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor),
            spinner.leadingAnchor.constraint(equalTo: textFieldPassword.trailingAnchor, constant: 10)
        ])

    }

    // MARK: - Func

    private func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        while password != passwordToUnlock {
            password = BruteForce().generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        DispatchQueue.main.async { [weak self] in
            self?.labelPassword.text = password
            self?.spinner.stopAnimating()
            self?.textFieldPassword.isSecureTextEntry = false
        }
    }
}

