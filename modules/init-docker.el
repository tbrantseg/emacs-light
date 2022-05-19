(use-package docker
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package docker-compose-mode)
(add-hook 'yaml-mode-hook 'nlinum-mode)
(add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
