;; defualt line-spacing
;; (setq-default line-spacing 1.3)

;; show line numbers
(setq display-line-numbers-mode t) 

;; wrapping line enabled
(setq word-wrap 1)
(global-visual-line-mode t)
;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

;; switch back to normal state mode x seconds
(defvar normal-mode-when-idle
  (run-with-idle-timer 10 t (lambda ()
                              (message "10 seconds idle. swithcing back to normal mode")
                              (evil-normal-state))))

(load-library "~/dotfiles/emacs/org-main.el")
(load-library "~/dotfiles/emacs/org-agenda.el")
(load-library "~/dotfiles/emacs/ranger.el")
(load-library "~/dotfiles/emacs/treemacs.el")
