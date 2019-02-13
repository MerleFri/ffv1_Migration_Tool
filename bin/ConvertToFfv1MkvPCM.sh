#!/bin/bash
#read input parameter, set last and next to last parameter
in_filename="${*: -2:1}"
output_dir="${*: -1:1}"
out_filename="$(basename "$in_filename")"
out_filename_no_ext="${out_filename%.*}"
out_filepath="${output_dir}/${out_filename_no_ext}.mkv"

#create profile according to user input or set default
if [ "$#" -eq 3 ] ; then
  profile="$1"
elif [ "$#" -gt 3 ] ; then
  retval="3"
  echo "more than one custom parameter, only one allowed"
else
  profile="default"
fi

#make output directory
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir";
fi

echo "Migrating $in_filename to $out_filepath"

#select ffmpeg command line configuration according to profile
if [ $profile = "default" ]; then
  /exlibris/dps/bin/ffmpeg -nostdin -i "$in_filename" -map 0 -c:v ffv1 -level 3 -g 1 -coder 1 -context 1 -slices 16 -slicecrc 1 -c:a pcm_s24le "$out_filepath"
  retval="$?"
  echo "Default parameter is set to 16 slices"
#use custom slice parameter if valid user input
elif [ $profile = "4" ] || [ $profile = "6" ] || [ $profile = "9" ] || [ $profile = "12" ] || [ $profile = "16" ] || [ $profile = "24" ] || [ $profile = "30" ]; then
  /exlibris/dps/bin/ffmpeg -nostdin -i "$in_filename" -map 0 -c:v ffv1 -level 3 -g 1 -coder 1 -context 1 -slices $profile -slicecrc 1 -c:a pcm_s24le "$out_filepath"
  retval="$?"
  echo "Custom parameter is set to $profile slices"
#no valid user parameter parsed
else
  retval="2"
  echo "no valid custom parameter"
fi

#report the status of the migration to the log
if [ $retval == "0" ]; then
  echo "STATUS=0"
  echo "CONTENT=migration of $in_filename to $out_filepath succeeded"
else
  echo "STATUS=$retval"
  echo "CONTENT=execution failed with return code $retval"
fi

exit $retval;
