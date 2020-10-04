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

;; hydra.el ends here
