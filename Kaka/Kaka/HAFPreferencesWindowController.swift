//
//  HAFPreferencesWindowController.swift
//  Kaka
//
//  Created by Jovi on 8/24/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

import Cocoa
import ShortcutsKit

class HAFPreferencesWindowController: NSWindowController {
    var _scTabs: NSSegmentedControl!
    var _btnLaunchAtLogin: NSButton!
    var _btnBackupBackupConfiguration: NSButton!
    var _btnOneClickToHideDesktopIcon: NSButton!
    var _btnDoubleClickToShowDesktop: NSButton!
    var _btnDoubleClickDesktopToShowIcons: NSButton!
    var _btnEnableAnimationAudio: NSButton!
    var _lbDisplayDesktop: NSTextField!
    var _kcvDisplayDesktop: SCKeyComboView!
    var _lbHideDesktopIcons: NSTextField!
    var _kcvHideDesktopIcons: SCKeyComboView!
    var _lbTurnOffDisplay: NSTextField!
    var _kcvTurnOffDisplay: SCKeyComboView!
    var _lbTurnOnDarkMode: NSTextField!
    var _kcvTurnOnDarkMode: SCKeyComboView!
    var _lbAutoHideDesktopIconTimeout: NSTextField!
    var _tfAutoHideDesktopIconTimeoutValue: NSTextField!
    var _lbAutoHideCursorTimeout: NSTextField!
    var _tfAutoHideCursorTimeoutValue: NSTextField!

