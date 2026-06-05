(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      indent-tabs-mode nil
      tab-width 4
      fill-column 120)

(mapc (lambda (mode) (funcall mode -1))
      '(menu-bar-mode tool-bar-mode scroll-bar-mode))

(mapc (lambda (mode) (funcall mode 1))
      '(global-display-line-numbers-mode
        column-number-mode
        electric-pair-mode
        global-auto-revert-mode))

(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

(defun enable-tab-indentation ()
  (setq indent-tabs-mode t))
(add-hook 'c-mode-common-hook #'enable-tab-indentation)

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-nord-aurora t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package nerd-icons
  :ensure t
  :demand t
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))

(defun retrieve-dashboard-buffer ()
  (get-buffer-create "*dashboard*"))

(use-package dashboard
  :init
  (setq initial-buffer-choice #'retrieve-dashboard-buffer
        inhibit-startup-screen t)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5) (projects . 5) (agenda . 5))
        dashboard-filter-agenda-entry 'dashboard-no-filter-agenda
        dashboard-match-agenda-entry "/!"
        dashboard-navigation-cycle t
        dashboard-item-shortcuts '((recents . "r") (projects . "p") (agenda . "a"))
        dashboard-display-icons-p t
        dashboard-icon-type 'nerd-icons
        dashboard-set-file-icons t))

(use-package treemacs
  :ensure t
  :after nerd-icons
  :custom
  (treemacs-width 50)
  :config
  (treemacs-follow-mode 1)
  (treemacs-filewatch-mode 1)
  (treemacs-git-mode 'simple))

(use-package treemacs-nerd-icons
  :ensure t
  :after (treemacs nerd-icons)
  :demand t
  :config
  (treemacs-load-theme "nerd-icons"))

(defun initialize-treemacs-environment ()
  (treemacs))

(add-hook 'emacs-startup-hook #'initialize-treemacs-environment)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind
  (("C-x C-j" . dired-jump))
  :hook
  (dired-mode . dired-hide-details-mode)
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-dwin-target t)
  (delete-by-moving-to-trash t))

(use-package dired-x
  :ensure nil
  :after dired)

(use-package nerd-icons-dired
  :ensure t
  :after (dired nerd-icons)
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package company
  :hook (after-init . global-company-mode))

(use-package multiple-cursors
  :demand t
  :bind*
  (("C-c m l" . mc/edit-lines)
   ("C-c m n" . mc/mark-next-like-this)
   ("C-c m p" . mc/mark-previous-like-this)
   ("C-c m a" . mc/mark-all-like-this)
   ("C-c m d" . mc/mark-all-like-this-dwin)
   ("C-c m r" . mc/mark-all-in-region)
   ("C-c m s" . mc/mark-next-like-this-symbol)
   ("C-c m u" . mc/umark-next-like-this)
   ("C-c m k" . mc/skip-to-next-like-this)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)))

(use-package smart-tabs-mode
  :config
  (smart-tabs-insinuate 'python 'javascript 'ruby))

(use-package eglot
  :commands (eglot eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  :config
  (add-to-list 'eglot-server-programs
	       '(python-mode . ("pylsp")))
  (add-to-list 'eglot-server-programs
	       '(c-mode . ("clangd"
			   "--background-index"
			   "--clang-tidy"
			   "--completion-style=detailed"
			   "--header-insertation=never")))
  (add-to-list 'eglot-server-programs
	       '(c++-mode . ("clangd"
			    "--background-index"
			    "--clang-tidy"
			    "--completion-style=detailed"
			    "--header-insertion=never")))
  (setq-default eglot-workspace-configuration
		'(:pylsp
		  (:plugins
		   (:jedi_completion
		    (:include_params t
		     :fuzzy t)
	            :pycodestyle
		    (:maxLineLength 120)
		    :mccabe
		    (:threshold 15))))))

