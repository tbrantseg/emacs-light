;; Exporters
(use-package org
  :straight org-plus-contrib
  :config
  (setq org-src-preserve-indentation nil
	org-edit-src-content-indentation 0)
  ;; Miscellaneous org mode stuff
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (org . t)
     (dot . t)
     (python . t)
     (jupyter . t)))
  (put 'upcase-region 'disabled nil)

  ;; Org mode extra
  (setq org-agenda-files '("~/docs/todo"))
  (setq org-agenda-custom-commands
	'(("c" "Simple agenda view"
	   ((agenda "")
	    (alltodo "")))))
  ;; Miscellaneous org mode stuff
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (org . t)
     (dot . t)
     (python . t)
     (jupyter . t)))
  (put 'upcase-region 'disabled nil)

  ;; Org mode extra
  (setq org-agenda-files '("~/docs/todo"))
  (setq org-agenda-custom-commands
	'(("c" "Simple agenda view"
	   ((agenda "")
	    (alltodo "")))))
  :bind
  ("C-c a" . org-agenda)
  ("C-c l" . org-store-link))

(require 'ox-md)
(require 'ox-confluence)

(use-package graphviz-dot-mode
  :diminish
  :config
  (require 'company-graphviz-dot)
  (setq graphviz-dot-indent-width 4))

(if (executable-find "sqlite3")
    (use-package org-roam
      :diminish
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "/home/tom/org-roam")
      :bind (:map org-roam-mode-map
		  (("C-c n l" . org-roam)
		   ("C-c n f" . org-roam-find-file)
		   ("C-c n g" . org-roam-graph-show))
		  :map org-mode-map
		  (("C-c n i" . org-roam-insert))
		  (("C-c n I" . org-roam-insert-immediate))))
  (message "Could not find sqlite3! Org-roam not loaded."))

(use-package org-jira
  :init
  (unless (file-directory-p "~/.org-jira")
    (make-directory "~/.org-jira"))
  :config
  (setq jiralib-url "https://jira.cms.gov")
  (setq org-jira-default-jql "assignee = currentUser() AND status in ('Open', 'In Progress', 'Resolved', 'Verified') ORDER BY priority DESC, created ASC")
  (setq org-jira-jira-status-to-org-keyword-alist
	'(("Open" . "TODO")
	  ("In Progress" . "IN-PROGRESS")
	  ("Resolved" . "REVIEW")
	  ("Verified" . "TESTING")
	  ("Closed" . "DONE")))
  :bind
  ("C-c jg" . org-jira-get-projects))

;; Confluence
(use-package confluence
  :config
  (setq confluence-url "https://confluence.cms.gov"))

;; org.el
