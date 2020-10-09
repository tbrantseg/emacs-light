;; Update todo state when sub-tasks done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all sub-entries are done and to TODO otherwise"
  (let (org-log-done org-log-states)
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(defun my/org-checkbox-todo ()
  "Switch header TODO state to DONE when all checkboxes are ticked, to TODO otherwise"
  (let ((todo-state (org-get-todo-state)) beg end)
    (unless (not todo-state)
      (save-excursion
	(org-back-to-heading t)
	(setq beg (point))
	(end-of-line)
	(setq end (point))
	(goto-char beg)
	(if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
			       end t)
	    (if (match-end 1)
		(if (equal (match-string 1) "100%")
		    (unless (string-equal todo-state "DONE")
		      (org-todo 'done))
		  (unless (string-equal todo-state "TODO")
		    (org-todo 'todo)))
	      (if (and (> (match-end 2) (match-beginning 2))
		       (equal (match-string 2) (match-string 3)))
		  (unless (string-equal todo-state "DONE")
		    (org-todo 'done))
		(unless (string-equal todo-state "TODO")
		  (org-todo 'todo)))))))))
(add-hook 'org-checkbox-statistics-hook 'my/org-checkbox-todo)
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-confirm-babel-evaluate nil)
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(p)" "REVIEW(r)" "TESTING(g)" "|" "DONE(d)" "DELETED(x)")))
(setq org-todo-keyword-faces
      '(("TODO(t)" . org-warning)
	("IN-PROGRESS(p)" . "green")
	("REVIEW(r)" . "blue")
	("TESTING(g)" . "yellow")
	("BLOCKED(b)" . "orange")
	("DONE(d)" . "green")
	("DELETED(x)" . "gray")))
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

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
;; Miscellaneous org mode stuff
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (org . t)))
(put 'upcase-region 'disabled nil)

;; Org mode extra
(setq org-agenda-files '("~/docs/todo"))
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
	 ((agenda "")
	  (alltodo "")))))
(bind-key "C-c a" 'org-agenda)

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

;; org.el
