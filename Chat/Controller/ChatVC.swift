//
//  ChatVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController, SelectionDelegate, NSTableViewDataSource, NSTableViewDelegate {

    //MARK:- IBOutlets
    @IBOutlet private var chatTableView: NSTableView!
    @IBOutlet private var channelTitle: NSTextField!
    @IBOutlet private var channeDescription: NSTextField!
    @IBOutlet private var userTypingLabel: NSTextField!
    @IBOutlet private var messageOutlineView: NSView!
    @IBOutlet private var messageText: NSTextField!
    @IBOutlet private var sendMessageButton: NSButton!
    
    //MARK: - Variables
    private var messages: [Message] = []
    private var selectedChannel: Channel?
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
        startObservingForNotifications()
        
    }
    
    override func viewWillAppear() {
        setupView()
        SocketService.sharedInstance.getChatMessage { (newMessage) in
            //Check if we are at the correct channel
            if (newMessage.channel.channelId == self.selectedChannel?.channelId
                && AuthService.sharedInstance.isLoggedIn) {
                MessageService.sharedInstance.messages.append(newMessage)
                Utilities.updateTableView(self.chatTableView)
                let rowIndex = MessageService.sharedInstance.messages.count - 1
                Utilities.scrollRowToVisible(ForTableView: self.chatTableView, row: rowIndex)
            }
        }
    }
    
    //MARK:- Helper methods
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = nearlyWhiteColor.cgColor
        self.chatTableView.backgroundColor = nearlyWhiteColor
        
        self.messageOutlineView.wantsLayer = true
        self.messageOutlineView.layer?.backgroundColor = CGColor.white
        self.messageOutlineView.layer?.borderColor = NSColor.controlHighlightColor.cgColor
        self.messageOutlineView.layer?.borderWidth = 2
        self.messageOutlineView.layer?.cornerRadius = 5
        
        self.messageText.isBordered = false
        self.messageText.placeholderString = "Message"
        
        //Default to Please login
        self.channelTitle.stringValue = "Please Login"
        self.channeDescription.stringValue = ""
        self.userTypingLabel.stringValue = ""
        
        self.sendMessageButton.setTitleColor(color: NSColor.black)
        self.sendMessageButton.setFont(loginFont)
        
    }
    
    private func startObservingForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange), name: NOTIF_USER_DATA_CHANGED, object: nil)
    }
    
    @objc private func userDataDidChange(_ notif: Notification)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            self.channelTitle.stringValue = ""
            self.channeDescription.stringValue = ""

            if (MessageService.sharedInstance.channels.count == 0)
            {
                self.channelTitle.stringValue = "Create a channel"
            }
        }
        else
        {
            channelTitle.stringValue = "Please log in"
            channeDescription.stringValue = ""
            self.userTypingLabel.stringValue = ""
            
            //Empty self.messages to update UI
            self.messages = MessageService.sharedInstance.messages
            Utilities.updateTableView(self.chatTableView)
        }
    }
    
    //MARK:- IBActions
    @IBAction private func sendMessageButtonClicked(_ sender: NSButton)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            let userDataDictionary = UserDataService.sharedInstance.jsonify()
            let user: User = User(userDataDictionary)
            
            guard let channelName = self.selectedChannel?.channelName,
                let channelId = self.selectedChannel?.channelId,
                let channelDescription = self.selectedChannel?.channelDescription
            else {
                return
            }
            
            let channel: Channel = Channel(channelName: channelName, channelId: channelId, description: channelDescription)
            SocketService.sharedInstance.addMessage(messageText.stringValue, user: user, channel: channel) {
                self.messageText.stringValue = ""
            }
            Utilities.updateTableView(self.chatTableView)
        }
        else
        {
            let loginDict = [USER_INFO_MODAL: ModalType.login]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        }
    }

    //MARK: - Delegate methods
    func tableView(_tableView: NSTableView, didSelectObject object: NSObject) {
        guard let channel = object as? Channel else {
            return
        }
        self.selectedChannel = channel
        MessageService.sharedInstance.findAllMessages(channel, successBlock: { (messages) in
            guard let chatMessages = messages  else {
                return
            }
            self.messages = chatMessages
            Utilities.updateTableView(self.chatTableView)
            let rowIndex = MessageService.sharedInstance.messages.count - 1
            Utilities.scrollRowToVisible(ForTableView: self.chatTableView, row: rowIndex)
        }) { (failureResponse) in
            print(failureResponse ?? "")
        }
    }
    
    //MARK: - TableView delegate/protocols methods
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: ChatCell.getCellIdentifier()), owner: nil) as? ChatCell else {
            return NSTableCellView()
        }
        let message = self.messages[row]
        cell.configureCell(message)
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }
    
    
    //MARK:- Getters
    func getChannelTitleValue() -> String {
        return self.channelTitle.stringValue
    }
    
    func getChannelDescriptionValue() -> String {
        return self.channeDescription.stringValue
    }
    
    func getUserTypingLabelValue() -> String {
        return self.userTypingLabel.stringValue
    }
    
    //MARK: - Setters
    func setChannelTitleValue(_ channelTitle: String) {
        self.channelTitle.stringValue = channelTitle
    }
    
    func setChannelDescriptionValue(_ channelDescription: String) {
        self.channeDescription.stringValue = channelDescription
    }
    
    func setUserTypingLabelValue(_ userTypingLabelValue: String) {
        self.userTypingLabel.stringValue = userTypingLabelValue
    }
}
