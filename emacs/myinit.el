;(setq inhibit-startup-message t)
(tool-bar-mode -1)

(use-package zenburn-theme
  :ensure t
  :config 
    (load-theme 'zenburn t))

; shift arrow to move around split sindows
(windmove-default-keybindings)

(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(setq org-support-shift-select 'always)

(desktop-save-mode 1) ;; resume
(fset 'yes-or-no-p 'y-or-n-p) ;; y/n instead of yes/no

;;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

(use-package try
  :ensure t)

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

(use-package all-the-icons
   :ensure t)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

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
  :init
  (global-flycheck-mode t))

(use-package magit
:ensure t
:config
(global-set-key (kbd "C-x g") 'magit-status))

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

(use-package saveplace
  :init
  (save-place-mode 1))

(use-package aggressive-indent
:ensure t
:config
(global-aggressive-indent-mode 1)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
)

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

(use-package org-bullets
:ensure t
:init
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-bullets-bullet-list '("◉" "◇" "►" "○" "◎" ))

(add-to-list 'org-modules 'org-habit)
(require 'org-habit)
(setq org-habit-show-all-today t)
(setq org-habit-graph-column 40)
(setq org-habit-preceding-days 60)
(setq org-habit-following-days 7)

(global-set-key "\C-ca" 'org-agenda)

(setq org-agenda-start-on-weekday nil)

;; line
(setq halfbar '================================================)
(setq wholebar '=================================================================================================================)
(setq title-length 20)

;; headers
(defun create-header (title)
  (format "\n\n\n%s\n%s%s%s\n%s\n"
          (symbol-value 'wholebar)
          (symbol-value 'halfbar)
          (center-string title (symbol-value 'title-length))
          (symbol-value 'halfbar)
          (symbol-value 'wholebar)))

(defun create-first-header (title)
  (format "%s\n%s%s%s\n%s\n"
          (symbol-value 'wholebar)
          (symbol-value 'halfbar)
          (center-string title (symbol-value 'title-length))
          (symbol-value 'halfbar)
          (symbol-value 'wholebar)))
;; center string format
;; use-case example:
;; (center-string "KJF" 10) ==> "   KJF    "
(defun center-string (string size)
  (let* ((padding (/ (- size (length string)) 2))
         (lpad (+ (length string) padding))
         (lformat (format "%%%ds" lpad))
         (rformat (format "%%%ds" (- size))))
    (format rformat (format lformat string))))

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
       ((agenda deadline-up  habit-down time-up 
                priority-down timestamp-down category-keep))))

;; use am/pm instead 24h format
(setq org-agenda-timegrid-use-ampm t)

;; my custom view of agenda and todos
(setq org-agenda-custom-commands
      '(("h" "My Hourly Schedule for Today and Tomorrow"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-agenda-overriding-header (create-first-header "TODAY"))))
          (agenda "" ((org-agenda-span 1)
                      (org-agenda-start-day "+1d")
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-agenda-overriding-header (create-header "TOMORROW"))))))
        ("d" "My Daily Schedule for Next Month"
         ((agenda "" ((org-agenda-span 30)
                      (org-agenda-start-on-weekday nil)
                      (org-agenda-show-all-dates t)
                      (org-agenda-time-grid nil)
                      ;; (org-agenda-start-day "+1d")
                      (org-agenda-overriding-header (create-first-header "NEXT MONTH"))))))
        ("t" "My Todo items"
         (alltodo "" ((org-agenda-overriding-header (create-header "OTHER TODO's"))))
         (alltodo "" ((org-agenda-todo-ignore-deadlines nil)
                      (org-agenda-todo-ignore-scheduled nil)
                      (org-agenda-overriding-header (create-header "ALL TODO's")))))))

;; define custom time grid
(setq org-agenda-time-grid
      (quote
       ((daily today remove-match)
        (500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400)
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
         "* TODO %^{PROMPT}
  SCHEDULED: %^t
  %?")

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
         "* TODO %^{PROMPT}
  SCHEDULED: %^T
  %?")

        ("at" "todo" entry (file+headline "~/Dropbox/org/personal.org" "todo")
         "* TODO %^{PROMPT}
  SCHEDULED: %^T
  %?")

        ("ah" "habits" entry (file+headline "~/Dropbox/org/personal.org" "habits")
         "* TODO %^{PROMPT}
  :PROPERTIES:
  :STYLE:    habit
  :END:
  %?")





        ("w" "work related")

        ("wa" "appointments" entry (file+headline "~/Dropbox/org/work.org" "meetings")
         "* TODO %^{PROMPT}
  SCHEDULED: %^t
  %?")

        ("wt" "todo" entry (file+headline "~/Dropbox/org/work.org" "todos")
         "* TODO %^{PROMPT}
  DEADLINE: %^t
  %?")

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

(setq org-agenda-overriding-columns-format org-columns-default-format)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-startup-folded t)
