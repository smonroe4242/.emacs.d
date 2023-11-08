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
  (add-to-list 'package-archives (cons "melpa-unstable" (concat proto "://melpa.org/packages/")) t)
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
;(require 'setup-helm-gtags)
;(require 'setup-ggtags); need to install separately
(require 'setup-cedet)
(require 'setup-editing)
(require 'lsp-mode)
(require 'setup-flutter)
(require 'multi-curs)
(require 'setup-js)
(require 'setup-compile)
(require 'setup-godot)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;only one of these at a time please
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-blinks 0)
 '(blink-cursor-interval 0.3)
 '(blink-cursor-mode t)
 '(compilation-scroll-output nil)
 '(create-lockfiles nil)
 '(elscreen-display-tab nil)
 '(exec-path
   '("~/flutter/bin" "~/.volta/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/26.1/x86_64-linux-gnu" "~/Godot/bin"))
 '(gdscript-gdformat-save-and-format nil)
 '(gdscript-godot-executable "~/Godot/godot/bin/godot.x11.opt.tools.64")
 '(helm-ag-ignore-patterns '("package-lock.json"))
 '(helm-follow-mode-persistent t)
 '(helm-locate-project-list '("/home/bones/cares/"))
 '(lsp-dart-dap-flutter-hot-reload-on-save nil)
 '(lsp-dart-enable-sdk-formatter nil)
 '(lsp-dart-flutter-sdk-dir "~/flutter" nil nil "Customized with use-package dart-mode")
 '(lsp-dart-line-length 120)
 '(lsp-dart-sdk-dir "~/flutter/bin/cache/dart-sdk" nil nil "Customized with use-package dart-mode")
 '(lsp-dart-show-todos t)
 '(lsp-response-timeout 1)
 '(lsp-ui-doc-delay 0.0)
 '(lsp-ui-doc-max-height 100 t nil "Customized with use-package dart-mode")
 '(lsp-ui-doc-use-childframe t)
 '(package-selected-packages
   '(ember-mode lsp-ui dart-mode lsp-dart web-mode xref-js2 js2-mode helm-ls-git elscreen helm-ag flycheck helm-lsp spinner lsp-mode gdscript-rx ggtags tide gnu-elpa-keyring-update multiple-cursors iedit volatile-highlights anzu comment-dwim-2 ws-butler dtrt-indent yasnippet undo-tree helm-gtags helm-projectile helm-swoop helm zygospore projectile company use-package geiser))
 '(treemacs-follow-mode t)
 '(typescript-flat-functions t)
 '(typescript-indent-level 2))

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

(autoload 'php-mode "php-mode" "Major mode for editing PHP code" t)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.svelte\\'\\|\\.hbs\\'" . web-mode))

; Set default emacs configuration
(set-language-environment "UTF-8")
(setq-default font-lock-global-modes t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default desktop-save-mode t)
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 2)
(setq-default c-default-style "linux")
(setq-default tab-stop-list (number-sequence 2 120 2))
(setq-default js-indent-level 2)
(setq-default web-mode-attr-indent-offset 2)
(setq-default web-mode-attr-value-indent-offset 2)
(setq-default web-mode-code-indent-offset 2)
(setq-default web-mode-css-indent-offset 2)
(setq-default web-mode-markup-indent-offset 2)
(setq-default web-mode-sql-indent-offset 2)
;(global-set-key (kbd "TAB") 'indent-relative)
;(global-set-key (kbd "<tab>") 'indent-relative)
(global-set-key (kbd "C-c j") 'goto-line)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c b") 'battery)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c M-g") 'helm-ls-git-ls)
(global-set-key (kbd "C-c g c") 'helm-git-local-branches)
(global-set-key (kbd "C-c C-s") 'helm-swoop)
(global-set-key (kbd "C-c C-M-s") 'helm-multi-swoop-all)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c v") 'clipboard-yank)
(global-set-key (kbd "C-c M-s") 'helm-projectile-ag)
(defun font-embiggen () (interactive) (set-face-attribute 'default nil :font "Monospace-15"))
(defun font-ensmallen () (interactive) (set-face-attribute 'default nil :font "Monospace-11"))
(global-set-key (kbd "C-c M-c") 'font-embiggen)
(global-set-key (kbd "C-c M-v") 'font-ensmallen)
(global-set-key (kbd "C-x <up>") 'beginning-of-buffer)
(global-set-key (kbd "C-x <down>") 'end-of-buffer)

(global-display-line-numbers-mode t)

(add-hook 'compilation-mode '(lambda () (setq display-line-numbers nil)))
(display-battery-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)
(setq gc-cons-threshold 20000000)
;(when (> emacs-version 26)
;  (global-display-line-numbers-mode))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(set-face-attribute 'default nil :font "Monospace-13")
(add-to-list 'exec-path "$HOME/flutter/bin")
(setenv "PATH" (mapconcat #'identity exec-path path-separator))
(global-auto-revert-mode t)
