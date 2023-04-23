;;; js-auto-format-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "js-auto-format-mode" "js-auto-format-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from js-auto-format-mode.el

(autoload 'js-auto-format-enabled-p "js-auto-format-mode" "\
Test whether js-auto-format-mode is enabled." nil nil)

(autoload 'js-auto-format-execute "js-auto-format-mode" "\
Format JavaScript source code." t nil)

(autoload 'js-auto-format-mode "js-auto-format-mode" "\
Minor mode for auto-formatting JavaScript code

This is a minor mode.  If called interactively, toggle the
`Js-Auto-Format mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `js-auto-format-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "js-auto-format-mode" '("js-auto-format-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; js-auto-format-mode-autoloads.el ends here
