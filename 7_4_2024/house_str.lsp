(defun c:HOUSE ()
  (setq houseWidth 50) ; Width of the house
  (setq houseHeight 30) ; Height of the house
  (setq doorWidth 10) ; Width of the door
  (setq doorHeight 20) ; Height of the door
  (setq windowWidth 8) ; Width of the window
  (setq windowHeight 8) ; Height of the window

  (command "_rectangle" "0,0" (strcat (rtos houseWidth) "," (rtos houseHeight))) ; Draw the main house shape
  (command "_rectangle" (strcat (rtos (- (/ houseWidth 2) (/ doorWidth 2))) ",0") (strcat (rtos (+ (/ houseWidth 2) (/ doorWidth 2))) "," (rtos doorHeight))) ; Draw the door
  (command "_rectangle" (strcat (rtos (- (/ houseWidth 2) (/ windowWidth 2))) "," (rtos houseHeight)) (strcat (rtos (- (/ houseWidth 2) (/ windowWidth 2) windowWidth)) "," (strcat houseHeight "+" (rtos (+ windowHeight)))))) ; Draw the first window
  (command "_rectangle" (strcat (rtos (/ (- houseWidth windowWidth) 2)) "," (rtos houseHeight)) (strcat (rtos (/ (- houseWidth windowWidth) 2) windowWidth) "," (strcat houseHeight "+" (rtos (+ windowHeight)))))) ; Draw the second window
  (command "_rectangle" (strcat (rtos (+ (/ houseWidth 2) (/ windowWidth 2))) "," (rtos houseHeight)) (strcat (rtos (+ (/ houseWidth 2) (/ windowWidth 2) windowWidth)) "," (strcat houseHeight "+" (rtos (+ windowHeight)))))) ; Draw the third window
  (princ)
)
