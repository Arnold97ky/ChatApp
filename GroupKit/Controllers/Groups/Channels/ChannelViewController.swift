//
//  ChannelViewController.swift
//  GroupKit
//
//  Created by Consultant on 8/26/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class ChannelViewController: UIViewController {

    private let toolbarLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 15)
      return label
    }()
    
    private let channelCellIdentifier = "channelCell"
    private var currentChannelAlertController: UIAlertController?
    
    private let database = Firestore.firestore()
    private var channelReference: CollectionReference {
      return database.collection("channels")
    }
    
    private var channels: [Channel] = []
    private var channelListener: ListenerRegistration?
    
  

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        toolbarItems = [
            UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut)),
          UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
          UIBarButtonItem(customView: toolbarLabel),
          UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
          UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        ]
        toolbarLabel.text = "Me"

    }
    

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.isToolbarHidden = false
    }
    
    
    // MARK: - Actions
    @objc private func signOut() {
      let alertController = UIAlertController(
        title: nil,
        message: "Are you sure you want to sign out?",
        preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      alertController.addAction(cancelAction)

      let signOutAction = UIAlertAction(
        title: "Sign Out",
        style: .destructive) { _ in
        do {
          try Auth.auth().signOut()
        } catch {
          print("Error signing out: \(error.localizedDescription)")
        }
      }
      alertController.addAction(signOutAction)

      present(alertController, animated: true)
    }

    @objc private func addButtonPressed() {
      let alertController = UIAlertController(title: "Create a new Channel", message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      alertController.addTextField { field in
        field.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        field.enablesReturnKeyAutomatically = true
        field.autocapitalizationType = .words
        field.clearButtonMode = .whileEditing
        field.placeholder = "Channel name"
        field.returnKeyType = .done
        field.tintColor = .green
      }

      let createAction = UIAlertAction(
        title: "Create",
        style: .default) { _ in
       // self.createChannel()
      }
      createAction.isEnabled = false
      alertController.addAction(createAction)
      alertController.preferredAction = createAction

      present(alertController, animated: true) {
        alertController.textFields?.first?.becomeFirstResponder()
      }
      currentChannelAlertController = alertController
    }

    @objc private func textFieldDidChange(_ field: UITextField) {
      guard let alertController = currentChannelAlertController else {
        return
      }
      alertController.preferredAction?.isEnabled = field.hasText
    }

    
    // MARK: - Helpers
    private func createChannel() {
      guard
        let alertController = currentChannelAlertController,
        let channelName = alertController.textFields?.first?.text
      else {
        return
      }

      let channel = Channel(name: channelName)
      channelReference.addDocument(data: channel.representation) { error in
        if let error = error {
          print("Error saving channel: \(error.localizedDescription)")
        }
      }
    }

}
