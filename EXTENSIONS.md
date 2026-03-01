# Omakub Extensions

This document lists community-contributed extensions and officially added enhancements to Omakub.

## Official Enhancements (v1.6+)

The following tools have been added to Omakub as optional installations through the enhancement roadmap:

### Phase 1: Browsers & Development Tools (v1.6)

#### Web Browsers
- **Firefox** - Mozilla's open-source browser (APT via Mozilla repository)
  - Includes APT pinning to prevent Ubuntu's Snap transition
  - Usage: `firefox`
- **Chromium** - Open-source foundation of Chrome (Flatpak)
  - Usage: `chromium`
- **Microsoft Edge** - Chromium-based browser with Microsoft integration (APT via Microsoft repository)
  - Usage: `microsoft-edge`

#### API Clients
- **Postman** - Industry-standard API testing platform (Flatpak)
  - Usage: `postman`
- **Bruno** - Open-source, lightweight API client (DEB package v3.1.1)
  - Usage: `bruno`

#### System Utilities
- **Peek** - Simple screen recorder for GIFs and videos (APT)
  - Note: Works on X11; limited Wayland support
  - Usage: `peek`
- **Font Manager** - GUI tool for managing system fonts (APT)
  - Usage: `font-manager`
#### Code Editors
- **Zed** - Fast, modern code editor built in Rust (APT via Zed repository)
  - High-performance, collaborative editing with native LSP support
  - Usage: `zed`


#### Configuration Enhancements
- **inotify watches** - Increases system file watch limit to 524288
  - Prevents "too many open files" errors with Node.js, React, Dropbox
  - Applied automatically during installation
- **SSH key generation** - Interactive setup for Ed25519 or RSA 4096 keys
  - Includes instructions for GitHub/GitLab integration
  - Usage: Run during Omakub setup or manually via `~/.local/share/omakub/install/terminal/setup-ssh-keys.sh`
- **Git configuration** - Enhanced interactive setup with fallback prompts
  - Prompts for user.name and user.email if not already configured

#### Fixed Issues
- **VirtualBox** - Now installs from official .deb package (v7.2.6) instead of broken APT package
  - Works correctly on Ubuntu 24.04

### Phase 2: DevOps & Cloud Tools (v1.7)

#### Infrastructure as Code
- **Terraform** - Infrastructure provisioning and management (APT via HashiCorp repository)
  - Includes bash completion
  - Usage: `terraform`
- **Helm** - Kubernetes package manager (APT via Helm repository)
  - Usage: `helm`

#### Kubernetes & Container Tools
- **kubectl** - Kubernetes command-line tool (APT via Kubernetes v1.35 repository)
  - Includes bash completion
  - Usage: `kubectl`
- **Podman** - Rootless container runtime, Docker alternative (APT)
  - Includes /etc/containers/nodocker to suppress compatibility warnings
  - Usage: `podman`

#### Cloud CLIs
- **AWS CLI v2** - Amazon Web Services command-line interface (Zip installer)
  - Includes version check and upgrade support
  - Usage: `aws`
- **Azure CLI** - Microsoft Azure command-line interface (Microsoft install script)
  - Usage: `az`
- **Azure Storage Explorer** - GUI for Azure blob storage (Flatpak)
  - Usage: `flatpak run com.microsoft.AzureStorageExplorer`

#### System Performance
- **Htop** - Interactive process viewer, alternative to btop (APT)
  - Usage: `htop`
- **BleachBit** - System cleaner and privacy tool (Flatpak)
  - Usage: `flatpak run org.bleachbit.BleachBit`

### Phase 3: Security & Authentication (v1.8)

#### Security Tools
- **GPG key setup** - Interactive GPG key generation for commit signing
  - Supports Ed25519 (modern) and RSA 4096
  - Configurable expiration (no expiration, 1/2/5 years)
  - Auto-configures Git for signed commits
  - Includes GitHub/GitLab integration instructions
  - Usage: Run during Omakub setup or manually via `~/.local/share/omakub/install/terminal/setup-gpg-keys.sh`
- **Wireshark** - Network protocol analyzer (APT)
  - Includes non-root packet capture permissions setup
  - Requires logout/login after installation for group changes
  - Usage: `wireshark`
