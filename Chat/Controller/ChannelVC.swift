 //
//  ChannelVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    //MARK:- IBOutlets
    @IBOutlet private var channelsTableView: NSTableView!
    @IBOutlet private var channelsLabel: NSTextField!
    @IBOutlet private var usernameLabel: NSTextField!
    @IBOutlet private var addChannelButton: NSButton!
    
    //MARK: - properties
    private let tableViewCellId = NSUserInterfaceItemIdentifier(rawValue: "channelCell")
    private var selectedChannelIndex = 0
    private var selectedChannel: Channel?
    var chatVC: ChatVC?
    private var channel: Channel?
    weak var selectionDelegate: SelectionDelegate?
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChannelButton.isBordered = false
        self.channelsTableView.dataSource = self
        self.channelsTableView.delegate = self
        setupView()
        startObservingForNotifications()
    }
    
    override func viewDidAppear() {
        
        self.chatVC = self.view.window?.contentViewController?.childViewControllers[0].childViewControllers[1] as? ChatVC
        
        MessageService.sharedInstance.findAllChannels(sBlock: { (channels) in
            Utilities.updateTableView(self.channelsTableView)
        }) { (failResponse) in
            print("SHIT")
        }
    }
    
    //MARK:- Helper functions
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = channelColor.cgColor
        //labels
        self.channelsLabel.setFont(channelFont, textColor: grayTextColor)
        self.usernameLabel.setFont(channelFont, textColor: grayTextColor)
        self.usernameLabel.stringValue = ""
        //Buttons
        self.addChannelButton.setFont(channelFont)
        self.addChannelButton.setTitleColor(color: grayTextColor)
        //TableView
        self.channelsTableView.backgroundColor = channelColor
        
    }

    private func startObservingForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
    }
    
    @objc private func userDataDidChange(_ notif: Notification)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            usernameLabel.stringValue = UserDataService.sharedInstance.name
        }
        else
        {
            usernameLabel.stringValue = ""
        }
    }
    
    private func updateWithChannel(channel: Channel)
    {
        self.channel = channel
        let channelTitle = channel.channelName ?? ""
        let title = "#\(channelTitle)"
        let channelDescription = channel.channelDescription ?? ""
        let userTypingLabelValue = UserDataService.sharedInstance.name
        
        self.chatVC?.setChannelTitleValue(title)
        self.chatVC?.setChannelDescriptionValue(channelDescription)
        self.chatVC?.setUserTypingLabelValue(userTypingLabelValue)
        
    }
    
    //MARK: - IBActions
    @IBAction private func addChanelButtonClicked(_ sender: NSButton)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            //Add channel
            let addChannelDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.AddChannel]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: addChannelDict)
        }
        else
        {
            let loginDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.login]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        }
    }
    
    //MARK: - Table View protocol/delegate methods
    func numberOfRows(in tableView: NSTableView) -> Int {
        return MessageService.sharedInstance.channels.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let channel = MessageService.sharedInstance.channels[row]
        guard let cell = tableView.makeView(withIdentifier: tableViewCellId, owner: nil) as? ChannelCell else {
            return NSTableCellView()
        }
        cell.configureCell(channel: channel, selectedChannelIndex: self.selectedChannelIndex, row: row)
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        self.selectedChannelIndex = self.channelsTableView.selectedRow
        let channel = MessageService.sharedInstance.channels[self.selectedChannelIndex]
        self.selectedChannel = channel
        updateWithChannel(channel: channel)
        //Delegate
        self.selectionDelegate = self.chatVC
        self.selectionDelegate?.tableView(_tableView: self.channelsTableView, didSelectObject: channel)
        Utilities.updateTableView(self.channelsTableView)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30.0
    }
    
}
