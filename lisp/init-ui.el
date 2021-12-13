;;关闭工具栏
(tool-bar-mode -1)
;;关闭文件滑动控件
;;(scroll-bar-mode -1)

;;关闭启动帮助页面
(setq inhibit-splash-screen 1)

;;改变光标样式
(setq-default cursor-type 'bar)

;;高亮显示当前行
(global-hl-line-mode t) ;;t相当于1

;;开启全局行号显示
;;(global-linum-mode t) ;;这个开了之后会导致org文件卡顿，所以我关闭了
(global-display-line-numbers-mode t)


(provide 'init-ui)