    init() {
        let frame = NSMakeRect(0, 0, 580, 180)
        let wnd = NSWindow.init(contentRect: frame, styleMask: [.titled, .closable, .fullSizeContentView], backing: .buffered, defer: false)
        wnd.backgroundColor = NSColor.white
        wnd.titlebarAppearsTransparent = true
        wnd.standardWindowButton(.zoomButton)?.isHidden = true
        wnd.standardWindowButton(.miniaturizeButton)?.isHidden = true
        wnd.title = NSLocalizedString("Preferences", comment: "")
        super.init(window: wnd)
        
        let visualEffectView: NSVisualEffectView = NSVisualEffectView.init(frame: frame)
        wnd.contentView = visualEffectView
        
        let tabFrame = NSMakeRect((NSWidth(frame) - 330) / 2, NSHeight(frame) - 55, 330, 23)
        _scTabs = NSSegmentedControl.init(frame: tabFrame)
        _scTabs.segmentCount = 4
        _scTabs.setLabel(NSLocalizedString("General", comment: ""), forSegment: 0)
        _scTabs.setWidth(80, forSegment: 0)
        _scTabs.setLabel(NSLocalizedString("Actions", comment: ""), forSegment: 1)
        _scTabs.setWidth(80, forSegment: 1)
        _scTabs.setLabel(NSLocalizedString("Shortcuts", comment: ""), forSegment: 2)
        _scTabs.setWidth(80, forSegment: 2)
        _scTabs.setLabel(NSLocalizedString("Timer", comment: ""), forSegment: 3)
        _scTabs.setWidth(80, forSegment: 3)
        _scTabs.setSelected(true, forSegment: 0)
        _scTabs.setSelected(false, forSegment: 1)
        _scTabs.setSelected(false, forSegment: 2)
        _scTabs.setSelected(false, forSegment: 3)
        _scTabs.target = self
        _scTabs.action = #selector(tabs_click)
        wnd.contentView?.addSubview(_scTabs)

        //MARK: General
        _btnLaunchAtLogin = NSButton.init(frame: NSMakeRect(20, NSMinY(tabFrame) - 40, NSWidth(frame), 23))
        _btnLaunchAtLogin.title = NSLocalizedString("Launch at login", comment: "")
        _btnLaunchAtLogin.setButtonType(.switch)
        _btnLaunchAtLogin.target = self
        _btnLaunchAtLogin.action = #selector(launchAtLogin_click)
        _btnLaunchAtLogin.state = HAFConfigureManager.sharedManager.isLaunchAtLogin() ? .on : .off
        _btnLaunchAtLogin.isHidden = true
        wnd.contentView?.addSubview(_btnLaunchAtLogin)
        
        _btnEnableAnimationAudio = NSButton.init(frame: NSMakeRect(20, NSMinY(_btnLaunchAtLogin.frame) - 30, NSWidth(frame), 23))
        _btnEnableAnimationAudio.title = NSLocalizedString("Enable animation audios", comment: "")
        _btnEnableAnimationAudio.setButtonType(.switch)
        _btnEnableAnimationAudio.target = self
        _btnEnableAnimationAudio.action = #selector(enableAnimationAudios_click)
        _btnEnableAnimationAudio.state = HAFConfigureManager.sharedManager.isEnableAnimationAudio() ? .on : .off
        _btnEnableAnimationAudio.isHidden = true
        wnd.contentView?.addSubview(_btnEnableAnimationAudio)
        
        _btnBackupBackupConfiguration = NSButton.init(frame: NSMakeRect(20, NSMinY(_btnEnableAnimationAudio.frame) - 35, 200, 23))
        _btnBackupBackupConfiguration.title = NSLocalizedString("Backup Configuration", comment: "")
        _btnBackupBackupConfiguration.setButtonType(.momentaryChange)
        _btnBackupBackupConfiguration.bezelStyle = .inline
        _btnBackupBackupConfiguration.target = self
        _btnBackupBackupConfiguration.action = #selector(backupConfiguration_click)
        _btnBackupBackupConfiguration.isHidden = true
        wnd.contentView?.addSubview(_btnBackupBackupConfiguration)
        
        //MARK: Actions
        _btnOneClickToHideDesktopIcon = NSButton.init(frame: NSMakeRect(20, NSMinY(tabFrame) - 40, NSWidth(frame), 23))
        _btnOneClickToHideDesktopIcon.title = NSLocalizedString("One-click 'Kaka' to show/hide desktop icons", comment: "")
        _btnOneClickToHideDesktopIcon.setButtonType(.switch)
        _btnOneClickToHideDesktopIcon.target = self
        _btnOneClickToHideDesktopIcon.action = #selector(oneClickToHideDesktopIcons_click)
        _btnOneClickToHideDesktopIcon.state = HAFConfigureManager.sharedManager.isOneClickToHideDesktopIcons() ? .on : .off
        _btnOneClickToHideDesktopIcon.isHidden = true
        wnd.contentView?.addSubview(_btnOneClickToHideDesktopIcon)

        _btnDoubleClickToShowDesktop = NSButton.init(frame: NSMakeRect(20, NSMinY(_btnOneClickToHideDesktopIcon.frame) - 30, NSWidth(frame), 23))
        _btnDoubleClickToShowDesktop.title = NSLocalizedString("Double-click 'Kaka' to show desktop", comment: "")
        _btnDoubleClickToShowDesktop.setButtonType(.switch)
        _btnDoubleClickToShowDesktop.target = self
        _btnDoubleClickToShowDesktop.action = #selector(doubleClickToShowDesktop_click)
        _btnDoubleClickToShowDesktop.state = HAFConfigureManager.sharedManager.isDoubleClickToShowDesktop() ? .on : .off
        _btnDoubleClickToShowDesktop.isHidden = true
        wnd.contentView?.addSubview(_btnDoubleClickToShowDesktop)

        _btnDoubleClickDesktopToShowIcons = NSButton.init(frame: NSMakeRect(20, NSMinY(_btnDoubleClickToShowDesktop.frame) - 30, NSWidth(frame), 23))
        _btnDoubleClickDesktopToShowIcons.title = NSLocalizedString("Double-click desktop to show icons", comment: "")
        _btnDoubleClickDesktopToShowIcons.setButtonType(.switch)
        _btnDoubleClickDesktopToShowIcons.target = self
        _btnDoubleClickDesktopToShowIcons.action = #selector(doubleClickDesktopToShowIcons_click)
        _btnDoubleClickDesktopToShowIcons.state = HAFConfigureManager.sharedManager.isDoubleClickDesktopToShowIcons() ? .on : .off
        _btnDoubleClickDesktopToShowIcons.isHidden = true
        wnd.contentView?.addSubview(_btnDoubleClickDesktopToShowIcons)
        
        //MARK: Shortcuts
        _lbDisplayDesktop = NSTextField.init(frame: NSMakeRect(20, NSMinY(tabFrame) - 30, NSWidth(frame), 23))
        _lbDisplayDesktop.isEditable = false
        _lbDisplayDesktop.isSelectable = false
        _lbDisplayDesktop.isBordered = false
        _lbDisplayDesktop.isHidden = true
        _lbDisplayDesktop.backgroundColor = NSColor.clear
        _lbDisplayDesktop.font = NSFont.init(name: "Helvetica Neue", size: 13)
        _lbDisplayDesktop.stringValue = NSLocalizedString("Display Desktop", comment: "") + ":"
        wnd.contentView?.addSubview(_lbDisplayDesktop)
        
        _kcvDisplayDesktop = SCKeyComboView.standard()
        _kcvDisplayDesktop.setFrameOrigin(NSMakePoint(85, NSMinY(tabFrame) - 60))
        _kcvDisplayDesktop.delegate = self as SCKeyComboViewDelegate
        _kcvDisplayDesktop.keyCombo = HAFConfigureManager.sharedManager.displayDesktopKeyCombo()
        wnd.contentView?.addSubview(_kcvDisplayDesktop)
        
        _lbHideDesktopIcons = NSTextField.init(frame: NSMakeRect(245, NSMinY(tabFrame) - 30, NSWidth(frame), 23))
        _lbHideDesktopIcons.isEditable = false
        _lbHideDesktopIcons.isSelectable = false
        _lbHideDesktopIcons.isBordered = false
        _lbHideDesktopIcons.isHidden = true
        _lbHideDesktopIcons.backgroundColor = NSColor.clear
        _lbHideDesktopIcons.font = NSFont.init(name: "Helvetica Neue", size: 13)
        _lbHideDesktopIcons.stringValue = NSLocalizedString("Hide Desktop Icons", comment: "") + ":"
        wnd.contentView?.addSubview(_lbHideDesktopIcons)
        
        _kcvHideDesktopIcons = SCKeyComboView.standard()
        _kcvHideDesktopIcons.setFrameOrigin(NSMakePoint(320, NSMinY(tabFrame) - 60))
        _kcvHideDesktopIcons.delegate = self as SCKeyComboViewDelegate
        _kcvHideDesktopIcons.keyCombo = HAFConfigureManager.sharedManager.hideDesktopIconsKeyCombo()
        wnd.contentView?.addSubview(_kcvHideDesktopIcons)
        
        _lbTurnOffDisplay = NSTextField.init(frame: NSMakeRect(20, NSMinY(tabFrame) - 85, NSWidth(frame), 23))
        _lbTurnOffDisplay.isEditable = false
        _lbTurnOffDisplay.isSelectable = false
        _lbTurnOffDisplay.isBordered = false
        _lbTurnOffDisplay.isHidden = true
        _lbTurnOffDisplay.backgroundColor = NSColor.clear
        _lbTurnOffDisplay.font = NSFont.init(name: "Helvetica Neue", size: 13)
        _lbTurnOffDisplay.stringValue = NSLocalizedString("Turn Off The Display", comment: "") + ":"
        wnd.contentView?.addSubview(_lbTurnOffDisplay)
        
        _kcvTurnOffDisplay = SCKeyComboView.standard()
        _kcvTurnOffDisplay.setFrameOrigin(NSMakePoint(85, NSMinY(tabFrame) - 115))
        _kcvTurnOffDisplay.delegate = self as SCKeyComboViewDelegate
        _kcvTurnOffDisplay.keyCombo = HAFConfigureManager.sharedManager.turnOffDisplayKeyCombo()
        wnd.contentView?.addSubview(_kcvTurnOffDisplay)
        
        _lbTurnOnDarkMode = NSTextField.init(frame: NSMakeRect(245, NSMinY(tabFrame) - 85, NSWidth(frame), 23))
        _lbTurnOnDarkMode.isEditable = false
        _lbTurnOnDarkMode.isSelectable = false
        _lbTurnOnDarkMode.isBordered = false
        _lbTurnOnDarkMode.isHidden = true
        _lbTurnOnDarkMode.backgroundColor = NSColor.clear
        _lbTurnOnDarkMode.font = NSFont.init(name: "Helvetica Neue", size: 13)
        _lbTurnOnDarkMode.stringValue = NSLocalizedString("Turn On Dark Mode", comment: "") + ":"
        wnd.contentView?.addSubview(_lbTurnOnDarkMode)
        
        _kcvTurnOnDarkMode = SCKeyComboView.standard()
        _kcvTurnOnDarkMode.setFrameOrigin(NSMakePoint(320, NSMinY(tabFrame) - 115))
        _kcvTurnOnDarkMode.delegate = self as SCKeyComboViewDelegate
        _kcvTurnOnDarkMode.keyCombo = HAFConfigureManager.sharedManager.turnOnDarkModeKeyCombo()
        wnd.contentView?.addSubview(_kcvTurnOnDarkMode)
        
        _lbAutoHideDesktopIconTimeout = NSTextField.init(frame: NSMakeRect(0, NSMinY(tabFrame) - 40, 250, 23))
        _lbAutoHideDesktopIconTimeout.alignment = .right
        _lbAutoHideDesktopIconTimeout.isEditable = false
        _lbAutoHideDesktopIconTimeout.isBezeled = false
        _lbAutoHideDesktopIconTimeout.isSelectable = false
        _lbAutoHideDesktopIconTimeout.backgroundColor = NSColor.clear
        _lbAutoHideDesktopIconTimeout.stringValue = NSLocalizedString("Auto Hide Desktop Icon Timeout(sec)", comment: "") + ":"
        wnd.contentView?.addSubview(_lbAutoHideDesktopIconTimeout)
        
        _tfAutoHideDesktopIconTimeoutValue = NSTextField.init(frame: NSMakeRect(NSMaxX(_lbAutoHideDesktopIconTimeout.frame) + 10, NSMinY(tabFrame) - 37, 50, 23))
        _tfAutoHideDesktopIconTimeoutValue.focusRingType = .none
        _tfAutoHideDesktopIconTimeoutValue.alignment = .right
        _tfAutoHideDesktopIconTimeoutValue.stringValue = ""
        wnd.contentView?.addSubview(_tfAutoHideDesktopIconTimeoutValue)
        var timeOut = HAFConfigureManager.sharedManager.autoHideDesktopIconTimeOut()
        _tfAutoHideDesktopIconTimeoutValue.stringValue = "\(timeOut)"
        _tfAutoHideDesktopIconTimeoutValue.delegate = self
        
        _lbAutoHideCursorTimeout = NSTextField.init(frame: NSMakeRect(0, NSMinY(tabFrame) - 70, 250, 23))
        _lbAutoHideCursorTimeout.alignment = .right
        _lbAutoHideCursorTimeout.isEditable = false
        _lbAutoHideCursorTimeout.isBezeled = false
        _lbAutoHideCursorTimeout.isSelectable = false
        _lbAutoHideCursorTimeout.backgroundColor = NSColor.clear
        _lbAutoHideCursorTimeout.stringValue = NSLocalizedString("Auto Hide Cursor Timeout(sec)", comment: "") + ":"
        wnd.contentView?.addSubview(_lbAutoHideCursorTimeout)
        
        _tfAutoHideCursorTimeoutValue = NSTextField.init(frame: NSMakeRect(NSMaxX(_lbAutoHideCursorTimeout.frame) + 10, NSMinY(tabFrame) - 67, 50, 23))
        _tfAutoHideCursorTimeoutValue.focusRingType = .none
        _tfAutoHideCursorTimeoutValue.alignment = .right
        _tfAutoHideCursorTimeoutValue.stringValue = ""
        wnd.contentView?.addSubview(_tfAutoHideCursorTimeoutValue)
        timeOut = HAFConfigureManager.sharedManager.autoHideCursorTimeOut()
        _tfAutoHideCursorTimeoutValue.stringValue = "\(timeOut)"
        _tfAutoHideCursorTimeoutValue.delegate = self
        
        updateTabs()
        
        wnd.center()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        updateTimerValue()
    }
    
