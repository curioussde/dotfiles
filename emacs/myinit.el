(use-package exec-path-from-shell
  :ensure exec-path-from-shell
  :config
  (progn
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-initialize))))

(setq inhibit-startup-message t)
(add-hook 'after-init-hook (lambda () (org-agenda nil "c")))
(add-hook 'prog-mode-hook 'global-display-line-numbers-mode)
(tool-bar-mode -1)

(use-package centaur-tabs
  :demand
  :bind (("C-S-<tab>" . centaur-tabs-backward)
         ("C-<tab>" . centaur-tabs-forward)
         ("C-x p" . centaur-tabs-counsel-switch-group))
  :custom
  (centaur-tabs-set-bar 'under)
  (x-underline-at-descent-line t)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker " ● ")
  (centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-height 30)
  (centaur-tabs-set-icons t)
  (centaur-tabs-close-button " x")
  :config
  (centaur-tabs-mode +1)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (when (member "Arial" (font-family-list))
    (centaur-tabs-change-fonts "Arial" 130)))

(global-visual-line-mode 1)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t))

(use-package atom-one-dark-theme
  :ensure t
  :config
  (load-theme 'atom-one-dark t))

; shift arrow to move around split sindows
(windmove-default-keybindings)

(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(setq org-support-shift-select 'always)


(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

(desktop-save-mode 1) ;; resume
(fset 'yes-or-no-p 'y-or-n-p) ;; y/n instead of yes/no
(show-paren-mode 1)
(setq-default
 shell-file-name "/bin/zsh")
(recentf-mode 1)

;;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

(use-package try
  :ensure t)

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (add-to-list 'default-frame-alist
               '(ns-transparent-titlebar . t))

  (add-to-list 'default-frame-alist
               '(ns-appearance . dark))

  (add-to-list 'default-frame-alist
               '(alpha . (98 . 98)))

  (defun stop-minimizing-window ()
    "Stop minimizing window under macOS."
    (interactive)
    (unless (and *is-a-mac*
                 window-system)
      (suspend-frame))))

;; undo/redo
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-Z") 'redo)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (line-number-mode t)
)
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-mc
:ensure t
:init
(global-evil-mc-mode 1))

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode))

(use-package helm
:ensure t
:config
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(defun nm-around-helm-buffers-sort-transformer (candidates source)
  candidates)
(advice-add 'helm-buffers-sort-transformer
            :override #'nm-around-helm-buffers-sort-transformer)
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action) ;; tab to complete, not enters selection
(helm-mode 1))

(use-package which-key
  :ensure t
  :config
    (which-key-mode))

(use-package auto-complete
  :ensure t
  :init
    (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

(setq-default
 company-idle-delay .5)

(use-package all-the-icons
  :ensure t)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; (defvar my/tabbar-height 20)
;; (defvar my/tabbar-left (powerline-wave-right 'tabbar-default nil my/tabbar-height))
;; (defvar my/tabbar-right (powerline-wave-left nil 'tabbar-default my/tabbar-height))
;; (defun my/tabbar-tab-label-function (tab)
;;   (powerline-render (list my/tabbar-left
;;                           (format " %s  " (car tab))
;;                           my/tabbar-right)))
;; (setq tabbar-tab-label-function #'my/tabbar-tab-label-function)

(use-package yasnippet
   :ensure t
   :init
   (yas-global-mode 1))
(use-package yasnippet-snippets
   :ensure t)
(use-package auto-yasnippet
   :ensure t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-inline
  :ensure t
  :init (global-flycheck-inline-mode))

(use-package gradle-mode
  :ensure t)

(use-package grails-mode
  :ensure t)

(use-package groovy-mode
  :ensure t)

;; git wrapper
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package diff-hl
  :ensure t
  :defer 3
  :init
  (global-diff-hl-mode 1)
  (diff-hl-dir-mode 1)
  (diff-hl-margin-mode 1)
  (advice-add 'svn-status-update-modeline :after #'diff-hl-update)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             nil
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         45)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("C-`"       . treemacs-select-window)
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp ;;treemacs-persective if you use perspective.el vs. persp-mode
  :after treemacs persp-mode ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))   

(add-hook 'emacs-startup-hook 'treemacs)

(use-package saveplace
  :ensure t
  :init
  (save-place-mode 1))

(use-package buffer-move
  :ensure t
  :config
  (global-set-key (kbd "<s-S-left>")   'buf-move-left)
  (global-set-key (kbd "<s-S-right>")  'buf-move-right)
  (global-set-key (kbd "<s-S-up>")  'buf-move-up)
  (global-set-key (kbd "<s-S-down>")  'buf-move-down))

(use-package rainbow-delimiters
  :ensure t)
(add-hook 'prog-mode-hook  #'rainbow-delimiters-mode)

(use-package aggressive-indent
:ensure t
:config
(global-aggressive-indent-mode 1)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
)



(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package plantuml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'". plantuml-mode)) ;; Ref https://github.com/skuro/plantuml-mode/blob/ea45a13707abd2a70df183f1aec6447197fc9ccc/README.md#enable-the-major-mode
  :config
  (setq plantuml-default-exec-mode 'executable) ;; Ref https://github.com/skuro/plantuml-mode/blob/ea45a13707abd2a70df183f1aec6447197fc9ccc/README.md#execution-modes and https://github.com/skuro/plantuml-mode/blob/ea45a13707abd2a70df183f1aec6447197fc9ccc/README.md#quick-guide
  )

(use-package dumb-jump
  :bind (("M-g j" . dumb-jump-go)
         ;; No need to bind `dumb-jump-back` - just use `M-,` i.e. `xref-pop-marker-stack`.
         ))

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("\\.tmpl\\'" . json-mode)))

(custom-set-faces
 '(org-document-title ((t (:weight bold :height 2.0)))) 
 '(org-level-1 ((t (:inherit outline-1 :weight semibold :font "Source Code Pro" :height 1.75))))
 '(org-level-2 ((t (:inherit outline-2 :font "Source Code Pro" :height 1.4))))
 '(org-level-3 ((t (:inherit outline-3 :font "Source Code Pro" :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :font "Source Code Pro" :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :font "Source Code Pro" :height 1.1))))
 '(org-level-6 ((t (:inherit outline-5 :font "Source Code Pro" :height 1.1))))
 '(org-level-7 ((t (:inherit outline-5 :font "Source Code Pro" :height 1.1))))
 '(org-level-8 ((t (:inherit outline-5 :font "Source Code Pro" :height 1.1))))
 )

;; KEYWORDS
;; ! = timestamp, @ = note with timestamp
(setq org-todo-keywords '((sequence "TODO(t)"
                                    "STARTED(s)"
                                    "WAITING(w)"
                                    "|"
                                    "DONE(d!)"
                                    "CANCELED(c@)"
                                    "DEFERRED(f@)")))
(setq org-todo-keyword-faces
  '(("TODO" . "red")
("STARTED" . "yellow")
("WAITING" . "lightgreen")
("DONE" . "green")
("CANCELED" . "skyblue")
("DEFERRED" . "skyblue")))

(with-eval-after-load 'org
    (org-babel-do-load-languages 'org-babel-load-languages 
                                 '((ruby . t)
                                   (python . t)
                                   (shell . t)
                                   (js . t)
                                   (org . t)
                                   (C . t)
                                   (sql . t)
                                   (java . t)
                                   (plantuml . t)
                                   )))
(setq org-plantuml-jar-path
      (expand-file-name "~/plantuml.jar"))

(use-package org-bullets
:ensure t
:init
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-bullets-bullet-list '("◉" "◇" "►" "○" "◎" ))

(add-to-list 'org-modules 'org-habit)
(require 'org-habit)
(setq org-habit-show-all-today t)
(setq org-habit-graph-column 50)
(setq org-habit-preceding-days 55)
(setq org-habit-following-days 7)

(global-set-key "\C-ca" 'org-agenda)

(setq org-agenda-start-on-weekday nil)

;; line
(setq title-underline '--------------------)

;; headers
(defun create-header (title)
  (format "\n\n⚡ %s:\n%s"
          (symbol-value 'title)
          (symbol-value 'title-underline)))

(defun create-first-header (title)
  (format "⚡ %s:\n%s"
          (symbol-value 'title)
          (symbol-value 'title-underline)))

;; don't show tasks as scheduled if they are already shown as a deadline
;; (setq org-agenda-skip-scheduled-if-deadline-is-shown t)

;; agenda set which files to look for
(setq org-agenda-files '("~/Dropbox/org/"))

;; open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;; don't show done tasks
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)

;; don't show tasks that are scheduled or have deadlines in the
;; normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))

;; don't show agenda block separators
(setq org-agenda-block-separator nil)

;; sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
      (quote
       ((agenda deadline-up habit-down time-up 
                priority-down timestamp-down category-keep))))

;; use am/pm instead 24h format
(setq org-agenda-timegrid-use-ampm t)

;; my custom view of agenda and todos
(setq org-agenda-custom-commands
      '(("c" "My Custom Summary for Today"
         ((agenda "" ((org-agenda-time-grid nil)
                      (org-agenda-span 1)
                      (org-deadline-warning-days 365)
                      (org-agenda-sorting-strategy '(deadline-down))
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-overriding-header (create-first-header "Upcoming deadlines"))))
          (tags-todo "SCHEDULED<\"<today>\""
                     ((org-agenda-sorting-strategy '(timestamp-down))
                      (org-agenda-overriding-header (create-header "Overdue tasks"))))
          (tags-todo "SCHEDULED>=\"<today>\"&SCHEDULED<\"<tomorrow>\"|DEADLINE<\"<tomorrow>\""
                     ((org-agenda-sorting-strategy '(timestamp-down))
                      (org-agenda-overriding-header (create-header "Today's tasks"))))
          (agenda "" ((org-agenda-span 1)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'deadline))
                      (org-agenda-overriding-header (create-header "Schedule"))))
          (todo "TODO" ((org-agenda-sorting-strategy '(tag-up priority-down))
                      (org-agenda-overriding-header (create-header "todo w/o deadline"))))
          (agenda "" ((org-agenda-span 1)
                      (org-agenda-start-day "+1d")
                      (org-agenda-time-grid nil)
                      (org-agenda-overriding-header (create-header "TOMORROW"))))))
        ("d" "My Daily Schedule for Next Month"
         ((agenda "" ((org-agenda-span 30)
                      (org-agenda-start-on-weekday nil)
                      (org-agenda-show-all-dates t)
                      (org-agenda-time-grid nil)
                      ;; (org-agenda-start-day "+1d")
                      (org-agenda-overriding-header (create-first-header "NEXT MONTH"))))))))

;; define custom time grid
(setq org-agenda-time-grid
      (quote
       ((daily today remove-match)
        (600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400)
        "........" "----------------------------------------------------------------------------------")))

;; ;; setting block times as different colors
;; (defun org-agenda-log-mode-colorize-block ()
;;   "Set different line spacing based on clock time duration."
;;   (save-excursion
;;     (let* ((colors (cl-case (alist-get 'background-mode (frame-parameters))
;; 		     ('light
;; 		      (list "#F6B1C3" "#FFFF9D" "#BEEB9F" "#ADD5F7"))
;; 		     ('dark
;; 		      (list "#aa557f" "DarkGreen" "DarkSlateGray" "DarkSlateBlue"))))
;;            pos
;;            duration)
;;       (nconc colors colors)
;;       (goto-char (point-min))
;;       (while (setq pos (next-single-property-change (point) 'duration))
;;         (goto-char pos)
;;         (when (and (not (equal pos (point-at-eol)))
;;                    (setq duration (org-get-at-bol 'duration)))
;;           ;; larger duration bar height
;;           (let ((line-height (if (< duration 15) 1.0 (+ 0.5 (/ duration 30))))
;;                 (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
;;             (overlay-put ov 'face `(:background ,(car colors) :foreground "black"))
;;             (setq colors (cdr colors))
;;             (overlay-put ov 'line-height line-height)
;;             (overlay-put ov 'line-spacing (1- line-height))))))))
;; 
;; (add-hook 'org-agenda-finalize-hook #'org-agenda-log-mode-colorize-block)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      ;;          '(("a" "Appointment" entry (file  "~/Dropbox/org/gcal.org" )
      ;;             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
      ;;            ("l" "Link" entry (file+headline "~/Dropbox/org/links.org" "Links")
      ;;             "* %? %^L %^g \n%T" :prepend t)
      ;;            ("b" "Blog idea" entry (file+headline "~/Dropbox/org/i.org" "Blog Topics:")
      ;;             "* %?\n%T" :prepend t)
      '(("a" "azu personal")

        ("aa" "appointments" entry (file+headline "~/Dropbox/org/personal.org" "appointments")
         "* TODO %?
  SCHEDULED: %^t")

        ("ab" "buy" entry (file+headline "~/Dropbox/org/personal.org" "buy")
         "* TODO %^{PROMPT}
  DEADLINE: %^T SCHEDULED: %T
  - [ ] can I afford it?
  - [ ] do I need it?
  - [ ] don't have something similar?
  - [ ] can't borrow?
  - [ ] can't buy used?
  - [ ] can't wait?
  - [ ] can't find sale?
  %?")

        ("an" "notes" entry (file+headline "~/Dropbox/org/personal.org" "notes")
         "* %u %^{PROMPT}
  %?" :prepend t)

        ("ar" "reminders" entry (file+headline "~/Dropbox/org/personal.org" "reminders")
         "* TODO %?
  SCHEDULED: %^T")

        ("at" "todo" entry (file+headline "~/Dropbox/org/personal.org" "todo")
         "* TODO %?
  SCHEDULED: %^T")

        ("ah" "habits" entry (file+headline "~/Dropbox/org/personal.org" "habits")
         "* TODO %?
  SCHEDULED: %^T
  :PROPERTIES:
  :STYLE:    habit
  :END:
  ")





        ("w" "work related")

        ("wa" "appointments" entry (file+headline "~/Dropbox/org/work.org" "meetings")
         "* TODO %?
  SCHEDULED: %^t")

        ("wt" "todo" entry (file+headline "~/Dropbox/org/work.org" "todos")
         "* TODO %?
  SCHEDULED: %^t")

        ("wl" "link" entry (file+headline "~/Dropbox/org/work.org" "links")
         "* [[%^{PROMPT}][%?")
        ))
  ;;
  ;;    (defadvice org-capture-finalize 
  ;;        (after delete-capture-frame activate)  
  ;;      "Advise capture-finalize to close the frame"  
  ;;      (if (equal "capture" (frame-parameter nil 'name))  
  ;;          (delete-frame)))
  ;;
  ;;    (defadvice org-capture-destroy 
  ;;        (after delete-capture-frame activate)  
  ;;      "Advise capture-destroy to close the frame"  
  ;;      (if (equal "capture" (frame-parameter nil 'name))  
  ;;          (delete-frame)))  
  ;;
  ;;    (use-package noflet
  ;;      :ensure t )
  ;;    (defun make-capture-frame ()
  ;;      "Create a new frame and run org-capture."
  ;;      (interactive)
  ;;      (make-frame '((name . "capture")))
  ;;      (select-frame-by-name "capture")
  ;;      (delete-other-windows)
  ;;      (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
  ;;        (org-capture)))
  ;;;; (require 'ox-beamer)
  ;;;; for inserting inactive dates
  ;;    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))
  ;;
  ;;    (use-package htmlize :ensure t)
  ;;
  ;;    (setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))

(setq org-agenda-overriding-columns-format org-columns-default-format)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-startup-folded t)
