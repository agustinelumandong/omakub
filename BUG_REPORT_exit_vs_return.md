# Critical Bug Report: exit vs return in Sourced Scripts

## Summary

**Bug Pattern**: Scripts sourced by main installer used `exit 0` instead of `return 0` when skipping execution, terminating the entire installation process.

**Impact**: Installation stopped prematurely on Pop!_OS COSMIC desktop, preventing COSMIC-specific settings from being applied.

**Root Cause**: Bash `exit` terminates the calling process when script is sourced (`. script.sh`), whereas `return` only exits the sourced script.

## Affected Installations

- **Terminal Installation**: Stopped at SSH or GPG key setup when user chose to skip
- **Desktop Installation**: Stopped at first GNOME script when running on COSMIC desktop

## Timeline of Fixes

### Commit 9e235f5 (Test 6)
**File**: `install/terminal/setup-gpg-keys.sh`
**Line**: 38
**Change**: `exit 0` → `return 0`
**Issue**: Installation stopped when user chose to skip GPG setup or use existing keys

### Commit 3e94c0c (Test 7) ✅ WORKING
**File**: `install/terminal/setup-ssh-keys.sh`
**Lines**: 15, 35
**Change**: `exit 0` → `return 0`
**Issue**: Installation stopped when user chose to skip SSH setup or use existing keys
**Result**: Desktop apps installation finally reached!

### Commit 71422bb (Current Fix #1)
**Files**: 6 GNOME scripts
- `install/desktop/app-gnome-sushi.sh` (line 3)
- `install/desktop/app-gnome-tweak-tool.sh` (line 3)
- `install/desktop/set-app-grid.sh` (line 3)
- `install/desktop/set-framework-text-scaling.sh` (line 3)
- `install/desktop/set-gnome-extensions.sh` (line 3)
- `install/desktop/set-gnome-settings.sh` (line 3)