    func updateTimerValue() -> Void {
        var timeOut = HAFConfigureManager.sharedManager.autoHideDesktopIconTimeOut()
        _tfAutoHideDesktopIconTimeoutValue.stringValue = "\(timeOut)"
        timeOut = HAFConfigureManager.sharedManager.autoHideCursorTimeOut()
        _tfAutoHideCursorTimeoutValue.stringValue = "\(timeOut)"
    }
    
    func updateTabs() -> Void {
        _btnLaunchAtLogin.isHidden = true
        _btnEnableAnimationAudio.isHidden = true
        _btnOneClickToHideDesktopIcon.isHidden = true
        _btnDoubleClickToShowDesktop.isHidden = true
        _btnDoubleClickDesktopToShowIcons.isHidden = true
        _lbDisplayDesktop.isHidden = true
        _kcvDisplayDesktop.isHidden = true
        _lbHideDesktopIcons.isHidden = true
        _kcvHideDesktopIcons.isHidden = true
        _lbTurnOffDisplay.isHidden = true
        _kcvTurnOffDisplay.isHidden = true
        _lbTurnOnDarkMode.isHidden = true
        _kcvTurnOnDarkMode.isHidden = true
        _lbAutoHideDesktopIconTimeout.isHidden = true
        _tfAutoHideDesktopIconTimeoutValue.isHidden = true
        _lbAutoHideCursorTimeout.isHidden = true
        _tfAutoHideCursorTimeoutValue.isHidden = true
        _btnBackupBackupConfiguration.isHidden = true
        
        switch _scTabs.selectedSegment {
        case 0:
            _btnLaunchAtLogin.isHidden = false
            _btnEnableAnimationAudio.isHidden = false
            _btnBackupBackupConfiguration.isHidden = HAFSuperModeManager.isKakaInSuperMode()
            break;
        case 1:
            _btnOneClickToHideDesktopIcon.isHidden = false
            _btnDoubleClickToShowDesktop.isHidden = false
            _btnDoubleClickDesktopToShowIcons.isHidden = false
            break;
        case 2:
            _lbDisplayDesktop.isHidden = false
            _kcvDisplayDesktop.isHidden = false
            _lbHideDesktopIcons.isHidden = false
            _kcvHideDesktopIcons.isHidden = false
            _lbTurnOffDisplay.isHidden = false
            _kcvTurnOffDisplay.isHidden = false
            _lbTurnOnDarkMode.isHidden = !HAFSuperModeManager.isKakaInSuperMode()
            _kcvTurnOnDarkMode.isHidden = !HAFSuperModeManager.isKakaInSuperMode()
            break;
        case 3:
            _lbAutoHideDesktopIconTimeout.isHidden = false
            _tfAutoHideDesktopIconTimeoutValue.isHidden = false
            _lbAutoHideCursorTimeout.isHidden = false
            _tfAutoHideCursorTimeoutValue.isHidden = false
            break;
        default:
            break;
        }
    }
    
