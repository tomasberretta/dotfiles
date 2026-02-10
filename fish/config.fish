# Fish Shell Configuration

# Suppress greeting
set -g fish_greeting

if status is-interactive
	# Homebrew
	eval (/opt/homebrew/bin/brew shellenv)

	# Initialize Starship prompt
	starship init fish | source

	# Zoxide
	zoxide init fish | source

	# Aliases
	alias ts='~/Projects/Sandbox/dotfiles/scripts/start_project.sh'

	function book
		cd ~/Projects/Work/Kognitos/book-"$argv[1]"
	end
end

# Function: ks
function ks
    if type -q bass
        # Use bass to source the bash script and import env changes
        bass source /Users/tomiberretta/Projects/Work/Kognitos/bdk-toolbox/scripts/k8s-context-switch/switch.sh $argv
    else
        bash /Users/tomiberretta/Projects/Work/Kognitos/bdk-toolbox/scripts/k8s-context-switch/switch.sh $argv
    end
end
