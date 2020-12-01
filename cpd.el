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
