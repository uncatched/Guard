//
//  ZipDetailsViewController.swift
//  Guard
//
//  Created by Denys on 8/5/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ZipDetailsViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var filesLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    
    // MARK: - Properties
    var zip: ZipFile!
    private let storage = Storage()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

// MARK: - Private methods
extension ZipDetailsViewController {
    
    private func configureView() {
        nameLabel.text = zip.filename
        filesLabel.text = String(zip.filesCount)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = Date(timeIntervalSinceReferenceDate: zip.timestamp)
        createdLabel.text = formatter.string(from: date)
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(zip.size))
        sizeLabel.text = string
    }
}

// MARK: - Actions
extension ZipDetailsViewController {
    
    @IBAction private func onDeleteButton() {
        StorageManager.deleteZipObject(zip)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func onShareButton() {
        let url = storage.fileURL(with: zip.filename + ".zip")
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension ZipDetailsViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
