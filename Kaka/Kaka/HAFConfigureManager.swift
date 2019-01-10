//
//  HAFConfigureManager.swift
//  Kaka
//
//  Created by Jovi on 8/25/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

import Cocoa
import ServiceManagement
import ShortcutsKit

class HAFConfigureManager: NSObject {
    static let sharedManager = HAFConfigureManager()
    let helperBundleIdentifier = "com.HyperartFlow.Kaka.launchAtLoginHelper"
    
    let kAutoHideMouseCursor = "AutoHideMouseCursorKey"
    let kOneClickToHideDesktopIcons = "OneClickToHideDesktopIconsKey"
    let kDoubleClickToShowDesktop = "DoubleClickToShowDesktopKey"
    let kDoubleClickDesktopToShowIcons = "DoubleClickDesktopToShowIconsKey"
    let kAutoHideDesktopIcons = "AutoHideDesktopIconsKey"
    let kEnableAnimationAudio = "EnableAnimationAudioKey"
    let kAutoToggleDarkModeBaseOnDisplayBrightness = "AutoToggleDarkModeBaseOnDisplayBrightnessKey"
    let kAutoToggleDarkModeBaseOnDisplayBrightnessValue = "AutoToggleDarkModeBaseOnDisplayBrightnessValueKey"
    let kEnableFinderExtension = "EnableFinderExtensionKey"
    let kEnableKaka = "EnableKakaKey"
    let kRequestRating = "RequestRating"
    let kAutoHideDesktopIconTimeOut = "AutoHideDesktopIconTimeOut"
    let kAutoHideCursorTimeOut = "AutoHideCursorTimeOut"
    let kDeactivateCriticalBatteryCharge = "DeactivateCriticalBatteryCharge"
    let kDeactivateCriticalBatteryChargeThreshold = "DeactivateCriticalBatteryChargeThreshold"
    
    func setLaunchAtLogin(bFlag: Bool) -> Void {
        SMLoginItemSetEnabled(helperBundleIdentifier as CFString, bFlag)
    }
    
