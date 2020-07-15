# EMACS

## Initial Setup
1. download emacs
1. cleanup: `rm -rf ~/.emacs* && rm ~/.spacemacs`
1. install spacemacs: `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
1. open emacs, select vim style, standard distribution, heavy with full features
1. quit by `<SPC> q q`
1. update to development branch to get latest release: `cd ~/.emacs.d && git checkout develop && git pull` then reopen emacs
1. go to dotfile: `<SPC> f e d`
1. you might want to get `Source Code Pro` font
1. finetune layers and variables:
	1. then enable layers:
		* auto-completion
		* git
		* markdown
		* org
		* ranger
	1. add zsh to shell: `shell-default-term-shell "/bin/zsh"`
	1. default font size : `15`
	1. dotspacemacs-auto-resume-layouts : `nil` : (quitting on ranger will recursively open all folders)
	1. dotspacemacs-line-numbers : `t`
	1. dotspacemacs-whitespace-cleanup : `t`
	1. restart emacs to get auto-completion before editing more
	1. add `(load-library "~/dotfiles/emacs/main.el")` to function: `dotspacemacs/user-config` in `.spacemacs` file, then `<SPC> q r` to restart
	1. <SPC> <SPC> package-install RET yasnippet-snippets : to install pre-defined snippets


## Useful Shortcuts

### emacs
- insert snippet: `<SPC> i s`
- major mode commands: `,` instead of `<SPC> m`
- new buffer: `<SPC> b N n`
- make tables of the list: `C-c C-x C-c`
- buffer related: `<SPC> b`
- view buffer `<SPC> b b`, mark `C-<SPC>` then delete selected `C-c d`

### org
- select around object: `v a e`
- select around subtree: `v a r`
- after visual selection, fix indentation: `=`
- indent entire subtree: `= a r`
- narrow on subtree: `, s n`
- sort time in selection: `, s S`
- search : `, s s`

### vim
- text related formatting options: `<SPC> x`
- replace text in selection: `:s/FIND/REPLACE`

### snippets
highlight piece of code that will be used as snippet, then run `<SPC> <SPC> helm-yas-create-snippet-on-region`.
