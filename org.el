

;; key bind
(global-set-key "\C-cl" 'org-store-link) ;save link
(global-set-key "\C-ca" 'org-agenda)     ;open agenda
(global-set-key "\C-cc" 'org-capture)    ;capture options

;; auto load
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)))

(setq-default org-startup-indented t
              org-pretty-entities t ;; maybe not?
              org-use-sub-superscripts "{}"
              org-hide-emphasis-markers t
              org-startup-with-inline-images t
              org-image-actual-width '(300))

(setq org-agenda-window-setup 'current-window)

;; lastmod hook
(setq time-stamp-active t
      time-stamp-start "#\\+lastmod:[ \t]*"
      time-stamp-end "$"
      time-stamp-format "[%04Y-%02m-%02d]")
(add-hook 'before-save-hook 'time-stamp nil)

(require 'org-id)
(setq org-id-link-to-org-use-id 't)

(setq org-refile-targets
      '(("~/org/done.org" :maxlevel . 3)))
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-agenda-files '("~/krig/kontrl/org/agenda.org"
                         "~/krig/kontrl/kore/kanban.org"
						 ))
(setq org-capture-templates '(("a" "Agenda" entry (file+headline "~/krig/kontrl/org/agenda.org" "Tickler") "* TODO %i%? %t \n ")
                              ("j" "Journal" entry (file+datetree "~/krig/kontrl/org/agenda.org") "* %?\n")
                              ("s" "Shortcuts" entry (file+datetree "~/krig/kontrl/org/shortcuts.org") "* %?\n")
                              ("k" "Kanban" entry (file+headline "~/krig/kontrl/org/kanban.org" "Kanban") "** TODO %?\n\n %i")
                              ("K" "Kanban + Link" entry (file+headline "~/krig/kontrl/org/kanban.org" "Kanban") "** TODO %?\n %i \n %a \n")
                              ("n" "Note" entry (file+headline "~/krig/kontrl/org/agenda.org" "Notes") "** TODO %i%? :note: \n %a \n")
                              ("t" "Kontrl's Kanban" entry (file+headline "~/krig/kontrl/kore/kanban.org" "Kanban") "** TODO %? :kontrl:@bacarin:\n\n %i")
                              ("T" "Kontrl's Kanban Link" entry (file+headline "~/krig/kontrl/kore/kanban.org" "Kanban") "** %?[%] :kontrl:@bacarin:\n\n %i \n %a \n")
                              ("m" "Kontrl's Kanban Multitasks" entry (file+headline "~/krig/kontrl/kore/kanban.org" "Kanban") "** %?[%] :kontrl:@bacarin:\n\n %i")
                              ("M" "Kontrl's Kanban Multitasks Link" entry (file+headline "~/krig/kontrl/kore/kanban.org" "Kanban") "** TODO %? :kontrl:@bacarin:\n\n %i \n %a \n")
))

(setq org-todo-keywords '((sequence "TODO(t)" "WIP(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-tag-alist
      '(
        ("home" . ?H)
        ("kontrl" . ?K)
        ("youbr" . ?U)
        ("meet" . ?M)
        ("call" . ?C)
        ;; work stuff
        ("sys" . ?s)
        ("planning" . ?p)
        ("realm" . ?r)
        ("workbench" . ?w)
        ("irc" . ?i)
        ("changelog" . ?c)
        ("flow" . ?f)
        ))

(setq org-agenda-custom-commands
      '(
        ("d" "Dashboard"
         ((agenda "" ((org-agenda-span 7)))
          (tags-todo "@bacarin")
          (tags-todo "kontrl")
          (todo "TODO" ((org-show-context-detail 'minimal)))
          )
         nil)
        ))
