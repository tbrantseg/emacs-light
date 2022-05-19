;; Helm
(use-package helm
  :diminish
  :init
;; (setq straight-recipe-overrides nil)
;; (straight-override-recipe '(helm :files ("*.el" "emacs-helm.sh" (:exclude "helm-core.el" "helm-lib.el" "helm-source.el" "helm-multi-match.el"))))
;; (straight-override-recipe '(helm-core :files ("helm-core.el" "helm-lib.el" "helm-source.el" "helm-multi-match.el")))

  (global-unset-key (kbd "C-x c"))
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (setq helm-split-window-inside-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-ff-search-library-in-sexp t)
  (setq helm-scroll-amount 8)
  (setq helm-ff-file-name-history-use-recentf t)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-ff-skip-boring-files t)
  (add-to-list 'helm-boring-file-regexp-list "#.+#")

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

(use-package helm-rg)

;; helm.el
