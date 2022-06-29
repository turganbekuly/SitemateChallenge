//
//  SongsResultsViewController.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit
import SnapKit

final class SongsResultsViewController: UIViewController {
    // MARK: - Properties

    var lyrics: String = "" {
        didSet {
            if lyrics.isEmpty {
                textView.text = "Couldn't find result"
            } else {
                textView.text = lyrics
            }
            activityIndicator.stopAnimating()
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Init

    init(state: State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        state = { state }()
    }

    // MARK: - Views factory

    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.sizeToFit()
        return tv
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        return ai
    }()

    // MARK: - Setup Views

    private func setupViews() {
        [textView, activityIndicator].forEach {
            view.addSubview($0)
        }
        activityIndicator.startAnimating()
        setupConstraints()
    }

    private func setupConstraints() {
        textView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview().inset(16)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}
