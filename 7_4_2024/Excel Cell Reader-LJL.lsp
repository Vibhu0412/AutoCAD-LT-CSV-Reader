;--- Excel Cell Reader Sub-Routine
;--- by Leonard Lorden
;--- July 26, 2017
;--- Routine to OPEN an existing Excel file (best to confirm filename & path prior to calling)
;--- Call routine with path & filename (Example:  OpenExcel ""C:/Users/vaibh/Documents/autocad_task/data.xlsx"")
;--- File will be opened hidden
(defun OpenExcel (Exfile)
	(setq MyFile (findfile Exfile))										;double check file exists at location
	(if (/= Myfile nil)													;nil = file not found
		(progn															;if file found open it
			(setq MyXL (vlax-get-or-create-object "Excel.Application"))	;find Excel application
			(vla-put-visible MyXL :vlax-false)							;hide application from view
			(vlax-put-property MyXL 'DisplayAlerts :vlax-false)			;hide Excel alerts
			(setq MyBook (vl-catch-all-apply 'vla-open (list (vlax-get-property MyXL "WorkBooks") MyFile)))
		))
)																		;return	- MyFile = nil if file not found	
		
;--- Routine to CLOSE Excel file & Session
;--- Assumes previously opened with OpenExcel function
(defun CloseExcel
	(vl-catch-all-apply 'vlax-invoke-method (list MyBook "Close"))
	(vl-catch-all-apply 'vlax-invoke-method (list MyXL "Quit"))
	(vl-catch-all-apply 'vlax-release-object MyCell)
	(vl-catch-all-apply 'vlax-release-object MyRange)
	(vl-catch-all-apply 'vlax-release-object MySheet)
	(vl-catch-all-apply 'vlax-release-object MyBook)	
	(vl-catch-all-apply 'vlax-release-object MyXL)
	(setq MyFile nil MyXL nil MyBook nil MySheet nil MyRange nil
	MyTab nil MyCell nil ExCell nil)									;clear variables from memory
	(gc)																;garbage cleanup
)																		;return

;--- Routine to set Worksheet Tab
;--- Call using GetTab "Tabname"  (Example:  GetTab Sheet1)
;--- If MySheet = nil on return then requested TAB not found in Excel file or Excel file was not open
(defun GetTab (MyTab)
	(if (/= MyXL nil)													;ensure file is open
		(progn															;if it is then...
			(setq MySheet (vl-catch-all-apply 'vlax-get-property (list (vlax-get-property myBook "Sheets") "Item" MyTab)))
			(if (not (vl-catch-all-error-p MySheet))					;if requested tab found then...
				(vlax-invoke-method MySheet "Activate")					;set the desired active tab
				(setq MySheet nil)))									;if tab not found then nil MySheet
		(setq MySheet nil))												;if file wasn't open then nil MySheet
MySheet)																;return with Mysheet status

;--- Routine to READ an Excel Cell on the current active tab
;--- Call using GetCell "Cell Name" (Example:  GetCell A1)
;--- MyCell returns cell value (nil = empty)
(defun GetCell (ExCell)
 	(if (/= MyXL nil)													;ensure file is open
		(progn															;if it is then...
			(setq MyRange (vlax-get-property (vlax-get-property MySheet 'Cells) "Range" ExCell))
			(setq MyCell (vlax-variant-value (vlax-get-property MyRange 'Value2))))
	(setq MyCell nil))													;nill cell value if file not open
MyCell)																	;return with cell value