(require 'package)
(add-to-list 'package-archives 
    '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("9abe2b502db3ed511fea7ab84b62096ba15a3a71cdb106fd989afa179ff8ab8d" default))
 '(fill-column 120)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(latex-extra cdlatex processing-mode yaml-mode smart-tabs-mode markdown-preview-mode js-auto-format-mode dockerfile-mode multi-line move-text go-mode python-mode monokai-theme markdown-mode))
 '(tab-width 4)
 '(warning-suppress-types '((comp) (comp) (comp))))
(smart-tabs-insinuate 'python 'javascript 'ruby)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq-default indent-tabs-mode nil)
(add-hook 'c-mode-common-hook
              (lambda () (setq indent-tabs-mode t)))
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
