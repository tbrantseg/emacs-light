;; Magit
(use-package magit
  :defer t
  :config
  (push '("~/repos" . 1) magit-repository-directories)
  :bind
  (("C-x g" . magit)))

(use-package forge
  :after magit
  :config
  (push '("github.cms.gov" "github.cms.gov/api/v3" "github.cms.gov" forge-github-repository) forge-alist))

(use-package github-review
  :after magit
  :config
  (setq github-review-host "github.cms.gov/api/v3"))

(use-package git-modes
  :after magit)

(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Windows clipboard
(defun wsl-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe")
  (message "Copied to Windows clipboard"))
(defun wsl-paste ()
  (interactive)
  (insert (s-replace "" "" (shell-command-to-string "powershell.exe -command 'Get-Clipboard -Raw'"))))
(bind-key "C-c c" 'wsl-copy)
(bind-key "C-c v" 'wsl-paste)

;; Company
(use-package company
  :diminish
  :init
  (add-hook 'after-init-hook 'company-mode)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 0)
  :config
  (global-company-mode))

(diminish 'eldoc-mode)

(use-package highlight-indent-guides
  :diminish
  :config
  (setq highlight-indent-guides-responsive "stack")
  (setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)
  (setq highlight-indent-guides-method 'bitmap))

(use-package fold-dwim
  :bind ("<f7>" . fold-dwim-toggle))

;; YASnippet
(use-package yasnippet
  :diminish
  :config
  (yas-global-mode 1)
  (yas-load-directory (expand-file-name (concat user-emacs-directory "snippets"))))

(diminish 'yas-minor-mode)

(use-package yasnippet-snippets
  :after yasnippet)

(use-package projectile
  :diminish
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (use-package helm-projectile)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (projectile-mode +1))

;; Integrated terminal
(use-package xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun my/advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'my/advice-compilation-filter))

;; LSP stuff
(use-package lsp-mode
  :hook
  (python-mode . lsp)
  (json-mode . lsp)
  (yaml-mode . lsp)
  (scala-mode . lsp)
  (lsp-mode . lsp-lens-mode)
  :init
  (setq lsp-completion-provider :capf)
  (setq lsp-keymap-prefix "C-c k")
  (setq lsp-sqls-server "/home/tom/go/bin/sqls")
  (setq lsp-sqls-workspace-config-path nil)
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-symbol nil)
  (setq lsp-ui-peek-enable t)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  :hook (lsp-mode . lsp-ui-mode))

(use-package treemacs
  :defer t
  :init
  (bind-key "C-c t" 'treemacs))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package lsp-treemacs
  :after (treemacs lsp)
  :config
  (lsp-treemacs-sync-mode))

;; Polymode
(use-package polymode)

;; ide.el ends here
