;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Doğu Us"
      user-mail-address "uspro@disroot.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 15 :weight 'regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package! doom-themes
  :defer t
  :config
  (doom-themes-neotree-config)
  (doom-themes-org-config))


(setq fancy-splash-image (concat doom-user-dir "logo.png"))
(setq doom-fallback-buffer "*doom*")

(set-file-template! "/LICEN[CS]E$" :trigger '+file-templates/insert-license)

(if (boundp 'mac-mouse-wheel-smooth-scroll)
    (setq  mac-mouse-wheel-smooth-scroll t)
  (if (> emacs-major-version 28)
      (pixel-scroll-precision-mode)
    (use-package! good-scroll
      :config
      (good-scroll-mode 1))))


(setq vterm-kill-buffer-on-exit t)
(fset 'yes-or-no-p 'y-or-n-p)


;; Elfeed Settings
(after! elfeed
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update))

;; Telega Settings
(map! :desc "Open Telega" :n "C-c C-t" 'telega)
(setq telega-use-docker t)
(setq telega-use-images t)
(setq telega-server-call-timeout 1000.0)
(after! telega
  (setq telega-server-verbosity 0)
  (telega-mode-line-mode 1)
  (add-load-path! "~/.config/emacs/.local/straight/repos/telega.el/contrib")
  (require 'telega-mnz)
  (require 'telega-url-shorten)
  (setq telega-url-shorten-use-images t)
  (setq telega-chat-show-deleted-messages-for 'all)
  (global-telega-mnz-mode 1)
  (global-telega-url-shorten-mode 1))

(load! "format-time-string-patch.el")

(global-wakatime-mode)
