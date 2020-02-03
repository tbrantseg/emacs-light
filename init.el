;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

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

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-eighties t))

(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'powerline)
  :config
  (sml/setup))

(unless window-system
  (menu-bar-mode -1))
(tool-bar-mode -1)
(scroll-bar-mode -1)
(visual-line-mode 1)

(use-package nlinum
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'nlinum-mode)
  (unless window-system (setq nlinum-format "%d "))
  :bind
  (("<M-f10>" . nlinum-mode)
   ("<M-RET>" . comment-indent-new-line)))

;; Helm
(use-package helm
  :ensure t
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
  :ensure t
  :defer t
  :bind
  (("C-x g" . magit-status)))

;; Company
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'company-mode)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 0)
  :config
  (global-company-mode))

;; YASnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (yas-load-directory (expand-file-name (concat user-emacs-directory "snippets"))))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; Smartparens
(use-package smartparens
  :ensure t
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
  :ensure t
  :defer 10
  :config
  (setq which-key-popup-type 'side-window)
  (setq which-key-compute-remaps t)
  (which-key-mode 1))

;; Hydra
(use-package hydra
  :ensure t
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

;; Org-ipython
(use-package conda
  :ensure t
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode))

(use-package jupyter
  :ensure t
  :init
  (setq org-confirm-babel-evaluate nil)
  (add-to-list 'org-babel-after-execute-hook 'org-redisplay-inline-images)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (jupyter . t))))
