import UIKit

public class Toast: UIView {
    public let message: String
    public let messageFont: UIFont
    private let label = UILabel()

    public init(_ message: String, font: UIFont, frame: CGRect) {
        self.message = message
        self.messageFont = font

        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        guard
            let message = aDecoder.decodeObject(forKey: "messageKey") as? String,
            let font = aDecoder.decodeObject(forKey: "fontKey") as? UIFont else {
            return nil
        }
        self.message = message
        self.messageFont = font

        super.init(coder: aDecoder)
        setup()
    }

    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(message, forKey: "messageKey")
        aCoder.encode(messageFont, forKey: "fontKey")

        super.encode(with: aCoder)
    }

    private func setup() {
        self.accessibilityIdentifier = "ToastID"
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.alpha = 1.0
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.addSubview(label)

        label
            .topAnchor
            .constraint(equalTo: self.topAnchor,
                        constant: 0)
            .isActive = true

        label
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor,
                        constant: 0)
            .isActive = true

        label
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor,
                        constant: 0)
            .isActive = true

        label
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor,
                        constant: 0)
            .isActive = true

        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = message
        label.numberOfLines = 2
        label.font = messageFont
    }
}

public extension Toast {
    @discardableResult
    static func show(message: String,
                     font: UIFont = UIFont.systemRegular(size: 10),
                     in view: UIView,
                     completion: (() -> Void)? = nil) -> Toast {
        let toastFrame = CGRect(x: view.frame.size.width / 2 - 75,
                                y: view.frame.size.height - 100,
                                width: 150, height: 70)

        let toast = Toast(message, font: font, frame: toastFrame)

        view.addSubview(toast)
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
                        toast.alpha = 0.0
                       },
                       completion: { _ in
                        toast.removeFromSuperview()
                        completion?()
                       })
        return toast
    }
}
