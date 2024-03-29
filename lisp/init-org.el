(with-eval-after-load 'org
  ;;添加Org-mode文本内语法高亮
  (setq org-src-fontify-natively t)

  ;;设置org-mode的编程语言
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (python . t)
;;     (R . t)
;;     (ruby . t)
;;     (ditaa . t)
;;     (dot . t)
;;     (octave . t)
;;     (sqlite . t)
;;     (perl . t)
     (C . t)
     ;;(C++ . t)
     (java . t)
     ))

  ;; 设置默认 Org Agenda 文件目录
  (setq org-agenda-files '("~/org"))
)


(provide 'init-org)
