# Mac Setup

[![Ansible](https://img.shields.io/badge/Ansible-2.15+-green.svg)](https://www.ansible.com/)
[![macOS](https://img.shields.io/badge/macOS-Ventura%20|%20Sonoma%20|%20Sequoia%20|%20Tahoe-blue.svg)](https://www.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Automated setup for macOS development environment using Ansible. This playbook configures a fresh any Mac with development tools, applications, and sensible defaults.

## Features

- **Homebrew Package Management** - CLI tools and GUI applications
- **Development Environment** - Languages, Git config, SSH keys
- **macOS System Preferences** - Dock, Finder, keyboard, trackpad settings
- **Dotfiles Management** - Clone and symlink your dotfiles
- **Fully Customizable** - Everything configured via variables

## Quick Start

### Prerequisites

- macOS Ventura (13.0) or later
- Command Line Tools for Xcode
```bash
xcode-select --install
```

### Installation

1. **Clone this repository:**
```bash
git clone https://github.com/koolwilly72/mac-setup.git
cd mac-setup
```

2. **Install Ansible:**
```bash
# Using Homebrew (if already installed)
brew install ansible

# Or using pip
pip3 install --user ansible
```

3. **Install required Ansible collections:**
```bash
ansible-galaxy install -r requirements.yml
```

4. **Customize your configuration:**
```bash
cp group_vars/all.yml group_vars/all.yml.bak
# Edit group_vars/all.yml with your preferences
```

5. **Run the playbook:**
```bash
ansible-playbook site.yml -K
```

The `-K` flag prompts for your sudo password (required for some operations).

## Configuration

All configuration is done in `group_vars/all.yml`. Key sections include:

### Homebrew Packages
```yaml
homebrew_packages:
  - git
  - neovim
  - tmux
```

### GUI Applications (Casks)
```yaml
homebrew_casks:
  - visual-studio-code
  - docker
  - slack
```

### Development Languages
```yaml
development_languages:
  - python@3.12
  - node
  - go
```

### Git Configuration
```yaml
git_user_name: "Your Name"
git_user_email: "your.email@example.com"
```

### macOS Preferences
```yaml
macos_dock_autohide: true
macos_finder_show_hidden: true
macos_key_repeat_rate: 2
```

### Dotfiles
```yaml
dotfiles_repo: "https://github.com/koolwilly72/dotfiles.git"
dotfiles_symlink: true
```

## Usage

### Run Everything
```bash
ansible-playbook site.yml -K
```

### Run Specific Roles
```bash
# Only install Homebrew packages
ansible-playbook site.yml --tags homebrew -K

# Only configure macOS defaults
ansible-playbook site.yml --tags macos -K

# Only setup development tools
ansible-playbook site.yml --tags development -K
```

### Check Mode (Dry Run)
```bash
ansible-playbook site.yml --check -K
```

### Verbose Output
```bash
ansible-playbook site.yml -K -vvv
```

## Project Structure
```
mac-setup/
├── site.yml                    # Main playbook
├── requirements.yml            # Ansible Galaxy dependencies
├── group_vars/
│   └── all.yml                 # Configuration variables
├── inventory/
│   └── hosts                   # Inventory file
└── roles/
    ├── homebrew/               # CLI package management
    ├── apps/                   # GUI applications
    ├── development/            # Languages & dev tools
    ├── dotfiles/               # Dotfile management
    └── macos-defaults/         # System preferences
```

## Customization Examples

### Adding Mac App Store Apps

First, find the app ID using `mas`:
```bash
brew install mas
mas search "App Name"
```

Then add to `group_vars/all.yml`:
```yaml
mas_apps:
  - id: 497799835
    name: "Xcode"
  - id: 803453959
    name: "Slack"
```

### Adding Homebrew Taps
```yaml
homebrew_taps:
  - homebrew/cask-fonts
  - hashicorp/tap
```

### Custom Python/Node Packages
```yaml
python_packages:
  - black
  - poetry
  - django

node_packages:
  - yarn
  - nx
  - vercel
```

## Idempotency

This playbook is idempotent—running it multiple times will not cause issues. It will only make changes when necessary.

## Troubleshooting

### Permission Denied

Some operations require sudo. Always run with `-K`:
```bash
ansible-playbook site.yml -K
```

### Homebrew Issues

If Homebrew fails, ensure it's properly installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Collection Not Found

Install required collections:
```bash
ansible-galaxy install -r requirements.yml --force
```

### Cask Already Installed

Some casks might fail if already installed via other means. These errors are ignored by default.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by various dotfile and Mac setup repositories
- Built with [Ansible](https://www.ansible.com/)
- Uses [Homebrew](https://brew.sh/) for package management

## Related Projects

- [dotfiles](https://dotfiles.github.io/) - Your unofficial guide to dotfiles on GitHub
- [awesome-macos-command-line](https://herrbischoff.com/code/me/awesome-macos-command-line) - macOS command line tools