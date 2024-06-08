(defun split-string-by-comma (str)
  (if (zerop (strlen str))
      '()
      (cons (substr str 1 (vl-string-search "," str))
            (split-string-by-comma (substr str (+ 2 (vl-string-search "," str)) (strlen str))))))

(defun read-csv-file (file-path)
  (setq data '())
  (setq file (open file-path "r"))
  (princ "\n HAHA I AM CALLED\n")
  (if file
      (progn
        (while (setq line (read-line file))
          (if line ; Check if line is nil
              (progn
                (princ (strcat "\nRead line: " line)) ; Debug print
                (setq split-line (split-string-by-comma line))
                (if split-line
                    (setq data (cons split-line data))))))
        (close file)
        (reverse data))
      (princ "Error: Unable to open file."))))


(defun c:V2Selectfile ()
  (setq file-path (getfiled "Select File" "" "csv" 4))
  (if file-path
      (progn
        (princ (strcat "\nThe following file is selected: " file-path))
        (setq ext (strcase (vl-filename-extension file-path)))
        (princ (strcat "\nThe EXT is: " ext))
        (setq file-data (cond ((equal ext ".CSV") (read-csv-file file-path))
                              (t nil)))
        (princ (strcat "\nBelow is the file-data: " (strcat file-data "\n"))) ; Debug print
        (if file-data
            (progn
              (foreach row file-data
                       (foreach cell row
                                (princ (strcat cell " ")))
                       (princ "\n")))
            (princ "Error reading file."))))) ; Removed the extra closing parenthesis

(princ "\nType V2Selectfile to run the program.")
