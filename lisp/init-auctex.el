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
;; 设置自动开启reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
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

;;设置outline

(define-key outline-minor-mode-map (kbd "C-l")
    (lookup-key outline-minor-mode-map (kbd "C-c @")))
;;设置自动打开outline-mode
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
;;设置打开tex文件自动折叠
(add-hook 'LaTeX-mode-hook 'outline-hide-body)

(provide 'init-auctex)