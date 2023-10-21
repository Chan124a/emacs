(require 'package)
(setq package-check-signature nil)
(setq user-emacs-directory "~/code/emacs-c-ide-demo") ;;user-emacs-directorym默认为~/.emacs.d
(add-to-list 'load-path "~/code/emacs-c-ide-demo/custom")
(setq package-user-dir
      (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                        user-emacs-directory))

(setq package-archives '(("gnu" . "http://1.15.88.122/gnu/")
                           ("melpa" . "http://1.15.88.122/melpa/")
                           ("org" . "http://1.15.88.122/org/")))

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)



;; function-args
;; (require 'function-args)
;; (fa-config-default)

;; To use company-mode with Clang
(setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

;; 使用c++标准库补全
(add-to-list 'company-backends 'company-c-headers)
;; 将 /usr/include/c++/4.8/ 替换为c++标准库路径
;; 同时,需要将c++标准库路径也添加到.dir-locals.el文件里
(add-to-list 'company-c-headers-path-system "/usr/include/c++/4.8/") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
