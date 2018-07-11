#!/bin/bash

# vlf_test.sh
# This script will run the demo vulkaninfo with the demo_layer and capture the output.
# This layer will output all of the API names used by the application, and this script
# will search the output for a certain amount of APIs that are known to be used by this
# demo.  If the threshold is met, the test will indicate PASS, else FAILURE.

# Track unrecognized arguments.
UNRECOGNIZED=()

# Parse the command-line arguments.
while [[ $# -gt 0 ]]
do
   KEY="$1"
   case $KEY in
      -t|--tools)
      VULKAN_TOOLS_BUILD_DIR="$2"
      shift
      shift
      ;;
      *)
      UNRECOGNIZED+=("$1")
      shift
      ;;
   esac
done

# Reject unrecognized arguments.
if [[ ${#UNRECOGNIZED[@]} -ne 0 ]]; then
   echo "ERROR: Unrecognized command-line arguments: ${UNRECOGNIZED[*]}"
   exit 1
fi

if [ -z ${VULKAN_TOOLS_BUILD_DIR+x} ]; then
   echo "ERROR: Vulkan-Tools build directory is undefined."
   echo "Please set VULKAN_TOOLS_BUILD_DIR or use the -t|--tools <path> command line option."
   exit 1
fi

if [ -t 1 ] ; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    NC=''
fi

cd $(dirname "${BASH_SOURCE[0]}")

VULKANINFO="$VULKAN_TOOLS_BUILD_DIR/install/bin/vulkaninfo"
VK_ICD_FILENAMES="$VULKAN_TOOLS_BUILD_DIR/icd/VkICD_mock_icd.json"
    VK_LAYER_PATH=../layers \
    VK_INSTANCE_LAYERS=VK_LAYER_LUNARG_demo_layer \
    "$VULKANINFO" > file.tmp

printf "$GREEN[ RUN      ]$NC $0\n"
if [ -f file.tmp ]
then
    count=$(grep vkGetPhysicalDeviceFormatProperties file.tmp | wc -l)
    if [ $count -gt 50 ]
    then
        printf "$GREEN[  PASSED  ]$NC $0\n"
    else
        printf "$RED[  FAILED  ]$NC $0\n"
        rm file.tmp
        exit 1
    fi
fi

rm file.tmp

exit 0
