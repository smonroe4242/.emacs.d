;; Configure flutter development environment

; Make sure packages are there
(setq flutter-package-selected-packages
      '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
                  ;; Optional packages
                  lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p flutter-package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install flutter-package-selected-packages))

; add to lsp hook
(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)

(add-to-list 'load-path "~/.emacs.d/flutter")

;; Assuming usage with dart-mode
(use-package dart-mode
  ;; Optional
  :hook (dart-mode . flutter-test-mode)
  :custom
  (lsp-dart-sdk-dir "~/flutter/bin/cache/dart-sdk")
  (lsp-dart-flutter-sdk-dir "~/flutter")
  (lsp-enable-links nil)
  (lsp-ui-doc-max-height 100)
  (lsp-ui-doc-max-width 200)
  :bind ("C-c d" . #'lsp-ui-doc-focus-frame)
)
(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-z" . #'flutter-run-or-hot-reload)
              ("C-M-x" . #'flutter-hot-restart))
  :custom
  (flutter-sdk-path "~/flutter/")
  :load-path "~/.emacs.d/flutter"
)

;;Class Macros
(defvar dart-snip-builder "
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give me a title!'),
      ),
      body: Center(
        child: const Text('Give me a body!'),
      ),
    );
  }
")

(defun dart-make-stateless-class (class)
  (interactive "sStateless class name: ")
  (insert "
class "class" extends StatelessWidget {
  const "class"({
    Key? key,
  }) : super(key: key);
"dart-snip-builder"}
"))

(defun dart-make-stateful-widget (class)
  (interactive "sStateful class name: ")
  (insert "
class "class" extends StatefulWidget {
  const "class"({Key? key}) : super(key: key);

  @override
  _"class"State createState() => _"class"State();
}

class _"class"State extends State<"class"> {
"dart-snip-builder"}
"))

(defun dart-make-json-class (class)
  (interactive "sClass Name: ")
  (insert "import 'package:json_annotation/json_annotation.dart';

part '"(un-camelcase-string class "_")".g.dart';

@JsonSerializable()
class "class" {
  "class"({
  });

  factory "class".fromJson(Map<String, dynamic> json) =>
      _$"class"FromJson(json);

  Map<String, dynamic> toJson() => _$"class"ToJson(this);
}
"))

(defun un-camelcase-string (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
  Default for SEP is a hyphen \"-\".

  If third argument START is non-nil, convert words after that
  index in STRING."
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "-")
                                     (downcase (match-string 0 s)))
                             t nil s)))
    (downcase s)))
(provide 'setup-flutter)
