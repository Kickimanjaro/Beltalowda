# Beltalowda UI - Quick Reference Card

## 🎯 What is This?

Beltalowda displays your group's ultimate readiness in real-time. See who has what ultimate ready at a glance!

## 🚀 Quick Start (3 Steps)

1. **Install required libraries** from ESOUI.com:
   - LibGroupCombatStats
   - LibSetDetection
   - LibAddonMenu-2.0
   - LibAsync
   - LibGroupBroadcast

2. **Enter the game** - UI appears automatically

3. **Choose your ultimate** - Click the selector box to pick which ultimate to show the group

## 📱 UI Elements

### Group Ultimate Display
- **12 columns** = different ultimate types
- **Stacked bars** = group members with that ultimate
- **Colors** = readiness status
  - 🟢 Green = Ready (100%)
  - 🟡 Yellow = Almost (75-99%)
  - 🟠 Orange = Building (50-74%)
  - ⚪ Gray = Not ready (<50%)

### Client Ultimate Selector
- **Single icon** = your chosen ultimate
- **Click** = cycle through your ultimates
- **Hover** = see ultimate details

## ⌨️ Essential Commands

```
/btlwui toggle     Toggle UI on/off
/btlwui lock       Lock/unlock for moving
/btlwsettings      Open settings
```

## 🎮 Keybinds

Set in ESO Controls → Beltalowda:
- Toggle Group Display
- Toggle Selector
- Toggle Lock
- Cycle Ultimate

## ⚙️ Common Settings

Access via `/btlwsettings`:

- **Enable/Disable** - Turn UI on/off
- **Lock** - Prevent accidental movement  
- **Scale** - Make bigger/smaller
- **Opacity** - Adjust transparency

## 🔧 Troubleshooting

### UI Not Showing?
```
/btlwui toggle
/reloadui
```

### No Data Showing?
1. Are you in a group?
2. Do groupmates have the addon?
3. Try using an ultimate ability
4. Check: `/btlwdata status`

### Ultimate Not Detected?
1. Make sure ultimate is slotted
2. Click the selector to cycle
3. Swap bars to refresh

### Window Off Screen?
```
/btlwui lock      (unlock)
[drag to visible area]
/btlwui lock      (lock again)
```

## 📚 More Help

- Full guide: `docs/UI_GUIDE.md`
- Testing: `docs/UI_TESTING_GUIDE.md`
- Debug: `/btlwdata help`

## 💡 Pro Tips

1. **Lock your UI** after positioning to avoid accidents
2. **Use keybinds** for quick toggle during combat
3. **Scale down** if you have limited screen space
4. **Reduce opacity** to see through UI in combat
5. **Test in a group** to see full functionality

## ⚠️ Known Limitations

- Manual ultimate selection (no auto-detect yet)
- Selection not broadcast to group yet (coming soon)
- Fixed list of 12 ultimate types (customization coming)

## 🆘 Support

Having issues? Use these debug commands:

```
/btlwdata status    Check data sync
/btlwdata ults      View group ultimates
/btlwdata libapi    Check library status
```

## 📊 What's Next?

Future updates will add:
- Automatic ultimate detection
- Broadcasting to group
- Customizable ultimate list
- Attack coordination timers
- Enhanced visual effects

---

**Version:** 0.4.0 (Phase 4)  
**Author:** Kickimanjaro  
**License:** See LICENSE file