    @IBAction func launchAtLogin_click(sender: AnyObject?){
        HAFConfigureManager.sharedManager.setLaunchAtLogin(bFlag: _btnLaunchAtLogin.state == .on)
    }
    
    @IBAction func oneClickToHideDesktopIcons_click(sender: AnyObject?){
        HAFConfigureManager.sharedManager.setOneClickToHideDesktopIcons(bFlag: _btnOneClickToHideDesktopIcon.state == .on)
    }
    
    @IBAction func doubleClickToShowDesktop_click(sender: AnyObject?){
        HAFConfigureManager.sharedManager.setDoubleClickToShowDesktop(bFlag: _btnDoubleClickToShowDesktop.state == .on)
    }
    
    @IBAction func doubleClickDesktopToShowIcons_click(sender: AnyObject?){
        HAFConfigureManager.sharedManager.setDoubleClickDesktopToShowIcons(bFlag: _btnDoubleClickDesktopToShowIcons.state == .on)
    }
    
    @IBAction func enableAnimationAudios_click(sender: AnyObject?){
        HAFConfigureManager.sharedManager.setEnableAnimationAudio(bFlag: _btnEnableAnimationAudio.state == .on)
    }
    
    @IBAction func tabs_click(sender: AnyObject?){
        updateTabs()
    }
    
