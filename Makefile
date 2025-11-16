.PHONY: all install lint check run help requirements

all: help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

requirements: ## Install Ansible Galaxy requirements
	ansible-galaxy install -r requirements.yml

lint: ## Run ansible-lint on playbooks
	ansible-lint site.yml

check: ## Run playbook in check mode (dry run)
	ansible-playbook site.yml --check -K

run: ## Run the full playbook
	ansible-playbook site.yml -K

homebrew: ## Run only homebrew tasks
	ansible-playbook site.yml --tags homebrew -K

apps: ## Run only apps/casks tasks
	ansible-playbook site.yml --tags apps -K

development: ## Run only development tasks
	ansible-playbook site.yml --tags development -K

dotfiles: ## Run only dotfiles tasks
	ansible-playbook site.yml --tags dotfiles -K

macos: ## Run only macOS defaults tasks
	ansible-playbook site.yml --tags macos -K

syntax: ## Check playbook syntax
	ansible-playbook site.yml --syntax-check

list-tags: ## List all available tags
	ansible-playbook site.yml --list-tags

list-tasks: ## List all tasks
	ansible-playbook site.yml --list-tasks
