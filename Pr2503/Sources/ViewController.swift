import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties

    private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }

    // MARK: - Outlets

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Button", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onBut), for: .touchUpInside)
        return button
    }()

    // MARK: - Action

    @objc
    private func onBut(_ sender: Any) {
        isBlack.toggle()
    }

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.bruteForce(passwordToUnlock: "1!gr")
    }

    // MARK: - Configure

    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    // MARK: - Func

    private func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = BruteForce().generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            //             Your stuff here
            print(password)
            // Your stuff here
        }
        
        print(password)
    }
}

