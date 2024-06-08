(defun C:test-draw-rectangle ()
  (command "_RECTANG" "0,0" "30,30")
  (princ "Static rectangle drawn.\n"))
