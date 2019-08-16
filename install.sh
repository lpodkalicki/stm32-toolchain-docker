#!/bin/bash

IMAGE_NAME=lpodkalicki/stm32-toolchain
TOOLCHAIN_SCRIPT=stm32-toolchain

docker pull ${IMAGE_NAME}:latest

cat <<EOF > /tmp/${TOOLCHAIN_SCRIPT}.tmp
#!/bin/bash

docker run --rm --privileged -v \$(pwd):/build ${IMAGE_NAME} \$@
EOF

chmod ugo+x /tmp/${TOOLCHAIN_SCRIPT}.tmp
sudo mv /tmp/${TOOLCHAIN_SCRIPT}.tmp /usr/bin/${TOOLCHAIN_SCRIPT}
