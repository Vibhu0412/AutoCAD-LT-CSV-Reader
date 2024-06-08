(defun read-excel-data (file-path)
  (vl-load-com)
  (setq xl-app (vlax-create-object "Excel.Application"))
  (setq xl-book nil)
  (setq xl-sheet nil)
  (setq data '())
  (setq success t)
  (setq errmsg "")

  (if xl-app
    (progn
      (setq xl-book (vlax-invoke-method xl-app 'Workbooks 'Open file-path))
      (if xl-book
        (progn
          (setq xl-sheet (vlax-invoke-method xl-book 'Sheets 'Item 1))
          (if xl-sheet
            (progn
              (setq xl-range (vlax-get-property xl-sheet 'UsedRange))
              (setq rows (vlax-get-property xl-range 'Rows))
              (vlax-for row rows
                (setq type (vlax-get-property row 'Cells '(1)))
                (setq length (vlax-get-property row 'Cells '(2)))
                (setq breadth (vlax-get-property row 'Cells '(3)))
                (setq entry (list (vlax-get-property type 'Value)
                                  (vlax-get-property length 'Value)
                                  (vlax-get-property breadth 'Value)))
                (setq data (cons entry data))
                )
              )
            (progn
              (setq success nil)
              (setq errmsg "Failed to get sheet.")
              )
            )
          )
        (progn
          (setq success nil)
          (setq errmsg "Failed to open workbook.")
          )
        )
      )
    (progn
      (setq success nil)
      (setq errmsg "Failed to create Excel application.")
      )
    )

  (vlax-release-object xl-range)
  (vlax-release-object xl-sheet)
  (vlax-release-object xl-book)
  (vlax-release-object xl-app)

  (if success
    data
    (progn
      (prompt (strcat "Error: " errmsg))
      nil
      )
    )
  )

(defun get-shape-data (type)
  (setq data (read-excel-data "https://docs.google.com/spreadsheets/d/1Z5EaFDPcvXCPAjl6J0O9HDRXeVZWfChx0LqEKkNowVI/edit?usp=sharing"))
  (if data
    (progn
      (foreach entry data
        (if (equal (car entry) type)
          (progn
            (setq length (cadr entry))
            (setq breadth (caddr entry))
            (cond
              ((= length breadth)
               (prompt (strcat "Square of " (rtos length) " by " (rtos breadth))))
              (t
               (prompt (strcat "Rectangle of " (rtos length) " by " (rtos breadth)))))
            )
          )
        )
      )
    )
  )

;; Example usage:
(get-shape-data "Square")
