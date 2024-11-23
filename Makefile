NAME = "Your Name"
EMAIL = "your@email.com"
GITIGNORE = "linux,swift,xcode,macos,objective-c,visualstudiocode"

# INTEL_FLAGS = ""
# ifneq ($(filter arm%,$(shell uname -p)),)
# 	INTEL_FLAG = "arch -x86_64"
# endif

all: setup configure install-dev install-dev-ios install-design install-productivity install-teamwork install-fun
.PHONY: all

setup:
	@echo ""
	@echo "Setting up"
	@echo ""

	@echo "Installing Homebrew..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install wget
	brew install nmap

	# terminal setup
	# ref: https://gist.github.com/kevin-smets/8568070
	@echo "Installing iTerm2..."
	brew install --cask iterm2 # terminal
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	brew install powerlevel10k
	echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
	brew install --cask font-meslo-for-powerline
	
	@echo "Installing Oh My Zsh..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions $$ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-completions $$ZSH_CUSTOM/plugins/zsh-completions

	PLUGINS = zsh-syntax-highlighting zsh-autosuggestions zsh-completions
	@echo "Updating .zshrc with new plugins..."
	for plugin in $(PLUGINS); do \
		if ! grep -q "$$plugin" ~/.zshrc; then \
			sed -i '' "/^plugins=/ s/)/ $$plugin)/" ~/.zshrc; \
		fi; \
	done
	source ~/.zshrc
	@echo ".zshrc updated."

	# vim
	echo 'syntax on' >> ~/.vimrc
	echo 'set t_Co=256' >> ~/.vimrc
	echo 'set fileencodings=utf-8' >> ~/.vimrc

	# alias
	echo 'alias vsc="code"' >> ~/.zshrc
	echo 'alias xcode="open -a Xcode"' >> ~/.zshrc
	echo 'alias simulator="open -a Simulator"' >> ~/.zshrc
	source ~/.zshrc
.PHONY: setup

configure:
	@echo ""
	@echo "Configuring git..."
	@echo ""

	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)
	curl -sL https://www.gitignore.io/api/$(GITIGNORE) -o ~/.gitignore_global
	git config --global core.excludesfile ~/.gitignore
.PHONY: configure

install-dev:
	@echo ""
	@echo "Installing development tools..."
	@echo ""

	brew install gitmoji # integrate emoji into git commit
	brew install --cask fork # GUI for git
	brew install --cask visual-studio-code # Code editor

	brew install --cask docker # Container
	# brew install nvm # node version manager
	# brew install nodejs
	# python -m pip install --user virtualenv # python virtual environment

	brew install --cask postman # API tool
	# brew install --cask proxyman # Inspect HTTP(s) requests/responses
.PHONY: install-dev

install-dev-ios:
	@echo ""
	@echo "Installing iOS development tools..."
	@echo ""

	brew install cocoapods
	# sudo gem install cocoapods -v 1.7.1
	pod setup
	brew install carthage
	# brew install fastlane # automate tool

	# brew install --cask dash # Offline API document
	# brew install --cask android-studio # Android development GUI
.PHONY: install-dev-ios

install-design:
	@echo ""
	@echo "Installing design tools..."
	@echo ""

	brew install --cask figma # Design tool
	brew install --cask zeplin # Design tool
.PHONY: install-design

install-productivity:
	@echo ""
	@echo "Installing productivity tools..."
	@echo ""

	brew install bat # customized of 'cat'
	brew install --cask appcleaner
	brew install --cask the-unarchiver
	brew install --cask eul # system monitor
	brew install --cask hiddenbar # hide menu bar
	brew install --cask time-out # remind you to break

	brew install --cask google-chrome
	brew install --cask brave-browser

	brew install --cask notion
	# brew install --cask teamviewer # remote tool
	# brew install --cask anydesk # remote tool

	# brew install --cask typora # MARKDOWN editor
	# brew install --cask macdown # MARKDOWN editor
.PHONY: install-productivity

install-teamwork:
	@echo ""
	@echo "Installing teamwork tools..."
	@echo ""

	# brew install --cask hamsket-nightly # all-in-one messaging station
	brew install --cask zoom
	brew install --cask slack
	# brew install --cask discord
	# brew install --cask telegram
	# brew install --cask skype
	# brew install --cask microsoft-teams
.PHONY: install-teamwork

install-fun:
	@echo ""
	@echo "Installing fun tools..."
	@echo ""
	
	brew install --cask spotify
	# brew install --cask vlc
	# brew install --cask tradingview
.PHONY: install-fun