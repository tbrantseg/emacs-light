;; Look and Feel

;; Theme and Font
(set-face-attribute 'default nil	
	    :family "Inconsolata"
		    :height 110
		    :weight 'normal)

(unless (or (window-system) (daemonp))
  (menu-bar-mode -1))
(display-time)
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(visual-line-mode 1)

(use-package diminish)

(use-package gruvbox-theme
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (select-frame frame)
		  (load-theme 'gruvbox-dark-medium t)))
    (load-theme 'gruvbox-dark-hard t)))

(use-package powerline
  :config
  (powerline-default-theme))

(use-package airline-themes
  :config
  (load-theme 'airline-base16_gruvbox_dark_hard t))

(use-package nlinum
  :init
  (add-hook 'prog-mode-hook 'nlinum-mode)
  (setq nlinum-format " %d ")
  :bind
  (("<M-f10>" . nlinum-mode)
   ("<M-RET>" . comment-indent-new-line)))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))
;  :init
;  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Smartparens
(use-package smartparens
  :diminish
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

(use-package which-key
  :defer 10
  :diminish
  :config
  (setq which-key-popup-type 'side-window)
  (setq which-key-compute-remaps t)
  (which-key-mode 1))

(fset 'yes-or-no-p 'y-or-n-p)

;; appearance.el ends here
