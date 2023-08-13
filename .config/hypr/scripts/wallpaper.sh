#!/bin/bash

COLOR_FILE="$HOME/.cache/wal/colors"

applyWallpaper() {
  # Set the wallpaper using feh
  feh --bg-fill "$1" &
  swaybg -i "$1" &
}

dumpColors() {
  # Generate colors using pywal
  # -t (skip tty)  -s(skip terminals)
  wal -i "$1" -q -t -s

  echo "[color]" > $2
  echo "#" >> $2
  echo "# INDICATING COLOR" >> $2
  echo 'transparent = #00ffffff' >> $2
  echo 'disabled = #9E9E9E' >> $2
  echo 'danger = #ff0000' >> $2
  echo 'warning = #ffa500' >> $2
  echo 'success = #00ff00' >> $2
  echo "#" >> $2
  echo "# MATERIAL COLORS " >> $2
  echo "#" >> $2
  echo 'info = #00BCD4' >> $2
  echo 'red = #F44336' >> $2
  echo 'pink = #E91E63' >> $2
  echo 'green = #4CAF50' >> $2
  echo 'blue = #2196F3' >> $2
  echo 'orange = #FF9800' >> $2
  echo 'yellow = #FFEB3B' >> $2
  echo 'teal = #009688' >> $2
  echo 'cyan = #00BCD4' >> $2
  echo 'gray = #9E9E9E' >> $2
  echo 'brown = #795548' >> $2
  echo 'black = #000000' >> $2
  echo 'white = #FFFFFF' >> $2
  echo "#" >> $2
  echo "# SHADES FROM PYWAL" >> $2
  number=0
  for i in $(cat $COLOR_FILE); do
      echo "shade$number = $i" >> $2
      number=$((number+1))
  done

  source "$COLOR_FILE.sh"
  #bspc config normal_border_color "$color8"
  #bspc config focused_border_color "$color5"
  bspc config normal_border_color "#000000"
  # bspc config normal_border_color "#6B728E"
  bspc config focused_border_color "$color6"

}

# Check if the -f flag is present
if [ "$1" = "-f" ]; then
  # Check if the argument after the -f flag is a file
  if [ -f "$2" ]; then
    applyWallpaper "$2"
    # Check if the -c flag is present
    if [ "$3" = "-c" ]; then
      # Check if the argument after the -c flag is a file
      if [ -f "$4" ]; then
        dumpColors "$2" "$4"
      else
        # If the argument is not a file, print an error message
        echo "Error: $4 is not a file"
      fi
    fi
  else
    # If the argument is not a file, print an error message
    echo "Error: $2 is not a file"
  fi
# Check if the -d flag is present
elif [ "$1" = "-d" ]; then
  # Check if the argument after the -d flag is a directory
  if [ -d "$2" ]; then
    # Get a random image file from the directory
    image=$(ls "$2" | shuf -n 1)
    # Check if the image file exists
    if [ -f "$2/$image" ]; then
      applyWallpaper "$2/$image"
      # Check if the -c flag is present
      if [ "$3" = "-c" ]; then
        # Check if the argument after the -c flag is a file
        if [ -f "$4" ]; then
          dumpColors "$2/$image" "$4"
        else
          # If the argument is not a file, print an error message
          echo "Error: $4 is not a file"
        fi
      fi
    else
      # If the image file does not exist, print an error message
      echo "Error: No image files found in directory $2"
    fi
  else
    # If the argument is not a directory, print an error message
    echo "Error: $2 is not a directory"
  fi
else
  # If neither the -f or -d flag is present, print an error message
  echo "Error: missing flag. Use -f for image files or -d for directories."
fi
