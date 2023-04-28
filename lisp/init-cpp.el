;;参考教程http://tuhdo.github.io/c-ide.html，设置c++ IDE环境
(add-to-list 'load-path (expand-file-name "lisp/c_ide" user-emacs-directory))
(require 'setup-general)
;; (if (version< emacs-version "24.4")
;;     (require 'setup-ivy-counsel)
;;   (require 'setup-helm)
;;   (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

(provide 'init-cpp)