    @IBAction func backupConfiguration_click(sender: AnyObject?){
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = "bk.kaka"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let bk = "6Z2e5rOV56C06Kej77yM6Kej5a+G5peg5pWI44CCS2FrYeaYr+WFjei0ueeahOS9oOadpeegtOino+W5suWTiO+8n+ebtOaOpeaJvuaIkeimgeS7o+eggeWRl+OAguW4jOacm+S9oOiDveaJvuWIsOaIkeeahEdpdEh1YuWVpuOAgg=="
                do {
                    try bk.write(to: savePanel.url!, atomically: false, encoding: .utf8)
                }
                catch {/* error handling here */}
            }
        }
    }
}

extension HAFPreferencesWindowController:SCKeyComboViewDelegate{
    func keyComboWillChange(_ keyComboView: SCKeyComboView) -> Void {
    }
    
    func keyComboDidChanged(_ keyComboView: SCKeyComboView) -> Void {
        let kc = keyComboView.keyCombo
        if nil != kc{
            if 0 == kc!.keyModifiers{
                keyComboView.keyCombo = nil
                return;
            }
            
            if (_kcvDisplayDesktop.keyCombo == kc && keyComboView != _kcvDisplayDesktop) || (_kcvHideDesktopIcons.keyCombo == kc && keyComboView != _kcvHideDesktopIcons) || (_kcvTurnOffDisplay.keyCombo == kc && keyComboView != _kcvTurnOffDisplay) || (_kcvTurnOnDarkMode.keyCombo == kc && keyComboView != _kcvTurnOnDarkMode){
                keyComboView.keyCombo = nil
                return;
            }
        }
        
        if keyComboView == _kcvDisplayDesktop {
            HAFHotkeyManager.sharedManager.setDisplayDesktopHotkey(keyCombo: keyComboView.keyCombo)
        }
        
        if keyComboView == _kcvHideDesktopIcons {
            HAFHotkeyManager.sharedManager.setHideDesktopIconsHotkey(keyCombo: keyComboView.keyCombo)
        }
        
        if keyComboView == _kcvTurnOffDisplay {
            HAFHotkeyManager.sharedManager.setTurnOffDisplayHotkey(keyCombo: keyComboView.keyCombo)
        }
        
        if keyComboView == _kcvTurnOnDarkMode {
            HAFHotkeyManager.sharedManager.setTurnOnDarkModeHotkey(keyCombo: keyComboView.keyCombo)
        }
    }
}

extension HAFPreferencesWindowController: NSControlTextEditingDelegate, NSTextFieldDelegate{
    override func controlTextDidChange(_ obj: Notification) {
        let textField = obj.object as? NSTextField
        let value = textField?.stringValue
        if nil != value  {
            let intValue = Int(value!)
            if nil == intValue || intValue! <= 0{
                return;
            }
            if textField == _tfAutoHideDesktopIconTimeoutValue{
                HAFConfigureManager.sharedManager.setAutoHideDesktopIconTimeOut(nSeconds: intValue!)
            }else if textField == _tfAutoHideCursorTimeoutValue{
                HAFConfigureManager.sharedManager.setAutoHideCursorTimeOut(nSeconds: intValue!)
            }
        }
    }
}
