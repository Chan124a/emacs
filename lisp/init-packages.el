(require 'package)
(package-initialize)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; C - Common Lisp Extension
;(require 'cl)

;; Add Packages
;(defvar my/packages '(
;                company
 ;               hungry-delete
  ;              swiper
   ;             counsel
    ;            smartparens
     ;           ;; --- Major Mode ---
      ;          js2-mode
       ;         ;; --- Minor Mode ---
        ;        nodejs-repl;;运行js代码
         ;       ;;exec-path-from-shell
          ;      ;; --- Themes ---
           ;     monokai-theme
            ;    ;; solarized-theme
             ;   ) "Default packages")



;;启用hungry-delete
;;(require 'hungry-delete)
;;(global-hungry-delete-mode)

;;(setenv "HOME" "C:/Users/123/AppData/Roaming/") ;; you can change this dir to the place you like,可用于将HOME变量设置为任意路径
;;(load "~/.emacs.d/init.el");;用于加载配置文件init.el

;;启用smartparens
;;(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t);;全局使用

;;启用js2-mode
(setq auto-mode-alist
          (append
           '(("\\.js\\'" . js2-mode))
           auto-mode-alist))

;;配置auctex
;;这两行不是必要的,如果打开tex文件，菜单栏会出现Preview、LaTex和Command三个选项即可
;;(load "auctex.el" nil t t)
;;(load "preview.el" nil t t)
;;下面两行命令是文档解析功能，为了获得在文档中使用的许多LaTeX软件包的支持
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;;如果您经常使用\include或 \input，则应使AUCTeX能够加载多文件文档的结构。
;;每次您打开一个新文件时，AUTCeX都会要求您提供一个主文件。
(setq-default TeX-master nil)
;;(setq global-font-lock-mode t) ;;高亮显示代码，这个默认设置为t
;;设置xetex为编译器
(setq TeX-engine 'xetex)
;;设置自动开启cdlatex
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
;;设置正向搜索,指定sumatraPDF为pdf预览器
(setq TeX-PDF-mode t) 
(setq TeX-source-correlate-mode t) 
(setq TeX-source-correlate-method 'synctex) 
(setq TeX-view-program-list 
'(("Sumatra PDF" ("\"F:/SumatraPDF/SumatraPDF.exe\" -reuse-
instance" (mode-io-correlate " -forward-search %b %n ") " %o")))) 
(add-hook 'LaTeX-mode-hook
(lambda ()
(assq-delete-all 'output-pdf TeX-view-program-selection)
(add-to-list 'TeX-view-program-selection '(output-pdf "Sumatra PDF"))))

;;启用popwin
(require 'popwin)
(popwin-mode 1)

;;设置smex
;;(require 'smex) ; Not needed if you use package.el
;;(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					; when Smex is auto-initialized on its first run.
;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;打开自动补全插件
(global-company-mode 1)

;;默认打开主题monokai
;;(load-theme 'monokai 1)

;;启用swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)

;;增强image的功能
(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
			       ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq imenu-create-index-function 'js2-imenu-make-index)))

;;;;启用org-download
;;(require 'org-download)
;;;; Drag-and-drop to `dired`
;;(add-hook 'dired-mode-hook 'org-download-enable)
(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "e:/org/images")
  (org-download-screenshot-method "e:/IrfanView/i_view64.exe /capture=4 /convert=\"%s\"")
  :bind
  ("C-S-y" . org-download-screenshot)
  :config
  (require 'org-download))

;;启用yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'org-mode-hook 'yas-minor-mode) ;;只有在org文件下才打开yas功能
;;(yas-global-mode 1) ;;启动自动打开yas功能

;;启用highlight-thing
;;(global-highlight-thing-mode t)
;;(setq highlight-thing-what-thing 'symbol)
;;(setq highlight-thing-delay-seconds 0.1)
;;(setq highlight-thing-limit-to-defun t)
;;(setq highlight-thing-case-sensitive-p t)

;;启用highlight-symbol,四个快捷键:C-',f3,S-f3,M-f3
(require 'highlight-symbol)

(provide 'init-packages)

;;启用multiple-cursors
(require 'multiple-cursors)

