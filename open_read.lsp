(defun read-excel-file (file-path)
  (vl-load-com)
  (setq excel (vlax-get-or-create-object "Excel.Application"))
  (setq workbook (vlax-invoke excel 'Workbooks 'Open file-path))
  (setq worksheet (vlax-invoke workbook 'Worksheets 'Item 1))
  
  (setq data '())
  (setq rows (vlax-get worksheet 'Rows))
  (vlax-for row rows
    (setq rowData '())
    (setq columns (vlax-get row 'Columns))
    (vlax-for column columns
      (setq cell (vlax-invoke row 'Cells (vlax-get column 'Column)))
      (setq cellValue (vlax-get cell 'Value))
      (if (null cellValue)
          (setq cellValue "")
          )
      (setq rowData (cons cellValue rowData))
      )
    (setq data (cons (reverse rowData) data))
    )
  
  (vlax-release-object excel)
  (vlax-release-object workbook)
  (vlax-release-object worksheet)
  
  data
  )

(defun read-csv-file (file-path)
  (setq data '())
  (setq file (open file-path "r"))
  (while (setq line (read-line file))
    (setq data (cons (vl-string-split line ",") data))
    )
  (close file)
  (reverse data)
  )

(defun c:PrintData ()
  (setq file-path (getfiled "Select File" "" "Excel and CSV Files (*.xlsx;*.csv)|*.xlsx;*.csv"))
  (if file-path
    (progn
      (setq ext (strcase (vl-filename-extension file-path)))
      (setq file-data (cond ((equal ext "XLSX") (read-excel-file file-path))
                            ((equal ext "CSV") (read-csv-file file-path))
                            (t nil)))
      (if file-data
        (progn
          (foreach row file-data
            (foreach cell row
              (princ (strcat cell " ")))
            (princ "\n"))
          )
        (princ "Error reading file.")
        )
      )
    (princ "No file selected.")
    )
  )

(princ "\nType PrintData to run the program.")
