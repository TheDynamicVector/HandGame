
import cv2
import mediapipe as mp
import math
import os
import json

mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
mp_hands = mp.solutions.hands

player_1_gesture = "none"
player_2_gesture = "none"

with open("GestureData.txt", 'w') as the_file:
    the_file.write("none" + "," + "none")

cap = cv2.VideoCapture(0)
with mp_hands.Hands(
    model_complexity=0,
    min_detection_confidence=0.7,
    min_tracking_confidence=0.6) as hands:
  while cap.isOpened():
    success, image = cap.read()
    if not success:
      print("Ignoring empty camera frame.")
      # If loading a video, use 'break' instead of 'continue'.
      continue

    # To improve performance, optionally mark the image as not writeable to
    # pass by reference.
    image.flags.writeable = False
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    results = hands.process(image)

    # Draw the hand annotations on the image.
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
    if results.multi_hand_landmarks:
 
      for hand_id, hand_landmarks in enumerate(results.multi_hand_landmarks):
        

        fingers = []
        fingerValues = [
        #thumb
        hand_landmarks.landmark[4],
        hand_landmarks.landmark[2],
        #index
        hand_landmarks.landmark[8],
        hand_landmarks.landmark[5],
        #middle
        hand_landmarks.landmark[12],
        hand_landmarks.landmark[9],
        #ring
        hand_landmarks.landmark[16],
        hand_landmarks.landmark[13],
        #pinky
        hand_landmarks.landmark[20],
        hand_landmarks.landmark[17]]
        x = 0
        for i in range(5):
            finger_tip_x, finger_tip_y = (1-fingerValues[x].x)*640, fingerValues[x].y * 480
            x += 1
            finger_mcp_x, finger_mcp_y = (1-fingerValues[x].x)*640, fingerValues[x].y * 480
            x += 1
            localDistance = math.dist((finger_tip_x,finger_tip_y),(finger_mcp_x,finger_mcp_y))
            fingers.append([finger_tip_x, finger_tip_y, finger_mcp_x, finger_mcp_y, localDistance])

        #Make exception for thumb
        c1 = round(math.sqrt((fingers[1][2]-fingers[0][0])**2 + (fingers[1][3]-fingers[0][1])**2))
        c2 = round(math.sqrt((fingers[1][2]-fingers[0][2])**2 + (fingers[1][3]-fingers[0][3])**2))
        c3 = round(math.sqrt((fingers[0][2]-fingers[0][0])**2 + (fingers[0][1]-fingers[0][3])**2))
        num = pow(c1,2)-pow(c2,2)-pow(c3,2)
        den = (2)*(c2)*(c3)
        thumb_to_indx_angle = 83
        try:
            thumb_to_indx_angle = 1000/math.degrees(math.acos(num/den))
        except:
           thumb_to_indx_angle = 83

        #print(thumb_to_indx_angle)
        fingers[0][4] = thumb_to_indx_angle
        threshholds = [8, 50, 90, 70, 50]

        fingers_open = []
        for i, x in enumerate(fingers):
            if x[4] < threshholds[i]:
                fingers_open.append(False)
            else:
                fingers_open.append(True)

        gestures = ["zero", "one", "two", "three", "four", "five", "ready", "l", "middle"]
        finger_combs = [
            [False, False, False, False, False], 
            [False, True, False, False, False],
            [False, True, True, False, False],
            [False, True, True, True, False],
            [False, True, True, True, True],
            [True, True, True, True, True],
            [True, False, False, False, False],
            [True, True, False, False, False],
            [False, False, True, False, False]
        ]

        if fingers_open in finger_combs:
            index = finger_combs.index(fingers_open)
            gesture = gestures[index]
        else:
           gesture = "none"
        
        if fingers[0][0] <= 320:
           player_2_gesture = gesture
        else:
           player_1_gesture = gesture

        with open("GestureData.txt", 'w') as the_file:
            the_file.write(player_1_gesture + "," + player_2_gesture)

        mp_drawing.draw_landmarks(
            image,
            hand_landmarks,
            mp_hands.HAND_CONNECTIONS,
            mp_drawing_styles.get_default_hand_landmarks_style(),
            mp_drawing_styles.get_default_hand_connections_style())

    # Flip the image horizontally for a selfie-view display.
    cv2.imshow('MediaPipe Hands', cv2.flip(image, 1))
    absolute_path = os.path.join(os.getcwd(), 'FeedImage.JPG')
    
    cv2.imwrite(absolute_path,image)

    if cv2.waitKey(5) & 0xFF == 27:
      break

cap.release()