;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Doğu Us"
      user-mail-address "uspro@disroot.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Iosevka" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 14)
      doom-big-font (font-spec :family "Iosevka" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "fish -c 'string join : $PATH'"
					  ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; General Doom Emacs Settings
(set-exec-path-from-shell-PATH)

(use-package! doom-themes
  :defer t
  :config
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  )

(setq fancy-splash-image (concat doom-private-dir "logo.png"))
(setq doom-fallback-buffer "*doom*")

(set-file-template! "\\.org$" :trigger "__" :mode 'org-mode)
(set-file-template! "/LICEN[CS]E$" :trigger '+file-templates/insert-license)

(add-hook! 'nim-mode-local-vars-hook #'lsp!)
(add-hook! 'nix-mode-local-vars-hook #'lsp!)
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(if (boundp 'mac-mouse-wheel-smooth-scroll)
    (setq  mac-mouse-wheel-smooth-scroll t)
  (if (> emacs-major-version 28)
      (pixel-scroll-precision-mode)
    (use-package! good-scroll
      :config
      (good-scroll-mode 1))))

(add-hook 'emacs-lisp-mode-hook #'parinfer-rust-mode)
(add-hook 'clojure-mode-hook #'parinfer-rust-mode)

(setq vterm-kill-buffer-on-exit t)
(map! :after evil :gnvi "C-f" #'consult-line)
(fset 'yes-or-no-p 'y-or-n-p)


;; Elfeed Settings
(after! elfeed
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update)
  )

;; Telega Settings
(map! :desc "Open Telega" :n "C-c C-t" 'telega)
(setq telega-use-docker t)
(setq telega-use-images t)
(setq telega-server-call-timeout 1000.0)
(after! telega
  (telega-mode-line-mode 1)
  (add-hook 'telega-msg-ignore-predicates 'telega-msg-from-blocked-sender-p)
  (add-load-path! "~/.emacs.d/.local/straight/repos/telega.el/contrib")
  (require 'telega-mnz)
  (require 'telega-url-shorten)
  (setq telega-url-shorten-use-images t)
  (global-telega-mnz-mode 1)
  (global-telega-url-shorten-mode 1)
  )


;; Org Roam Settings
(after! org-roam
  (setq org-roam-directory "~/Notes")
  )

;; Email Settings
(after! mu4e
  (set-email-account! "disroot"
  '((mu4e-sent-folder       . "/disroot/Sent Mail")
    (mu4e-drafts-folder     . "/disroot/Drafts")
    (mu4e-trash-folder      . "/disroot/Trash")
    (mu4e-refile-folder     . "/disroot/All Mail")
    )
  t))

(load! "format-time-string-patch.el")
