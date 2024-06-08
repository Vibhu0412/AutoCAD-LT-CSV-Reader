(defun read-csv-file (file-path)
  (setq data '())
  (setq file (open file-path "r"))
  (princ "\n HAHA I AM CALLED\n")
  (if file
      (progn
        (princ (strcat "\nReading file: " file-path)) ; Debug print
        (while (setq line (read-line file))
          (princ (strcat "\nRead line: " line)) ; Debug print
          (setq data (cons (vl-string-split line ",") data)))
        (close file)
        (reverse data))
      (princ "Error: Unable to open file.")))


(defun c:Selectfile ()
  (setq file-path (getfiled "Select File" "" "csv" 4))
  (if file-path
      (progn
        (princ (strcat "\nThe following file is selected: " file-path))

        (setq ext (strcase (vl-filename-extension file-path)))
	(princ (strcat "\nThe EXT is: " ext)) ; Debug print

        (setq file-data (cond ((equal ext ".CSV") (read-csv-file file-path))
                              (t nil)))
        (princ (strcat "\nBelow is the file-data", file-data)) ; Debug print

        (if file-data
            (progn
              (foreach row file-data
                       (foreach cell row
                                (princ (strcat cell " ")))
                       (princ "\n")))
            (princ "Error reading file.")))
    (princ "\nOUTSIDE IF NO file selected.")))

(princ "\nType Selectfile to run the program.")
