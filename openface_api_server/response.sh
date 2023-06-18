#!/bin/bash

function response() {
  RES=$(rostopic echo /openface2/faces -n 1);

  HEADER=$(echo "${RES}" | grep -A 5 '^header');
  LEFT_GAZE=$(echo "${RES}" | grep -A 9 'left_gaze');
  RIGHT_GAZE=$(echo "${RES}" | grep -A 9 'right_gaze');
  GAZE_ANGLE=$(echo "${RES}" | grep -A 3 'gaze_angle');
  HEAD_POSE=$(echo "${RES}" | grep -A 9 'head_pose');
  ACTION_UNITS=$(echo "${RES}" | grep -A 100 'action_units')

  echo '{';
  # left_gaze
  echo '  "left_gaze": {';
  # left_gaze > position
  echo '    "position": {';
  echo -n '      "x": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "y": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '    },'
  # left_gaze > orientation
  echo '    "orientation": {';
  echo -n '      "x": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "y": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "w": '
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '    }'
  echo '  },'

  # right_gaze
  echo '  "right_gaze": {';
  # right_gaze > position
  echo '    "position": {';
  echo -n '      "x": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "y": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '    },'
  # right_gaze > orientation
  echo '    "orientation": {';
  echo -n '      "x": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ','
  echo -n '      "y": ';
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "w": '
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '    }'
  echo '  },'

  # gaze_angle
  echo '  "gaze_angle": {'
  echo -n '    "x": '
  echo "${GAZE_ANGLE}" | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '    "y": '
  echo "${GAZE_ANGLE}" | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '    "z": '
  echo "${GAZE_ANGLE}" | grep 'z:' | sed -e 's/[ ]*z:[ ]//g'
  echo '  },'

  # head_pose
  echo '  "head_pose": {'
  # head_pose > position
  echo '    "position": {'
  echo -n '      "x": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "y": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '    },'
  # head_pose > orientation
  echo '    "orientation": {'
  echo -n '      "x": ';
  echo "${HEAD_POSE}" | grep -A 3 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ','
  echo -n '      "y": ';
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '      "z": ';
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "w": '
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '    }'
  echo '  },'

  units=(
    "AU01"
    "AU02"
    "AU04"
    "AU05"
    "AU06"
    "AU07"
    "AU09"
    "AU10"
    "AU12"
    "AU14"
    "AU15"
    "AU17"
    "AU20"
    "AU23"
    "AU25"
    "AU26"
    "AU28"
    "AU45"
  )

  # action units
  echo '  "action_units": {'
  for item in "${units[@]}"; do
  echo "    \"${item}\": {"
  echo -n '      "presence": '
  echo -n "${ACTION_UNITS}" | grep A -2 "${item}" | grep 'presence' | sed -e 's/[ ]*presence:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "intensity": '
  echo "${ACTION_UNITS}" | grep A -2 "${item}" | grep 'intensity' | sed -e 's/[ ]*intensity:[ ]//g' | sed -z 's/\n//g'      
  echo ''
  echo -n '    }'
  if [ $item != 'AU45' ]; then
  echo ','
  else
  echo ''
  fi
  echo '  }'
 
  echo '}';
}

response;