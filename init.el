;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Startup
(setq inhibit-startup-screen t)
(setq initial-scratch-message
      (concat
       (concat ";; GNU Emacs " emacs-version "\n")
       (concat ";; Build system: " system-configuration "\n")
       (concat ";; Build date and time " (format-time-string "%Y-%m-%d %T" emacs-build-time) "\n\n")))

(setq user-full-name "Thomas Brantseg")
(setq user-email-address "tom.brantseg@gmail.com")

(let ((backup-dir "~/.emacs.d/backups")
      (auto-saves-dir "~/.emacs.d/auto-saves"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
	auto-save-file-name-transforms `((".*",auto-saves-dir t))
	auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
	tramp-backup-directory-alist `((".*" . ,backup-dir))
	tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t)
(setq delete-old-versions t)
(setq version-control t)
(setq kept-new-versions 5)
(setq kept-old-versions 2)

(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Look and Feel
(set-face-attribute 'default nil	
	    :family "Inconsolata"
		    :height 110
		    :weight 'normal)

(use-package gruvbox-theme
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (select-frame frame)
		  (load-theme 'gruvbox-dark-medium t)))
    (load-theme 'gruvbox-dark-medium t)))

(use-package powerline
  :config
  (powerline-center-theme))

(use-package airline-themes
  :config
  (load-theme 'airline-base16_chalk t))

(unless window-system
  (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(visual-line-mode 1)

(use-package nlinum
  :init
  (add-hook 'prog-mode-hook 'nlinum-mode)
  (unless window-system (setq nlinum-format "%d "))
  :bind
  (("<M-f10>" . nlinum-mode)
   ("<M-RET>" . comment-indent-new-line)))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Helm
(use-package helm
  :init
  (global-unset-key (kbd "C-x c"))
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-ff-search-library-in-sexp t)
  (setq helm-scroll-amount 8)
  (setq helm-ff-file-name-history-use-recentf t)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)

  :config
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (helm-mode 1)
  (helm-autoresize-mode t)

  :bind
  (("C-c h" . helm-command-prefix)
   ("M-x" . helm-M-x)
   ("C-x b" . helm-mini)
   ("C-x C-f" . helm-find-files)
   ("M-y" . helm-show-kill-ring)
   :map helm-map
   ("<tab>" . helm-execute-persistent-action)
   ("C-i" . helm-execute-persistent-action)
   ("C-z" . helm-select-action)))

;; Magit
(use-package magit
  :defer t
  :bind
  (("C-x g" . magit-status)))

(use-package forge
  :after magit
  :config
  (push '("github.cms.gov" "github.cms.gov/api/v3" "github.cms.gov" forge-github-repository) forge-alist))

;; Company
(use-package company
  :init
  (add-hook 'after-init-hook 'company-mode)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 0)
  :config
  (global-company-mode))

;; YASnippet
(use-package yasnippet
  :config
  (yas-global-mode 1)
  (yas-load-directory (expand-file-name (concat user-emacs-directory "snippets"))))

(use-package yasnippet-snippets
  :after yasnippet)

;; Smartparens
(use-package smartparens
  :config
  (sp-with-modes '(c-mode c++-mode)
		 (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
		 (sp-local-pair "/*" "/*" :post-handlers '((" | " "SPC")
							   ("* ||\n[i]" "RET"))))
  (show-smartparens-global-mode +1)
  (smartparens-global-mode 1)

  :bind
  (:map smartparens-mode-map
	("M-<up>" . sp-forward-sexp)
	("M-<down>" . sp-backward-sexp)))

;; Which-key
(use-package which-key
  :defer 10
  :config
  (setq which-key-popup-type 'side-window)
  (setq which-key-compute-remaps t)
  (which-key-mode 1))

;; Hydra
(use-package hydra
  :config
  (defhydra tb-system-hydra (:color blue :hint nil)
    "
  File system commands:
  ---------------
  _s_: Open eshell
  _t_: Open plain terminal
  _d_: Open dired in current directory
  _p_: Find file in project
  _g_: grep in project
  "
    ("s" eshell)
    ("t" ansi-term)
    ("d" dired)
    ("p" projectile-find-file)
    ("g" projectile-grep))

  (defhydra tb-info-hydra (:color blue :hint nil)
    "
  Emacs environment (describe):
  ----------------------------
  _k_: Describe key binding
  _v_: Describe variable
  _f_: Describe function
  _m_: Describe current mode
  "
    ("k" describe-key)
    ("v" describe-variable)
    ("f" describe-function)
    ("m" describe-mode))

  (defhydra hydra-outline (:color pink :hint nil)
    "
  ^Hide^             ^Show^           ^Move
  ^^^^^^------------------------------------------------------
  _q_: sublevels     _a_: all         _u_: up
  _t_: body          _e_: entry       _n_: next visible
  _o_: other         _i_: children    _p_: previous visible
  _c_: entry         _k_: branches    _f_: forward same level
  _l_: leaves        _s_: subtree     _b_: backward same level
  _d_: subtree

  "
    ;; Hide
    ("q" outline-hide-sublevels)    ; Hide everything but the top-level headings
    ("t" outline-hide-body)         ; Hide everything but headings (all body lines)
    ("o" outline-hide-other)        ; Hide other branches
    ("c" outline-hide-entry)        ; Hide this entry's body
    ("l" outline-hide-leaves)       ; Hide body lines in this entry and sub-entries
    ("d" outline-hide-subtree)      ; Hide everything in this entry and sub-entries
    ;; Show
    ("a" outline-show-all)          ; Show (expand) everything
    ("e" outline-show-entry)        ; Show this heading's body
    ("i" outline-show-children)     ; Show this heading's immediate child sub-headings
    ("k" outline-show-branches)     ; Show all sub-headings under this heading
    ("s" outline-show-subtree)      ; Show (expand) everything in this heading & below
    ;; Move
    ("u" outline-up-heading)                ; Up
    ("n" outline-next-visible-heading)      ; Next
    ("p" outline-previous-visible-heading)  ; Previous
    ("f" outline-forward-same-level)        ; Forward - same level
    ("b" outline-backward-same-level)       ; Backward - same level
    ("z" nil "leave"))

  :bind
  (("C-c s" . tb-system-hydra/body)
   ("C-c e" . tb-info-hydra/body)
   ("C-c o" . hydra-outline/body)))

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

(setq org-confirm-babel-evaluate nil)

;; Org-ipython
(use-package conda
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (setq conda-anaconda-home "/home/tom/soft/anaconda3"))

(use-package anaconda-mode
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
(use-package company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; (use-package lsp-mode
;;   :hook
;;   (add-hook 'python-mode-hook lsp-deferred))

;; (use-package company-lsp
;;   :after lsp-mode
;;   :config
;;   (push 'company-lsp company-backends))

;; (use-package lsp-python-ms
;;   :after lsp-mode
;;   :init ((setq lsp-python-ms-auto-install-server t)
;; 	 (setq lsp-completion-provider :capf))
;;   :hook
;;   (python . (lambda () (require 'lsp-python-ms) (lsp))))

;; Other config
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(p)" "BLOCKED(b)" "|" "DONE(d)" "DELETED(x)")))
(setq org-todo-keyword-faces
      '(("TODO(t)" . org-warning)
	("IN-PROGRESS(p)" . "yellow")
	("BLOCKED(b)" . "orange")
	("DONE(d)" . "green")
	("DELETED(x)" . "gray")))
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(use-package org-roam
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

(use-package chronos)
(use-package helm-chronos
  :after chronos
  :bind (("C-c t" . helm-chronos-add-timer)))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Json mode
(use-package json-mode)