**Change**: `exit 0` → `return 0` in GNOME detection guards
**Issue**: First GNOME script (`app-gnome-sushi.sh`, alphabetically #5 in desktop/) terminated installation
**Evidence**: Log line 3704 showed "Skipping (GNOME only): app-gnome-sushi.sh" as last line before shell prompt

**Result**: COSMIC scripts (`set-cosmic-settings.sh`, `set-cosmic-shortcuts.sh`) never executed because they come alphabetically AFTER GNOME scripts.

### Commit c09332a (Current Fix #2)
**Files**: 2 unguarded GNOME scripts
- `install/desktop/set-gnome-hotkeys.sh`
- `install/desktop/set-gnome-theme.sh`

**Change**: Added GNOME guards with `return 0`
**Issue**: These scripts had NO guards at all, running unconditionally on COSMIC
**Impact**: Wasted time executing 81+ `gsettings` commands that do nothing on COSMIC

## The Pattern

### ❌ WRONG (Terminates entire installation)
```bash
#!/bin/bash
is_gnome || { echo "Skipping..."; exit 0; }
# Rest of script
```

### ✅ CORRECT (Returns from sourced script)
```bash
# GNOME guard
is_gnome() { [[ "${OMAKUB_DE:-}" == *"GNOME"* ]]; }
is_gnome || { echo "  Skipping (GNOME only): script-name.sh"; return 0; }

#!/bin/bash
# Rest of script
```

## Why This Happened

1. **install/terminal.sh** sources all `*.sh` files alphabetically:
   ```bash
   for installer in ~/.local/share/omakub/install/terminal/*.sh; do source $installer; done
   ```

2. **install/desktop.sh** sources all `*.sh` files alphabetically:
   ```bash
   for installer in ~/.local/share/omakub/install/desktop/*.sh; do source $installer; done
   ```

3. **Main installer** uses `set -e`:
   ```bash
   set -e  # Exit on any error
   ```

4. When a sourced script calls `exit 0`, it exits the PARENT process (install.sh), not just the sourced script.

## Alphabetical Execution Order (Desktop)

```
 1. a-flatpak.sh
 2. app-alacritty.sh
 3. app-chrome.sh
 4. app-flameshot.sh
 5. app-gnome-sushi.sh        ← BUG: exit 0 stopped here on COSMIC
 6. app-gnome-tweak-tool.sh   ← Never reached
 ...
22. set-cosmic-settings.sh    ← Never reached (THE FIX TARGET!)
23. set-cosmic-shortcuts.sh   ← Never reached (THE FIX TARGET!)
24. set-dock.sh
25. set-framework-text-scaling.sh
26. set-gnome-extensions.sh   ← Never reached
27. set-gnome-hotkeys.sh      ← Never reached
28. set-gnome-settings.sh     ← Never reached
29. set-gnome-theme.sh        ← Never reached
30. set-xcompose.sh
31. ulauncher.sh
```

## Verification Evidence

### Before Fix
```bash
cshan@pop-os:~$ echo $XDG_CURRENT_DESKTOP
COSMIC

cshan@pop-os:~$ ls -la ~/.config/cosmic/com.system76.CosmicComp/v1/autotile
-rw-r--r-- 1 cshan cshan 5 Mar  1 03:27 autotile
# Contains: true (COSMIC's default, NOT set by our script)

cshan@pop-os:~$ grep -i "cosmic" ~/.local/share/omakub/install-20260301-201105.log
# NO OUTPUT - Scripts never ran!

cshan@pop-os:~$ grep "set-cosmic" ~/.local/share/omakub/install-20260301-201105.log
# NO OUTPUT - Scripts never executed!
```

### Installation Log Evidence
```
Line 3704: "Skipping (GNOME only): app-gnome-sushi.sh"
Line 3705: "cshan@pop-os:~$"  ← Returned to shell, installation STOPPED
```

## Expected After Fix

After next installation test (Test 8):

1. **All GNOME scripts will be skipped gracefully** with `return 0`
2. **Installation will continue** past GNOME scripts to COSMIC scripts
3. **COSMIC scripts will execute**: `set-cosmic-settings.sh`, `set-cosmic-shortcuts.sh`
4. **COSMIC config files will be created**:
   - `~/.config/cosmic/com.system76.CosmicTheme.Dark/v1/active` (dark mode)
   - `~/.config/cosmic/com.system76.CosmicComp/v1/autotile` (updated with our settings)
   - `~/.config/cosmic/com.system76.CosmicComp/v1/custom_keybindings` (keyboard shortcuts)
5. **Installation log will contain** "COSMIC settings applied" messages

## Testing Checklist

- [ ] Run new installation on Pop!_OS COSMIC
- [ ] Verify log contains "Skipping (GNOME only)" messages (8 scripts)
- [ ] Verify log contains "COSMIC settings applied" message
- [ ] Verify dark mode enabled: check System Settings → Appearance
- [ ] Verify auto-tiling enabled: press Super+Y or check workspace behavior
- [ ] Verify custom shortcuts work: Super+E (terminal), Super+Space (app launcher)
- [ ] Verify all 8 GNOME scripts were skipped, not causing errors
- [ ] Verify installation completes successfully and returns to shell

## Files Changed (Total: 10 files, 3 commits)

### exit → return fixes (8 files)
1. `install/terminal/setup-gpg-keys.sh` (commit 9e235f5)
2. `install/terminal/setup-ssh-keys.sh` (commit 3e94c0c) 
3. `install/desktop/app-gnome-sushi.sh` (commit 71422bb)
4. `install/desktop/app-gnome-tweak-tool.sh` (commit 71422bb)
5. `install/desktop/set-app-grid.sh` (commit 71422bb)
6. `install/desktop/set-framework-text-scaling.sh` (commit 71422bb)
7. `install/desktop/set-gnome-extensions.sh` (commit 71422bb)
8. `install/desktop/set-gnome-settings.sh` (commit 71422bb)

### Guard additions (2 files)
9. `install/desktop/set-gnome-hotkeys.sh` (commit c09332a)
10. `install/desktop/set-gnome-theme.sh` (commit c09332a)

## Lessons Learned

1. **Always use `return` in sourced scripts**, never `exit` (unless intentionally stopping entire process)
2. **Test on BOTH GNOME and COSMIC** to catch desktop-specific issues
3. **Check alphabetical execution order** when scripts depend on each other
4. **Guard ALL desktop-specific scripts** to prevent wasteful execution
5. **Comprehensive logging** is essential for remote debugging (saved us here!)

## Related Issues

- Original bug pattern also appeared in SSH and GPG setup scripts
- Same fix applied: `exit 0` → `return 0`
- This is a **systematic issue** with the sourcing pattern used throughout Omakub

## Future Prevention

Consider adding a linting rule or pre-commit hook to catch `exit 0` in sourced scripts:

```bash
# Check for exit in sourced scripts
grep -r "exit 0" install/**/*.sh | grep -v "^#" && echo "WARNING: Found exit 0 in sourced scripts!"
```
