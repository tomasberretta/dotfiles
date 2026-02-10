# Fish Shell Configuration

# Suppress greeting
set -g fish_greeting

if status is-interactive
	# Homebrew
	eval (/opt/homebrew/bin/brew shellenv)

	# Initialize Starship prompt
	set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
	starship init fish | source

	# Zoxide
	zoxide init fish | source

	# --- Tokyo Night Theme (matches starship palette) ---
	# Syntax highlighting
	set -g fish_color_normal C0CAF5
	set -g fish_color_command 7AA2F7
	set -g fish_color_keyword 9D7CD8
	set -g fish_color_quote 9ECE6A
	set -g fish_color_redirection 7DCFFF
	set -g fish_color_end FF9E64
	set -g fish_color_error BF616A
	set -g fish_color_param C0CAF5
	set -g fish_color_comment 515669
	set -g fish_color_operator 7DCFFF
	set -g fish_color_escape D08770
	set -g fish_color_autosuggestion 515669
	set -g fish_color_valid_path --underline
	set -g fish_color_selection --background=3A3D4A
	set -g fish_color_search_match --background=3A3D4A
	set -g fish_color_cancel BF616A

	# Pager (tab completion menu)
	set -g fish_pager_color_progress 515669
	set -g fish_pager_color_prefix 7DCFFF --bold
	set -g fish_pager_color_completion C0CAF5
	set -g fish_pager_color_description 515669
	set -g fish_pager_color_selected_background --background=3A3D4A

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
