;; Magit
(use-package magit
  :defer t
  :bind
  (("C-x g" . magit-status)))

(use-package forge
  :after magit
  :config
  (push '("github.cms.gov" "github.cms.gov/api/v3" "github.cms.gov" "api.github.com" forge-github-repository) forge-alist))

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
  :init
  (add-hook 'after-init-hook 'company-mode)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 0)
  :config
  (global-company-mode))

;; YASnippet
(use-package yasnippet
  :diminish
  :config
  (yas-global-mode 1)
  (yas-load-directory (expand-file-name (concat user-emacs-directory "snippets"))))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package projectile
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
    (funcall f proc (xterm-color-filter-string)))
  (advice-add 'compilation-filter :around #'my/advice-compilation-filter))

;; ide.el ends here
