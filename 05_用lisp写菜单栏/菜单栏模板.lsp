
;;�˵����ز��Գ���  ���ҵ�ע��
(defun c:pt_menu (/ items items1)
  ;;'((��ǩ ���� �����ִ� �μ��˵���)) ��Ϊ�˵��ע�������Ҫ��һ���ո�
 (vl-load-com) 
  ;�ڶ����Ӳ˵�����
  (setq	items1 (list '("��ͼ��"                              
		       "\003\003Q1 "                       
		       "���ܼ�飬����Գ���ûӰ��"
		      )
		     '("--" nil nil)
		     '("��ͼ��"                               
		       "\003\003E1 "
		       "���ܼ�飬����Գ���ûӰ��"
		      )
	             
	       ))
(setq	items2 (list '("ͳ���߳�"                              
		       "\003\003TJXC "                       
		       "���ܼ�飬����Գ���ûӰ��"
		      )
		     '("--" nil nil)
		     '("ͳ�����"                               
		       "\003\003TJMJ "
		       "���ܼ�飬����Գ���ûӰ��"
		      )
	             
	       )
  ) 

  
  (setq	items
	 (list '("��ֱ����"                                   ;;; ����1 �⼸���ֽ�����ʾ�ڲ˵�����
		 "\003\003HZL "                           ;;;ע��003�����Ϊ������������Ͽո�
		 "���ܼ�飬����Գ���ûӰ��"
		)
	       '("���ֶ���"                                  ;;;������������
		 "\003\003WZDQ "
		 " ���ܼ�飬����Գ���ûӰ��"
		)
	       	'("��ǽ������"
		 "\003\003ZXX "
		 " ���ܼ�飬����Գ���ûӰ��"
		)
	       '("ƽ�б�ע"
		 "\003\003DD "
		 " ���ܼ�飬����Գ���ûӰ��"
		)
	       
	       '("--" nil nil) 
	       (list "ͼ������" nil nil items1) ;  ���������һ���˵�����һ���˵��ڿ�ͷ�Ѿ����壬ע�⿴ items1 �������   Ҫ���Ӳ˵��Ͷ���һ��items Ȼ�����һ��
	       (list "ͳ�ƹ���" nil nil items2)
	       '("--" nil nil) 
	 )
  )
  (menu_pt-AddCassMenu
    "ACAD" 
    "���˹��߿�" ;_ ��ʾ��Pop�˵������� �˵�������һ��Ҫ��
    items 
    "������" 
  )
  (princ)
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���治�ÿ���,д�õĺ�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(menu_pt-RemoveMenuItem POPName) �Ƴ������˵����ɹ�����T
;;; ����: (menu_pt-RemoveMenuItem "CASS����") �Ƴ� ��CASS���ߡ� �˵�
(defun menu_pt-RemoveMenuItem (POPName / MenuBar n i MenuItem Menu tag)
  (setq MenuBar (vla-get-menubar (vlax-get-acad-object)))
  ;; �Ҳ˵� Item 
  (setq menuitem (menu_pt-CATCHAPPLY 'vla-item (list MenuBar POPName)))
  (if menuitem (menu_pt-CATCHAPPLY 'vla-RemoveFromMenuBar (list menuitem)))
)
;;���� menu_pt-AddCassMenu ���CASS�˵�
;;;�﷨: (menu_pt-AddCassMenu MenuGroupName POPName PopItems InsertBeforeItem) 
;;MenuGroupName Ҫ����Ĳ˵�������
;;POPName �����˵�����
;;PopItems �����˵��б�
;;   �� '((��ǩ ���� �����ִ� �μ�����)...) ��Ϊ�����˵��б�ע�������Ҫ��һ���ո�
;;InsertBeforeItem �ڸò˵�������֮ǰ���룬���� "������"����Ϊ nil,��������
(defun menu_pt-AddCassMenu (MenuGroupName		  POPName
			PopItems     InsertBeforeItem
			/	     MENUBAR	  N
			I	     MENUITEM	  POPUPMENU
			K	     TMP	  SUBPOPUPMENU
		       )
  ;;ж��ԭ�в˵�
  (menu_pt-RemoveMenuItem POPName)

  (setq MenuBar (vla-get-menubar (vlax-get-acad-object)))
  (if InsertBeforeItem
    (progn
      ;; ���Ҳ˵��������䡱
      (setq n (vla-get-count MenuBar))
      (setq i (1- n))
      (while
	(and (>= i 0)			; û�г�������
	     (/= InsertBeforeItem
		 (vla-get-name (setq menuitem (vla-item MenuBar i)))
	     )				; �ҵ�"������"�˵���
	)
	 (setq i (1- i))
      )
      (if (< i 0)			; ���û���ļ��˵�, ȡ���һ���˵��˵�
	(setq i (vla-get-count MenuBar))
      )
    )
    (setq i (vla-get-count MenuBar)) ;_  ȡ���һ���˵��˵�
  )
  ;;����"CASS����"�˵���
  (if (not
	(setq popupmenu
	       (menu_pt-CATCHAPPLY
		 'vla-Item
		 (list
		   (vla-get-menus
		     (vla-item
		       (vla-get-MenuGroups (vlax-get-acad-object))
		       MenuGroupName ;_ "�������߼�" �˵�������
		     )
		   )
		   POPName ;_ "CASS����" �����˵�����
		 )
	       )
	)
      )
    (setq popupmenu
	   (vla-add
	     (vla-get-menus
	       (vla-item (vla-get-MenuGroups (vlax-get-acad-object))
			 MenuGroupName ;_ "�������߼�" �˵�������
	       )
	     )
	     POPName ;_ "CASS����" �����˵�����
	   )
    )
  )
  ;;���Menu����
  (vlax-for popupmenuitem popupmenu
    (vla-delete popupmenuitem)
  )
  ;;����"CASS����"�˵���
  (vla-InsertInMenuBar popupmenu i)
  (menu_pt-insertPopMenuItems popupmenu PopItems)
  (princ)
)

;;���� menu_pt-insertPopMenuItems �������˵���
;;�﷨: (menu_pt-insertPopMenuItems popupmenu PopItems)
;;popupmenu �˵���vla����
;;PopItems �����˵��б�
;;   �� '((��ǩ ���� �����ִ� �μ�����)...) ��Ϊ�����˵��б�ע�������Ҫ��һ���ո�
(defun menu_pt-insertPopMenuItems (popupmenu PopItems / K TMP)
  (setq k 0)
  (mapcar
    (function
      (lambda (x / Label cmdstr hlpstr subItems tmp)
	(setq Label    (car x)
	      cmdstr   (cadr x)
	      hlpstr   (caddr x)
	      subItems (cadddr x)
	)
	(if (= label "--")
	  ;; ����ָ���
	  (vla-AddSeparator
	    popupmenu
	    (setq k (1+ k))
	  )
	  (if (and Label cmdstr)
	    ;; ����˵���
	    (progn
	      (setq tmp
		     (vla-addmenuitem
		       popupmenu
		       (setq k (1+ k))
		       Label
		       cmdstr
		     )
	      )
	      (vla-put-helpstring tmp hlpstr)
	    )
	    ;; ������һ���Ӳ˵�
	    (progn
	      (setq tmp
		     (vla-addsubmenu
		       popupmenu
		       (setq k (1+ k))
		       Label
		     )
	      )
	      (if subItems ;_ ����Ӽ��˵�
		(menu_pt-insertPopMenuItems tmp subItems)
	      )
	    )
	  )
	)
      )
    )
    ;;'((��ǩ ���� �����ִ� �μ��˵���)) ��Ϊ�˵��ע�������Ҫ��һ���ո�
    PopItems
  )
)
;;���� menu_pt-CatchApply �ض��� VL-CATCH-ALL-APPLY 
;;�﷨: (menu_pt-CatchApply fun args)
;;���� fun ���� �� distance or 'distance
;;     args �����Ĳ�����
;;����ֵ: �纯�����д��󷵻�nil,���򷵻غ����ķ���ֵ
(defun menu_pt-CatchApply (fun args / result)
  (if
    (not
      (vl-catch-all-error-p
	(setq result
	       (vl-catch-all-apply
		 (if (= 'SYM (type fun))
		   fun
		   (function fun)
		 )
		 args
	       )
	)
      )
    )
     result
  )
)


(c:pt_menu)
(princ)