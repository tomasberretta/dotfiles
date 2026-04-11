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

	# --- IntelliJ New UI Dark Theme ---
	# Syntax highlighting
	set -g fish_color_normal bcbec4
	set -g fish_color_command 56a8f5
	set -g fish_color_keyword cf8e6d
	set -g fish_color_quote 6aab73
	set -g fish_color_redirection 2aacb8
	set -g fish_color_end cf8e6d
	set -g fish_color_error f75464
	set -g fish_color_param bcbec4
	set -g fish_color_comment 6f737a
	set -g fish_color_operator 2aacb8
	set -g fish_color_escape c77dbb
	set -g fish_color_autosuggestion 6f737a
	set -g fish_color_valid_path --underline
	set -g fish_color_selection --background=214283
	set -g fish_color_search_match --background=214283
	set -g fish_color_cancel f75464

	# Pager (tab completion menu)
	set -g fish_pager_color_progress 6f737a
	set -g fish_pager_color_prefix 56a8f5 --bold
	set -g fish_pager_color_completion bcbec4
	set -g fish_pager_color_description 6f737a
	set -g fish_pager_color_selected_background --background=214283

	# Aliases
	alias ts='~/Projects/Sandbox/dotfiles/scripts/start_project.sh'

	function book
		cd ~/Projects/Work/Kognitos/books/book-"$argv[1]"
	end

	function v2
		cd ~/Projects/Work/Kognitos/voyager/"$argv[1]"
	end

	function bdk
		cd ~/Projects/Work/Kognitos/bdk/"$argv[1]"
	end

end

# Function: ks
function ks
    if type -q bass
        # Use bass to source the bash script and import env changes
        bass source /Users/tomiberretta/Projects/Work/Kognitos/bdk/bdk-toolbox/scripts/k8s-context-switch/switch.sh $argv
    else
        bash /Users/tomiberretta/Projects/Work/Kognitos/bdk/bdk-toolbox/scripts/k8s-context-switch/switch.sh $argv
    end
end

function bdk-runtime
    argparse 'mode=?' 'transport=?' 'ngrok=?' 'grpc=?' 'http=?' 'otel=?' -- $argv
    or return

    if test (count $argv) -eq 0
        echo "Usage: bdk-run <book_path> [--mode=book] [--transport=ngrok] [--ngrok=TOKEN] [--grpc=40404] [--http=40404] [--otel=true]"
        return 1
    end

    set -l book_path $argv[1]

    cargo build; and \
    BDK_SERVER_MODE=(set -q _flag_mode; and echo $_flag_mode; or echo "book") \
    BDK_TRANSPORT_MODE=(set -q _flag_transport; and echo $_flag_transport; or echo "ngrok") \
    NGROK_AUTHTOKEN=(set -q _flag_ngrok; and echo $_flag_ngrok; or echo $NGROK_AUTHTOKEN) \
    BDK_GRPC_PORT=(set -q _flag_grpc; and echo $_flag_grpc; or echo "40404") \
    BDK_HTTP_PORT=(set -q _flag_http; and echo $_flag_http; or echo "40404") \
    OTEL_SDK_DISABLED=(set -q _flag_otel; and echo $_flag_otel; or echo "true") \
    BDK_RUNTIME_PYTHON_BOOK_PATH="$book_path" \
    ./target/debug/bdk-runtime
end

function fish-reload-all
    set -l file (test (count $argv) -gt 0; and echo $argv[1]; or echo $__fish_config_dir/config.fish)
    set -l count 0
    for pane in (tmux list-panes -a -F '#{pane_id}:#{pane_current_command}')
        set -l id (string split ':' $pane)[1]
        set -l cmd (string split ':' $pane)[2]
        if test "$cmd" = "fish"
            tmux send-keys -t $id "source $file" Enter
            set count (math $count + 1)
        end
    end
    echo "Reloaded in $count pane(s)"
end
