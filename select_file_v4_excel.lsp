(load "xlsx-mode.el")

(defun trim-string (str)
  (replace-regexp-in-string "\\`[[:space:]\n]*\\|[[:space:]\n]*\\'" "" str))

(defun read-excel-file (file-path)
  (let ((data '()))
    (setq wb (xlsx-open-file file-path))
    (if wb
        (progn
          (setq sheet (xlsx-sheet-name-at-index wb 0)) ; Assuming data is in the first sheet
          (setq rows (xlsx-sheet->list wb sheet))
          (mapc (lambda (row)
                  (let ((line (mapconcat 'identity row ",")))
                    (setq line (trim-string line))
                    (if (= 3 (length row))
                        (setq data (cons row data))
                      (princ (concat "\nInvalid row: " line " - Skipping row.")))))
                rows)
          (xlsx-close-file wb)
          (reverse data))
      (princ "Error: Unable to open file."))))

(defun draw-shapes-from-excel (file-path)
  (setq file-data (read-excel-file file-path))
  (if file-data
  
