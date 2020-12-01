;; This file is only for windows 7/8/8.1
;; The only thing it does is to set the HOME directories for emacs,
;; then trigger the init.el in the directory specified by HOME to
;; accomplish the true initialization
;; You should put this file in the default HOME directory right after
;; emacs is installed

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;org文学编程
;;(require 'org-install)
;;(require 'ob-tangle)
;;(org-babel-load-file (expand-file-name "cpd.org" user-emacs-directory))


(add-to-list 'load-path "~/.emacs.d/lisp")

;;定义快速启动配置文件的函数，这个必须放在(require 'init-keybindings.el)前面，因为其会调用该函数
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))


(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)

;;加载custom.el文件
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)


;;启动时自动最大化
(add-to-list 'default-frame-alist '(fullscreen . maximized))





















