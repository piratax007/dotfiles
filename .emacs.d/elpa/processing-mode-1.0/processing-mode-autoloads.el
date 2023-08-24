;;; processing-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "processing-mode" "processing-mode.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from processing-mode.el

(autoload 'processing-find-sketch "processing-mode" "\
Find a processing sketch with NAME in `processing-sketch-dir'.
If ARG is non nil or `processing-sketch-dir' is nil create new
sketch in current directory.

\(fn NAME &optional ARG)" t nil)

(autoload 'processing-mode "processing-mode" "\
Major mode for Processing.
\\{java-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))

(autoload 'processing-snippets-initialize "processing-mode" nil nil nil)

(eval-after-load 'yasnippet '(processing-snippets-initialize))

(register-definition-prefixes "processing-mode" '("processing-"))

;;;***

;;;### (autoloads nil nil ("processing-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; processing-mode-autoloads.el ends here