- **USBGuard** - USB device authorization and policy management (APT)
  - Protects against unauthorized USB devices and BadUSB attacks
  - Interactive warnings explain policy implications before installation
  - Usage: `usbguard` (requires policy configuration, see documentation)

### Phase 4: Specialized Development Tools (v1.9+)

#### IDEs & Development Environments
- **JetBrains Toolbox** - Unified installer for all JetBrains IDEs (Tarball, latest version)
  - Includes libfuse2t64 dependency for Ubuntu 24.04
  - Manage IntelliJ IDEA, PyCharm, WebStorm, and more
  - Usage: Launch toolbox from application menu
- **Eclipse IDE** - Java development environment (Flatpak)
  - Includes Java 17+ dependency check and auto-installation
  - Usage: `flatpak run org.eclipse.Java`

#### Programming Language Support
- **.NET SDK 8.0 LTS** - Microsoft .NET development platform (APT via Microsoft repository)
  - Usage: `dotnet`
- **Delve** - Go language debugger (go install)
  - Requires Go to be installed first
  - Usage: `dlv`

#### Communication & Collaboration
- **Slack** - Team communication platform (Flatpak)
  - Usage: `slack`
- **Microsoft Teams** - Video conferencing and collaboration (Flatpak)
  - Usage: `flatpak run com.github.IsmaelMartinez.teams_for_linux`

## Installation

All tools listed above are available during the Omakub first-run setup through the optional apps menu, or can be installed individually by sourcing their respective scripts:

```bash
# Example: Install Terraform
source ~/.local/share/omakub/install/terminal/optional/app-terraform.sh

# Example: Install Firefox
source ~/.local/share/omakub/install/desktop/optional/app-firefox.sh

# Example: Run GPG key setup
source ~/.local/share/omakub/install/terminal/setup-gpg-keys.sh
```


### Additional Tools

#### Package Managers & Database Clients
- **LazyNPM** - Terminal UI for NPM package management (Binary v0.1.4)
  - Requires Node.js and npm pre-installed
  - Navigate package.json scripts, dependencies, and npm commands with keyboard shortcuts
  - Usage: `lazynpm`
- **LazySQL** - Terminal UI for database management (Binary v0.4.8)
  - Supports MySQL, PostgreSQL, SQLite
  - Fast, keyboard-driven interface with statically-linked binary
  - Usage: `lazysql`
- **Beekeeper Studio** - Modern GUI SQL client (APT via Beekeeper repository)
  - Cross-database support with beautiful interface
  - Query editor with autocomplete and syntax highlighting
  - Usage: `beekeeper-studio`

#### Networking & Tunneling
- **ngrok** - Secure tunneling to localhost (APT v3.34+)
  - Expose local servers with public URLs for testing webhooks/APIs
  - Requires ngrok account for authentication
  - Usage: `ngrok http 3000` (then visit https://dashboard.ngrok.com to get auth token)

#### Media Applications
- **YouTube Music** - Desktop app for YouTube Music (DEB v3.11.0)
  - Native desktop experience with media key support
  - Built by Pear Devs community
  - Usage: Launch from applications menu or `youtube-music`


#### Gaming & Game Development
- **Sober** - Roblox game client for Linux (Flatpak v1.6+)
  - Uses Android runtime to bypass Hyperion anti-cheat restrictions
  - Only working method to play Roblox on Linux as of 2026
  - Requires Vulkan 1.0 or OpenGL ES 3.0 support
  - Usage: `flatpak run org.vinegarhq.Sober`
- **Vinegar** - Roblox Studio launcher for Linux (Flatpak v1.9+)
  - Wine-based bootstrapper optimized for Roblox Studio development
  - Full Roblox Studio functionality with game editor, scripting, and testing
  - Usage: `flatpak run org.vinegarhq.Vinegar`
  - Note: Use Sober for playing, Vinegar for development

## Community Extensions

### [Dark and light mode theme switch](https://github.com/florentdestremau/omakub-darkmode-switch)

Select a dark and light theme of your choice to be applied automatically when switching the gnome light/dark mode.
