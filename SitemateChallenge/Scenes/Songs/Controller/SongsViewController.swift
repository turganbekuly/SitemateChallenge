//
//  SongsViewController.swift
//  SitemateChallenge
//
//  Created by Akarys Turganbekuly on 29.06.2022.
//

import UIKit

protocol SongsDisplayLogic: AnyObject {
    func displayLyrics(viewModel: SongsDataFlow.GetSongs.ViewModel)
}
final class SongsViewController: UIViewController {
    // MARK: - Properties

    var interactor: SongsBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }

    var throttler = Throttler(minimumDelay: 0.5)

    // MARK: - Init

    init(interactor: SongsBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Lyrics"
        navigationItem.searchController = searchController
    }

    // MARK: - Views factory

    public lazy var searchController: UISearchController = {
        let searchResultController = SongsResultsBuilder(state: .initial).build()
        let controller = UISearchController(searchResultsController: searchResultController)
        controller.searchBar.placeholder = "Please enter title and artist"
        controller.searchBar.delegate = self
        controller.delegate = self
        return controller
    }()
}

extension SongsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.throttle { [weak self] in
            guard let self = self else { return }
            let array = searchText.components(separatedBy: " ")
            guard array.count >= 2 else { return }
            self.getLyrics(title: array.dropFirst().joined(separator: " "), artist: array[0])
        }
    }
}


extension SongsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let viewController = searchController.searchResultsController as? SongsResultsViewController else { return }
        viewController.lyrics = searchController.searchBar.text ?? ""
    }
}

extension SongsViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
