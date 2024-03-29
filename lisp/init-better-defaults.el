(setq inhibit-compacting-font-caches t);用于解决emac中文环境下的卡顿问题

;;自动换行
(global-visual-line-mode t)

;;自动补全
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
                                              ;; Shifu
                                              ("8zl" "zilongshanren")
                                              ;; Tudi
                                              ("8lxy" "lixinyang")
					      ))

;;显示行号
;;(global-linum-mode 1)

;;加入最近打开过文件的选项让我们更快捷的在图形界面的菜单中打开最近编辑过的10个文件可用快捷键打开
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;;设置默认打开括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;关闭自动生成备份文件
;;(setq make-backup-files nil)

;;使用下面的配置文件将删除功能配置成与其他图形界面的编辑器相同，即当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)

;;自动缩进选中代码或者全部buffer的代码
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max))) ;;point-min指buffer开头，point-max是结尾

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion   ;;这个可以保存执行命令前的光标位置，执行命令后可以用于恢复光标位置
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end)) ;;region-beginning指选中区域的开头，region-end指结尾
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

;;增强hippie补全的功能
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))

;;对yes or no 设置别名为y or n
(fset 'yes-or-no-p 'y-or-n-p)

;;删除或复制目录不会询问是否递归操作
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;;启用 =dired-x= 可以让每一次进入 Dired 模式时，使用新的快捷键 =C-x C-j= 就可以进入当前文件夹的所在的路径。
(require 'dired-x)

;;可以使当一个窗口（frame）中存在两个分屏（window）时，将另一个分屏自动设置成拷贝地址的目标
(setq dired-dwin-target 1)

;;括号内高亮显示配对括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

;;定义隐藏dos系统下的换行符的函数
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

;;定义删除dos系统下换行符的函数
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;增强occur的功能
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

;;设置默认的解码为utf-8
(set-language-environment "UTF-8")

;;取消输入`时自动插入两个反引号 
(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)
;;解决c++-mode下输入单引号 ‘ 自动变为 \'\' 的问题
(setq sp-escape-quotes-after-insert nil)

;;设置打开tex文件时自动开启outline
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

;;解决Windows下Emacs显示Unicode字符的卡顿问题
(setq inhibit-compacting-font-caches t)

;;Here's a pretty comprehensive group of magic invocations to make Emacs use UTF-8 everywhere by default:
;;(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system
  (if (eq system-type 'windows-nt)
      'utf-16-le  ;; https://rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
    'utf-8))
(prefer-coding-system 'utf-8)

(provide 'init-better-defaults)

