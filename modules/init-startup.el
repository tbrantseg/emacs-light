;; Startup

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

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

;; startup.el ends here