    func isLaunchAtLogin() -> Bool {
        guard let jobs = (SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]]) else {
            return false
        }
        let job = jobs.first { $0["Label"] as! String == helperBundleIdentifier}
        return job?["OnDemand"] as? Bool ?? false
    }
    
    func setAutoHideMouseCursor(bFlag: Bool) -> Void {
        UserDefaults.standard.set(bFlag, forKey: kAutoHideMouseCursor)
    }
    
    func isAutoHideMouseCursor() -> Bool {
        return UserDefaults.standard.bool(forKey: kAutoHideMouseCursor)
    }
    
    func setOneClickToHideDesktopIcons(bFlag: Bool) -> Void{
        UserDefaults.standard.set(!bFlag, forKey: kOneClickToHideDesktopIcons)
    }
    
    func isOneClickToHideDesktopIcons() -> Bool{
        return !UserDefaults.standard.bool(forKey: kOneClickToHideDesktopIcons)
    }
    
    func setDoubleClickToShowDesktop(bFlag: Bool) -> Void{
        UserDefaults.standard.set(!bFlag, forKey: kDoubleClickToShowDesktop)
    }
    
    func isDoubleClickToShowDesktop() -> Bool{
        return !UserDefaults.standard.bool(forKey: kDoubleClickToShowDesktop)
    }
    
    func setDoubleClickDesktopToShowIcons(bFlag: Bool) -> Void{
        UserDefaults.standard.set(!bFlag, forKey: kDoubleClickDesktopToShowIcons)
    }
    
    func isDoubleClickDesktopToShowIcons() -> Bool{
        return !UserDefaults.standard.bool(forKey: kDoubleClickDesktopToShowIcons)
    }
    
    func setAutoHideDesktopIcons(bFlag: Bool) -> Void{
        UserDefaults.standard.set(bFlag, forKey: kAutoHideDesktopIcons)
    }
    
    func isAutoHideDesktopIcons() -> Bool{
        return UserDefaults.standard.bool(forKey: kAutoHideDesktopIcons)
    }
    
    func setEnableAnimationAudio(bFlag: Bool) -> Void{
        UserDefaults.standard.set(bFlag, forKey: kEnableAnimationAudio)
    }
    
    func isEnableAnimationAudio() -> Bool{
        return UserDefaults.standard.bool(forKey: kEnableAnimationAudio)
    }
    
    func setAutoToggleDarkModeBaseOnDisplayBrightness(bFlag: Bool) -> Void{
        UserDefaults.standard.set(bFlag, forKey: kAutoToggleDarkModeBaseOnDisplayBrightness)
    }
    
    func isAutoToggleDarkModeBaseOnDisplayBrightness() -> Bool{
        return UserDefaults.standard.bool(forKey: kAutoToggleDarkModeBaseOnDisplayBrightness)
    }
    
    func setAutoToggleDarkModeBaseOnDisplayBrightnessValue(value: Float) -> Void{
        UserDefaults.standard.set(value, forKey: kAutoToggleDarkModeBaseOnDisplayBrightnessValue)
    }
    
    func autoToggleDarkModeBaseOnDisplayBrightnessValue() -> Float{
        if nil == UserDefaults.standard.value(forKey: kAutoToggleDarkModeBaseOnDisplayBrightnessValue) {
            return 0.2
        }
        return UserDefaults.standard.float(forKey: kAutoToggleDarkModeBaseOnDisplayBrightnessValue)
    }
    
    func setEnableFinderExtension(bFlag: Bool) -> Void{
        UserDefaults.standard.set(bFlag, forKey: kEnableFinderExtension)
    }
    
    func isEnableFinderExtension() -> Bool{
        return UserDefaults.standard.bool(forKey: kEnableFinderExtension)
    }
    
    func setEnableKaka(bFlag: Bool) -> Void{
        UserDefaults.standard.set(!bFlag, forKey: kEnableKaka)
    }
    
    func isEnableKaka() -> Bool{
        return !UserDefaults.standard.bool(forKey: kEnableKaka)
    }
    
    func setKeyComboWithIdentifier(keyCombo: SCKeyCombo?, identifier: String) -> Void{
        let id = identifier + "KeyCombo"
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: keyCombo as Any), forKey: id)
    }

    func keyComboWithIdentifier(identifier: String) -> SCKeyCombo?{
        let id = identifier + "KeyCombo"
        guard let data = UserDefaults.standard.object(forKey: id) else {
            return nil;
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? SCKeyCombo
    }
    
    func setRequestRating(bFlag: Bool) -> Void{
        UserDefaults.standard.set(!bFlag, forKey: kRequestRating)
    }
    
    func isRequestRating() -> Bool{
        return !UserDefaults.standard.bool(forKey: kRequestRating)
    }
    
    func setAutoHideDesktopIconTimeOut(nSeconds: Int) -> Void {
        UserDefaults.standard.set(nSeconds, forKey: kAutoHideDesktopIconTimeOut)
    }
    
    func autoHideDesktopIconTimeOut() -> Int {
        let value = UserDefaults.standard.value(forKey: kAutoHideDesktopIconTimeOut)
        if nil == value {
            return 10
        }else{
            return value as! Int
        }
    }
    
    func setAutoHideCursorTimeOut(nSeconds: Int) -> Void {
        UserDefaults.standard.set(nSeconds, forKey: kAutoHideCursorTimeOut)
    }
    
    func autoHideCursorTimeOut() -> Int {
        let value = UserDefaults.standard.value(forKey: kAutoHideCursorTimeOut)
        if nil == value {
            return 3
        }else{
            return value as! Int
        }
    }
    
    func setDeactivateCriticalBatteryCharge(bFlag: Bool) -> Void {
        UserDefaults.standard.set(!bFlag, forKey: kDeactivateCriticalBatteryCharge)
    }
    
    func isDeactivateCriticalBatteryCharge() -> Bool {
        return !UserDefaults.standard.bool(forKey: kDeactivateCriticalBatteryCharge)
    }
    
    func setDeactivateCriticalBatteryChargeThreshold(nValue: Float) -> Void {
        UserDefaults.standard.set(nValue, forKey: kDeactivateCriticalBatteryChargeThreshold)
    }
    
    func deactivateCriticalBatteryChargeThreshold() -> Float {
        let value = UserDefaults.standard.value(forKey: kDeactivateCriticalBatteryChargeThreshold)
        if nil == value {
            return 0.1
        }else{
            return value as! Float
        }
    }
}
