;*******************************************************************************;
;                                                                               ;
;                                                          :::      ::::::::    ;
;    dotemacs                                            :+:      :+:    :+:    ;
;                                                      +:+ +:+         +:+      ;
;    by: thor <thor@42.fr>                           +#+  +:+       +#+         ;
;                                                  +#+#+#+#+#+   +#+            ;
;    Created: 2013/06/18 14:01:14 by thor               #+#    #+#              ;
;    Updated: 2020/04/09 12:55:03 by smonroe          ###   ########.fr        ;
;                                                                               ;
;*******************************************************************************;

; Load general features files

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
;(add-to-list 'package-archives
;         '("melpa" . "http://melpa.org/packages/") t)
;  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

										;(add-to-list 'package-archives
	     ;;'("melpa-stable" . "http://stable.melpa.org/packages/")
	     ;;'("melpa-unstable" . "http://melpa.org/packages/")
;)
(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm))
(require 'setup-helm-gtags)
;(require 'setup-ggtags); need to install separately
(require 'setup-cedet)
(require 'setup-editing)
(require 'lsp-mode)
(add-hook 'gdscript-mode-hook #'lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;only one of these at a time please
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
	 (quote
		("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/26.1/x86_64-linux-gnu" "~/Godot/bin")))
 '(gdscript-gdformat-save-and-format nil)
 '(gdscript-godot-executable "~/Godot/godot/bin/godot.x11.opt.tools.64")
 '(package-selected-packages
	 (quote
		(flycheck helm-lsp spinner lsp-mode gdscript-rx ggtags tide gnu-elpa-keyring-update multiple-cursors iedit volatile-highlights anzu comment-dwim-2 ws-butler dtrt-indent yasnippet undo-tree helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package geiser))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "dim gray"))))
 '(window-divider-first-pixel ((t (:foreground "dim gray")))))
										;thank you
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq manconfig_files "/usr/share/emacs/site-lisp/")
(setq load-path (append (list nil manconfig_files) load-path))

(load "/home/smonroe/.emacs.d/list.el")
(load "/home/smonroe/.emacs.d/string.el")
(load "/home/smonroe/.emacs.d/comments.el")
(load "/home/smonroe/.emacs.d/functions.el")
(load "/home/smonroe/.emacs.d/multi-curs.el")

(autoload 'php-mode "php-mode" "Major mode for editing PHP code" t)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

; Set default emacs configuration
(set-language-environment "UTF-8")
(setq-default font-lock-global-modes t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default basic-offset 2)
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 2)
(setq-default c-default-style "linux")
(setq-default tab-stop-list (number-sequence 2 120 2))

(global-set-key (kbd "TAB") 'indent-relative)
(global-set-key (kbd "<tab>") 'indent-relative)
(global-set-key (kbd "C-c j") 'goto-line)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c b") 'battery)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

(display-battery-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(set-face-attribute 'default nil :font "Monospace-8")
(add-to-list 'exec-path "/home/smonroe/Godot/bin")
(setenv "PATH" (mapconcat #'identity exec-path path-separator))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stripping out ansi escape codes from various emacs buffers
;; namely compilation mode and shell mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; Stolen from (https://oleksandrmanzyuk.wordpress.com/2011/11/05/better-emacs-shell-part-i/)
(defun regexp-alternatives (regexps)
  "Return the alternation of a list of regexps."
  (mapconcat (lambda (regexp)
               (concat "\\(?:" regexp "\\)"))
             regexps "\\|"))

(defvar non-sgr-control-sequence-regexp nil
  "Regexp that matches non-SGR control sequences.")

(setq non-sgr-control-sequence-regexp
      (regexp-alternatives
       '(;; icon name escape sequences
         "\033\\][0-2];.*?\007"
         ;; non-SGR CSI escape sequences
         "\033\\[\\??[0-9;]*[^0-9;m]"
         ;; noop
         "\012\033\\[2K\033\\[1F"
         )))

(defun filter-non-sgr-control-sequences-in-region (begin end)
  (save-excursion
    (goto-char begin)
    (while (re-search-forward
            non-sgr-control-sequence-regexp end t)
      (replace-match ""))))

(defun filter-non-sgr-control-sequences-in-output (ignored)
  (let ((start-marker
         (or comint-last-output-start
             (point-min-marker)))
        (end-marker
         (process-mark
          (get-buffer-process (current-buffer)))))
    (filter-non-sgr-control-sequences-in-region
     start-marker
     end-marker)))

(add-hook 'comint-output-filter-functions
          'filter-non-sgr-control-sequences-in-output)