(defun my-python-project-root ()
  "Return the current Python project root, or `default-directory'."
  (let ((project (and (fboundp 'project-current)
                      (project-current nil))))
    (or (and project (car (project-roots project)))
        (locate-dominating-file default-directory "pyproject.toml")
        (locate-dominating-file default-directory "setup.cfg")
        (locate-dominating-file default-directory "setup.py")
        (locate-dominating-file default-directory "requirements.txt")
        (locate-dominating-file default-directory ".git")
        default-directory)))

(defun my-python-locate-virtualenv (root)
  "Return a conventional virtual environment directory below ROOT, or nil."
  (catch 'venv
    (dolist (name '(".venv" "venv" "env"))
      (let ((dir (expand-file-name name root)))
        (when (file-directory-p dir)
          (throw 'venv dir))))))

(defun my-python-use-project-venv ()
  "Use a project-local virtual environment when one exists."
  (let* ((root (my-python-project-root))
         (venv (my-python-locate-virtualenv root)))
    (when venv
      (let* ((bin-dir (expand-file-name "bin" venv))
             (python-bin (expand-file-name "python" bin-dir)))
        (when (file-executable-p python-bin)
          (setq-local python-shell-virtualenv-root venv
                      python-shell-interpreter python-bin
                      exec-path (cons bin-dir (remove bin-dir exec-path))
                      process-environment (copy-sequence process-environment))
          (setenv "VIRTUAL_ENV" venv)
          (setenv "PATH" (concat bin-dir path-separator (or (getenv "PATH") ""))))))))

(defun my-python-format-with (program args)
  "Replace the current buffer with PROGRAM output using ARGS."
  (let ((output-buffer (generate-new-buffer " *python-format-output*"))
        (error-file (make-temp-file "emacs-python-format-stderr")))
    (unwind-protect
        (let ((status (apply #'call-process-region
                             (point-min) (point-max)
                             program nil
                             (list output-buffer error-file)
                             nil
                             args)))
          (if (zerop status)
              (let ((point-before-format (point)))
                (erase-buffer)
                (insert-buffer-substring output-buffer)
                (goto-char (min point-before-format (point-max))))
            (error "%s failed: %s"
                   program
                   (with-temp-buffer
                     (insert-file-contents error-file)
                     (string-trim (buffer-string))))))
      (when (buffer-live-p output-buffer)
        (kill-buffer output-buffer))
      (when (file-exists-p error-file)
        (delete-file error-file)))))

(defun my-python-format-buffer ()
  "Format the current Python buffer using ruff, black, or Eglot."
  (interactive)
  (let ((filename (or buffer-file-name "stdin.py")))
    (cond
     ((executable-find "ruff")
      (my-python-format-with "ruff" (list "format" "--stdin-filename" filename "-")))
     ((executable-find "black")
      (my-python-format-with "black" (list "-q" "--stdin-filename" filename "-")))
     ((and (bound-and-true-p eglot--managed-mode)
           (fboundp 'eglot-format-buffer))
      (eglot-format-buffer))
     (t
      (user-error "No Python formatter found. Install ruff or black in the active Python environment, or configure pylsp formatting")))))

(defun my-python-run-tests ()
  "Run pytest from the current project root."
  (interactive)
  (let ((default-directory (my-python-project-root)))
    (compile "python -m pytest -q")))

(defun my-python-run-file ()
  "Run the current Python file from the current project root."
  (interactive)
  (unless buffer-file-name
    (user-error "Save this buffer before running it"))
  (let* ((root (my-python-project-root))
         (default-directory root)
         (relative-file (file-relative-name buffer-file-name root)))
    (compile (format "python %s" (shell-quote-argument relative-file)))))

(defun my-python-start-eglot ()
  "Start Eglot for Python when pylsp is available."
  (if (executable-find "pylsp")
      (eglot-ensure)
    (message "pylsp was not found; Python LSP features are disabled for this buffer.")))

(defun configure-python-workspace ()
  (setq-local indent-tabs-mode nil
              tab-width 4
              python-indent-offset 4
              fill-column 120
              require-final-newline t
              show-trailing-whitespace t
              company-backends '((company-capf company-files))
              compile-command "python -m pytest -q")
  (font-lock-add-keywords nil
                          '(("\\<\\(TODO\\|FIXME\\|HACK\\|NOTE\\):" 1 font-lock-warning-face t)))
  (my-python-use-project-venv)
  (my-python-start-eglot))

(use-package python
  :ensure nil
  :custom (python-shell-interpreter "python3")
  :bind (:map python-mode-map
              ("C-c p f" . my-python-format-buffer)
              ("C-c p t" . my-python-run-tests)
              ("C-c p r" . my-python-run-file))
  :hook (python-mode . configure-python-workspace))

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

(defun my-c-cpp-mode-setup ()
  "Configure C/C++ development."
  (setq-local c-basic-offset 4
	      tab-width 4
	      fill-column 100)
  (setq-local compile-command
	      (cond
	       ((file-exists-p "Makefile") "make -k")
	       ((file-exists-p "makefile") "make -k")
	       ((file-directory-p "build") "cmake --build build")
	       ((eq major-mode 'c++-mode)
		"g++ -Wall -Wextra -Wpedantic -g -std=c++17 -o main main.cpp")
	       (t
		"gcc -Wall -Wextra -Wpedantic -g -o main main.c")))
  (when (executable-find "clangd")
    (eglot-ensure)))

(use-package cc-mode
  :ensure nil
  :mode
  (("\\.c\\'" . c-mode)
   ("\\.h\\'" . c-mode)
   ("\\.cpp\\'" . c++-mode)
   ("\\.cc\\'" . c++-mode)
   ("\\.cxx\\'" . c++-mode)
   ("\\.hpp\\'" . c++-mode)
   ("\\.h\\'" . c++-mode)
   ("\\.hxx\\'" . c++-mode))
  :hook
  ((c-mode c++-mode) . my-c-cpp-mode-setup))

(defun my-c-cpp-format-buffer ()
  "Format current C/C++ buffer using clang-format."
  (interactive)
  (if (executable-find "clang-format")
      (let ((point-position (point)))
	(shell-command-on-region
	 (point-min)
	 (point-max)
	 "clang-format"
	 (current-buffer)
	 t)
	(goto-char point-position))
    (user-error "clang-format is not installable")))

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-c f") #'my-c-cpp-format-buffer)
  (define-key c-mode-base-map (kbd "C-c c") #'compile))

(defun my-shell-mode-setup ()
  "Configure Bash/sh development."
  (setq-local sh-basic-offset 2
	      sh-indentation 2
	      indent-tabs-mode nil
	      tab-width 2
	      fill-column 100)
  (add-hook 'after-save-hook
	    #'executable-make-buffer-file-executable-if-script-p
	    nil
	    t)
  (when buffer-file-name
    (setq-local compile-command
		(format "shellcheck %s"
			(shell-quote-argument buffer-file-name)))))

(use-package sh-script
  :ensure nil
  :mode
  (("\\.sh\\'" . sh-mode)
   ("\\.bash\\'" . sh-mode)
   ("\\.zsh\\'" . sh-mode)
   ("\\.env\\'" . sh-mode))
  :hook
  (sh-mode . my-shell-mode-setup))

(defun my-shellcheck-buffer ()
  "Run shellcheck on the current shell script."
  (interactive)
  (if (and buffer-file-name
	   (executable-find "shellcheck"))
      (compile
       (format "shellcheck %s"
	       (shell-quote-argument buffer-file-name)))
    (user-error "shellcheck is not installed or buffer has no file name")))

(defun my-shfmt-buffer ()
  "Format the current shell script with shfmt."
  (interactive)
  (if (executable-find "shfmt")
      (let ((point-position (point)))
	(shell-command-on-region
	 (point-min)
	 (point-max)
	 "shfmt -i 2 -ci -sr"
	 (current-buffer)
	 t)
	(goto-char point-position))
    (user-error "shfmt is not installed")))

(use-package markdown-mode
  :hook (markdown-mode . turn-on-auto-fill))

(use-package org
  :ensure nil
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :custom
  (org-log-done 'time)
  (org-startup-with-inline-images t)
  (org-image-actual-width nil)
  (org-agenda-files (directory-files-recursively (expand-file-name "~/Documents/notes/") "\\.org$")))

(use-package appt
  :ensure nil
  :config
  (setq appt-message-warning-time 10
        appt-display-format 'window
        appt-display-duration 30)
  (appt-activate 1)
  (org-agenda-to-appt))

(with-eval-after-load 'tex
  (add-to-list 'TeX-command-list
               '("LatexMk"
                 "latexmk -outdir=build -pdf -interaction=nonstopmode -file-line-error -synctex=1 %t"
                 TeX-run-TeX nil t
                 :help "Run latexmk")))

(defun my-text-soft-wrap-setup ()
  "Enable pleasant soft wrapping for text-oriented nodes."
  (setq-local truncate-lines nil)
  (setq-local word-wrap t)
  (visual-line-mode 1))

(add-hook 'org-mode-hook #'my-text-soft-wrap-setup)
(add-hook 'markdown-mode-hook #'my-text-soft-wrap-setup)
(add-hook 'text-mode-hook #'my-test-soft-wrap-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-buffer-menu t)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(doom-themes eglot use-package projectile page-break-lines dashboard treemacs-nerd-icons treemacs latex-math-preview company-math company latex-extra cdlatex yaml-mode smart-tabs-mode markdown-preview-mode js-auto-format-mode dockerfile-mode multi-line move-text go-mode python-mode monokai-theme markdown-mode))
 '(warning-suppress-types '((comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
