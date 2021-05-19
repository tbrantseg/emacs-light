(use-package org
  :init
  (add-hook 'org-mode-hook #'visual-line-mode)
  :config
  (setq org-src-preserve-indentation nil)
  (setq org-edit-src-content-indentation 0)
  (setq org-ditaa-jar-path (concat user-emacs-directory "straight/repos/org/contrib/scripts/ditaa.jar"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (org . t)
     (dot . t)
     (ditaa . t)
     (python . t)
     (jupyter . t)))
  (put 'upcase-region 'disabled nil)
  (setq org-confirm-babel-evaluate nil)
  (setq org-agenda-files '("~/org-roam/"))
  (setq org-columns-default-format-for-agenda "%ITEM %TODO %TAGS(TICKET)")
  (setq org-agenda-custom-commands
	'(("c" "Simple agenda view")
	  ((agenda "")
	   (alltodo ""))))
  :bind
  ("C-c a" . org-agenda)
  ("C-c l" . org-store-link))

(use-package org-contrib)
(require 'ox-confluence)

(use-package org-agenda-property)
(use-package ob-async)

(use-package pdf-tools
   :pin manual
   :config
   (pdf-tools-install)
   (setq-default pdf-view-display-size 'fit-width)
   (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
   :custom
   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))


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
