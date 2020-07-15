;; org todo keywords
;; ! = timestamp, @ = note with timestamp
(setq org-todo-keywords '((sequence "TODO(t)"
                                    "STARTED(s)"
                                    "WAITING(w)"
                                    "|"
                                    "DONE(d!)"
                                    "CANCELED(c@)"
                                    "DEFERRED(f@)")))


;; my custom org bullets
(setq-default org-bullets-bullet-list '("◉" "○" "■" "◆" "▲" "▶"))
