;;用F2快捷键快速启动配置文件
(global-set-key (kbd "<f2>") 'open-my-init-file)

;;打开最近文件 
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)



;;设置打开org文件自动进入org模式。后三行为定义快捷键
;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;代码缩进
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;Hippie补全
(global-set-key (kbd "s-/") 'hippie-expand)

;;swiper
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)


;;只有加载dired后才会执行下面的命令
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
;;只有进入dired-mode（Major mode）才能定义dired-mode-map，所以必须先加载dired。这里使用延迟加载是为了提高emacs运行速度

;;增强occur的功能
(global-set-key (kbd "M-s o") 'occur-dwim)

;;增强imenu的功能
(global-set-key (kbd "M-s i") 'counsel-imenu)

;;expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;;iedit快捷键
;;(global-set-key (kbd "M-s e") 'iedit-mode)

;;将company的向上选择和向下选择改为C-n和C-p
(with-eval-after-load 'company
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;auto-yasnippet
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

;;将M-d 设置为删除光标前一个字符
(global-set-key (kbd "M-d") 'backward-delete-char-untabify)

;;将标记(Mark set)的快捷键设置为 C-i
(global-set-key (kbd "C-i") 'set-mark-command)

;;将outline的快捷键改为 C-o
(setq outline-minor-mode-prefix [(control o)])

;;highlight-symbol的快捷键
(global-set-key [(control \')] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;;将切换窗口的命令 C-x o 改为 C-;
(global-set-key (kbd "C-;") 'other-window)

(provide 'init-keybindings)


