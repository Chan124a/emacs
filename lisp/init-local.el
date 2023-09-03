;;; init-local.el --- my own config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;启用lsp
;; (require 'lsp-mode)
;; (add-hook 'XXX-mode-hook #'lsp)

;; 设置这个是为了让magit的ssh服务能够正常运行
(setenv "HOME" "C:\\Users\\123")

;; 设置tramp默认方法为plink
;; window下tramp使用ssh会卡死,原因未知
(setq tramp-default-method "plink")

;;加快tramp的启动
;; (setq tramp-auto-save-directory "~/tmp/tramp/")
;; (setq tramp-chunksize 2000)

;;将C-h绑定为删除光标前字符
(global-set-key (kbd "C-h") 'paredit-backward-delete)

:;墨水屏黑白主题
(require 'paperlike-theme)
(provide 'init-local)

;;启动nov,支持epub阅读
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(setq nov-unzip-program "E:\\Git\\usr\\bin\\unzip.exe")
(with-eval-after-load "nov"
  (when (string-equal system-type "windows-nt")
    (setq process-coding-system-alist
          (cons `(,nov-unzip-program . (gbk . gbk))
                process-coding-system-alist))))

;;启动自动换行
(global-visual-line-mode)

(setq debug-on-error t)
;;; init-locales.el ends here
