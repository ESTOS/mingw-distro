#!/bin/sh

source ./0_append_distro_path.sh

extract_file glm-0.9.8.3.zip

cd $X_DISTRO_BASE
mv glm src
mkdir -p dest/include
mv src/glm dest/include
rm -rf src
mv dest glm-0.9.8.3
cd glm-0.9.8.3

7z -mx0 a ../glm-0.9.8.3.7z *
