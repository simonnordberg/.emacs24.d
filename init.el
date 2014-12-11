;; Directories and file names
(setq sn-emacs-init-file (or load-file-name buffer-file-name))
(setq user-emacs-directory (file-name-directory sn-emacs-init-file))

;; Set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" user-emacs-directory))
(load custom-file)

;; Packages
(require 'package)
(add-to-list 'load-path (expand-file-name "el-get/el-get" user-emacs-directory))

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;;(unless (require 'el-get nil 'noerror)
;;  (add-to-list 'package-archives
;;               '("melpa" . "http://melpa.org/packages/"))
;;  (package-refresh-contents)
;;  (package-initialize)
;;  (package-install 'el-get)
;;  (require 'el-get))

(setq my:el-get-packages
      '(rcodetools
        org-mode
        color-theme
        rainbow-mode
        ))

(el-get 'sync my:el-get-packages)

;;
;; Backup
;;
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))


;;
;; Code
;;
(setq sn-code-modes-hook nil)

;; Color-code matching delimiters
(el-get 'sync '(rainbow-delimiters))
(add-hook 'sn-code-modes-hook
	  (lambda () (rainbow-delimiters-mode 1)))

(autoload 'fci-mode "fill-column-indicator"
  "Toggle fill column indicator"
  t)

;; Line numbers
(add-hook 'sn-code-modes-hook
	  (lambda () (linum-mode 1)))

;; Truncate lines
(add-hook 'sn-code-modes-hook
	  (lambda () (setq truncate-lines t)))

(add-hook 'sn-code-modes-hook
          (lambda ()
            (add-hook 'before-save-hook 'whitespace-cleanup nil t)))

(add-hook 'org-export-preprocess-hook
          (lambda () (fci-mode -1)))

(add-hook 'sn-code-modes-hook
          (lambda () (hl-line-mode 1)))

(defun sn-run-code-modes-hook ()
  (run-hooks 'sn-code-modes-hook))
