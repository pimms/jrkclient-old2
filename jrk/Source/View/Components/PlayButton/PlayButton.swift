//
//  Copyright © 2019 Joakim Stien. All rights reserved.
//

import UIKit

protocol PlayButtonDelegate: class {
    func playButtonClicked(_: PlayButton)
}

class PlayButton: UIView {

    // MARK: - Public properties

    public weak var delegate: PlayButtonDelegate?

    // MARK: - UI properties

    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()

    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init() {
        super.init(frame: .zero)
        setup()
    }

    private func setup() {
        backgroundColor = .clear

        button.backgroundColor = .white

        button.setTitle("normal", for: .normal)
        button.setTitle("focused", for: .focused)
        button.setTitle("highlighted", for: .highlighted)
        button.setTitle("selected", for: .selected)

        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .focused)
        button.setTitleColor(.black, for: .highlighted)
        button.setTitleColor(.black, for: .selected)

        addSubview(button)

        button.fillInSuperview()
        button.constrainAspectRatio(1.0)
    }

    @objc private func buttonClicked() {
        delegate?.playButtonClicked(self)
    }


}

// MARK: - UIView overrides

extension PlayButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = frame.width / 2.0
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let point = convert(point, to: self)

        let radius = frame.width / 2.0
        let center = CGPoint(x: radius, y: radius)

        let delta = CGPoint(x: point.x - center.x, y: point.y - center.y)
        if delta.length > radius {
            return nil
        }

        return super.hitTest(point, with: event)
    }
}