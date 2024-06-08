(defun draw-rectangles-from-file (file-path)
  (setq file (open file-path "r"))
  (if file
      (progn
        (print "File opened successfully.")
        (while (setq line (read-line file))
          (setq space-pos (vl-string-search " " line)) ; Find the position of the space
          (if (> space-pos 0) ; Ensure space exists
              (progn
                (setq length (substr line 1 (- space-pos 1))) ; Extract length substring
                (setq breadth (substr line (+ space-pos 1))) ; Extract breadth substring
                (setq length (atof length)) ; Convert length to number
                (setq breadth (atof breadth)) ; Convert breadth to number
                (command "_RECTANG" "0,0" length breadth)
                (print "Rectangle drawn.")
              )
              (print "Invalid dimensions format.")
          )
        )
        (close file)
        (princ "All rectangles drawn.")
      )
      (princ "Failed to open file.")
  )
)

(defun C:DRAWRECT ()
  (setq file-path "C:\\Users\\vaibh\\Documents\\autocad_task\\1_5_2024\\sample_rectangle_output.txt")
  (draw-rectangles-from-file file-path)
  (princ)
)
