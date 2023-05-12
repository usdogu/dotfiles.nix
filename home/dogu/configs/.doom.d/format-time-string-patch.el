;;; format-time-string-patch.el --- Force English format-time-string day names -*- lexical-binding: t; -*-
;;; Commentary:
;;; Stolen from https://gitlab.com/kisaragi-hiu/.emacs.d/blob/971d47f0133b452aaf4c5d08e463430a9c0ffc47/.emacs.d/kisaragi/format-time-string-patch.el
;;; Make it so that (format-time-string "%a") is always in English,
;;; regardless of $LANG or other locale settings.
;;; I'm fed up with org-todo having to be run twice because of this.
;;; Code:

(require 'calendar)

(defun kisaragi/english-dow (&optional time zone abbreviated)
  "Return ABBREVIATED name of the day of week at TIME and ZONE.

If TIME or ZONE is nil, use `current-time' or `current-time-zone'."
  (unless time (setq time (current-time)))
  (unless zone (setq zone (current-time-zone)))
  (calendar-day-name
   (pcase-let ((`(,_ ,_ ,_ ,d ,m ,y . ,_)
                (decode-time time zone)))
     (list m d y))
   abbreviated))

(defun kisaragi/advice-format-time-string (func format &optional time zone)
  "Pass FORMAT, TIME, and ZONE to FUNC.

Replace \"%A\" in FORMAT with English day of week of today,
\"%a\" with the abbreviated version."
  (let* ((format (replace-regexp-in-string "%a" (kisaragi/english-dow time zone t)
                                           format))
         (format (replace-regexp-in-string "%A" (kisaragi/english-dow time zone nil)
                                           format)))
    (funcall func format time zone)))

(advice-add 'format-time-string :around #'kisaragi/advice-format-time-string)

(provide 'format-time-string-patch)
;;; format-time-string-patch.el ends here
