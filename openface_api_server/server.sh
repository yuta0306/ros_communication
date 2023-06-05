#!/bin/bash

function response() {
  RES=$(rostopic echo /openface2/faces -n 1);

  HEADER=$(echo "${RES}" | grep -A 5 '^header');
  LEFT_GAZE=$(echo "${RES}" | grep -A 9 'left_gaze');
  RIGHT_GAZE=$(echo "${RES}" | grep -A 9 'right_gaze');
  GAZE_ANGLE=$(echo "${RES}" | grep -A 3 'gaze_angle');
  HEAD_POSE=$(echo "${RES}" | grep -A 9 'head_pose');

  echo -e 'HTTP/1.1 200 OK\n';
  echo -e 'Content-Type: application/json\n';

  echo '{';
  echo '  "status": 200,';
  echo '  "error": null';

  echo '  "data": {';
  # left_gaze
  echo '    "left_gaze": {';
  # left_gaze > position
  echo '      "position": {';
  echo -n '        "x": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "y": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${LEFT_GAZE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '      },'
  # left_gaze > orientation
  echo '      "orientation": {';
  echo -n '        "x": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "y": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '        "w": '
  echo "${LEFT_GAZE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '      }'
  echo '    },'

  # right_gaze
  echo '    "right_gaze": {';
  # right_gaze > position
  echo '      "position": {';
  echo -n '        "x": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "y": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '      },'
  # right_gaze > orientation
  echo '      "orientation": {';
  echo -n '        "x": ';
  echo "${RIGHT_GAZE}" | grep -A 3 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ','
  echo -n '        "y": ';
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '        "w": '
  echo "${RIGHT_GAZE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '      }'
  echo '    },'

  # gaze_angle
  echo '    gaze_angle: {'
  echo -n '      "x": '
  echo "${GAZE_ANGLE}" | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "y": '
  echo "${GAZE_ANGLE}" | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '      "z": '
  echo "${GAZE_ANGLE}" | grep 'z:' | sed -e 's/[ ]*z:[ ]//g'
  echo '    },'

  # head_pose
  echo '    "head_pose": {'
  # head_pose > position
  echo '      "position": {'
  echo -n '        "x": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "y": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${HEAD_POSE}" | grep -A 3 'position' | grep 'z' | sed -e 's/[ ]*z:[ ]//g'
  echo '      },'
  # head_pose > orientation
  echo '      "orientation": {,'
  echo -n '        "x": ';
  echo "${HEAD_POSE}" | grep -A 3 'orientation' | grep 'x' | sed -e 's/[ ]*x:[ ]//g' | sed -z 's/\n//g';
  echo ','
  echo -n '        "y": ';
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'y' | sed -e 's/[ ]*y:[ ]//g' | sed -z 's/\n//g';
  echo ',';
  echo -n '        "z": ';
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'z' | sed -e 's/[ ]*z:[ ]//g' | sed -z 's/\n//g'
  echo ','
  echo -n '        "w": '
  echo "${HEAD_POSE}" | grep -A 4 'orientation' | grep 'w' | sed -e 's/[ ]*w:[ ]//g'
  echo '      }'
  echo '    }'
 
  echo '  }';

  echo '}';
}

trap exit INT

while true; do
  response | nc -l 80; sleep 5
done